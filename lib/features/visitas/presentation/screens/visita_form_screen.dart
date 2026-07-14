import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/enum_labels.dart';
import '../providers/visitas_provider.dart';
import '../../../empresas/presentation/providers/empresas_provider.dart';
import '../../domain/models/visita.dart';

class VisitaFormScreen extends ConsumerStatefulWidget {
  final Visita? visita;
  final String? empresaId; // Si se pasa, se pre-selecciona la empresa

  const VisitaFormScreen({super.key, this.visita, this.empresaId});

  @override
  ConsumerState<VisitaFormScreen> createState() => _VisitaFormScreenState();
}

class _VisitaFormScreenState extends ConsumerState<VisitaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  final _notasController = TextEditingController();
  final _temasTratadosController = TextEditingController();
  final _compromisosController = TextEditingController();

  String? _empresaIdSelected;
  TipoVisita _tipoVisitaSelected = TipoVisita.primera;
  ResultadoVisita _resultadoSelected = ResultadoVisita.pendiente;

  DateTime _fechaVisita = DateTime.now();
  DateTime? _proximaVisitaAgendada;

  bool get _editando => widget.visita != null;

  @override
  void initState() {
    super.initState();
    final visita = widget.visita;
    if (visita != null) {
      _empresaIdSelected = visita.empresaId;
      _tipoVisitaSelected = visita.tipoVisita;
      _resultadoSelected = visita.resultado;
      _fechaVisita = visita.fechaVisita;
      _proximaVisitaAgendada = visita.proximaVisitaAgendada;
      _notasController.text = visita.notas;
      _temasTratadosController.text = visita.temasTratados.join(', ');
      _compromisosController.text = visita.compromisos.join(', ');
    } else if (widget.empresaId != null) {
      _empresaIdSelected = widget.empresaId;
    }
  }

  @override
  void dispose() {
    _notasController.dispose();
    _temasTratadosController.dispose();
    _compromisosController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha(BuildContext context, bool esVisitaActual) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: esVisitaActual ? _fechaVisita : (_proximaVisitaAgendada ?? DateTime.now().add(const Duration(days: 7))),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (esVisitaActual) {
          _fechaVisita = picked;
        } else {
          _proximaVisitaAgendada = picked;
        }
      });
    }
  }

  void _guardarVisita() async {
    if (!_formKey.currentState!.validate()) return;
    if (_empresaIdSelected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe seleccionar una Empresa'), backgroundColor: Colors.red),
      );
      return;
    }

    final temasTratados = _temasTratadosController.text
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    final compromisos = _compromisosController.text
        .split(',')
        .map((c) => c.trim())
        .where((c) => c.isNotEmpty)
        .toList();

    final nuevaVisita = Visita(
      localId: widget.visita?.localId,
      id: widget.visita?.id ?? _uuid.v4(),
      empresaId: _empresaIdSelected!,
      fechaVisita: _fechaVisita,
      tipoVisita: _tipoVisitaSelected,
      notas: _notasController.text.trim(),
      temasTratados: temasTratados,
      resultado: _resultadoSelected,
      proximaVisitaAgendada: _proximaVisitaAgendada,
      compromisos: compromisos,
      fechaRegistro: widget.visita?.fechaRegistro ?? DateTime.now(),
      isSynced: false,
      updatedAt: DateTime.now(),
    );

    await ref.read(visitasProvider.notifier).guardarVisita(nuevaVisita);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Visita registrada con éxito.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  String _formatFecha(DateTime? date) {
    if (date == null) return 'No agendada';
    return formatFecha(date);
  }

  @override
  Widget build(BuildContext context) {
    final empresas = ref.watch(empresasProvider);

    // Seleccionar por defecto la primera empresa si hay disponibles y no hay selección
    if (_empresaIdSelected == null && empresas.isNotEmpty) {
      _empresaIdSelected = empresas.first.id;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar Visita' : 'Registrar Visita'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Datos de la Visita',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _empresaIdSelected,
                      decoration: const InputDecoration(
                        labelText: 'Empresa *',
                        prefixIcon: Icon(Icons.business),
                        border: OutlineInputBorder(),
                      ),
                      items: empresas.map((empresa) {
                        return DropdownMenuItem(
                          value: empresa.id,
                          child: Text(empresa.razonSocial),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _empresaIdSelected = val;
                        });
                      },
                      validator: (value) => value == null ? 'Seleccione una empresa' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<TipoVisita>(
                      value: _tipoVisitaSelected,
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Visita',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(),
                      ),
                      items: TipoVisita.values.map((tipo) {
                        return DropdownMenuItem(
                          value: tipo,
                          child: Text(labelTipoVisita(tipo)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _tipoVisitaSelected = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<ResultadoVisita>(
                      value: _resultadoSelected,
                      decoration: const InputDecoration(
                        labelText: 'Resultado',
                        prefixIcon: Icon(Icons.flag),
                        border: OutlineInputBorder(),
                      ),
                      items: ResultadoVisita.values.map((resultado) {
                        return DropdownMenuItem(
                          value: resultado,
                          child: Text(labelResultadoVisita(resultado)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _resultadoSelected = val;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fechas',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Fecha de la Visita'),
                      subtitle: Text(_formatFecha(_fechaVisita)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      onTap: () => _seleccionarFecha(context, true),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: const Icon(Icons.event, color: Colors.orange),
                      title: const Text('Próxima Visita Agendada'),
                      subtitle: Text(_formatFecha(_proximaVisitaAgendada)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_proximaVisitaAgendada != null)
                            IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                setState(() {
                                  _proximaVisitaAgendada = null;
                                });
                              },
                            ),
                          const Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                      onTap: () => _seleccionarFecha(context, false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detalles de la Visita',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _notasController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Notas de la visita',
                        hintText: 'Describe conversaciones, impresiones, etc...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _temasTratadosController,
                      decoration: const InputDecoration(
                        labelText: 'Temas tratados',
                        hintText: 'Separados por coma (ej: seguridad, presupuesto, fechas)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _compromisosController,
                      decoration: const InputDecoration(
                        labelText: 'Compromisos',
                        hintText: 'Separados por coma (ej: enviar propuesta, llamar martes)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _guardarVisita,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                _editando ? 'ACTUALIZAR VISITA' : 'REGISTRAR VISITA',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
