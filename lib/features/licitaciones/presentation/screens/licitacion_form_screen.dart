import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/enum_labels.dart';
import '../providers/licitaciones_provider.dart';
import '../../../empresas/presentation/providers/empresas_provider.dart';
import '../../domain/models/licitacion.dart';

class LicitacionFormScreen extends ConsumerStatefulWidget {
  final Licitacion? licitacion;

  const LicitacionFormScreen({super.key, this.licitacion});

  @override
  ConsumerState<LicitacionFormScreen> createState() => _LicitacionFormScreenState();
}

class _LicitacionFormScreenState extends ConsumerState<LicitacionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  // Controllers
  final _tituloController = TextEditingController();
  final _presupuestoController = TextEditingController();
  final _diasAlertaController = TextEditingController(text: '7');

  String? _empresaIdSelected;
  EstadoLicitacion _estadoSelected = EstadoLicitacion.proxima;

  DateTime _fechaPublicacion = DateTime.now();
  DateTime _fechaLimiteEntrega = DateTime.now().add(const Duration(days: 30));

  bool get _editando => widget.licitacion != null;

  @override
  void initState() {
    super.initState();
    final lic = widget.licitacion;
    if (lic != null) {
      _tituloController.text = lic.titulo;
      _presupuestoController.text = lic.presupuestoEstimado?.toString() ?? '';
      _diasAlertaController.text = lic.diasAnticipacionAlerta.toString();
      _empresaIdSelected = lic.empresaId;
      _estadoSelected = lic.estado;
      _fechaPublicacion = lic.fechaPublicacion;
      _fechaLimiteEntrega = lic.fechaLimiteEntrega;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _presupuestoController.dispose();
    _diasAlertaController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha(BuildContext context, bool esPublicacion) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: esPublicacion ? _fechaPublicacion : _fechaLimiteEntrega,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (esPublicacion) {
          _fechaPublicacion = picked;
          // Si la entrega queda antes de la publicación, la ajustamos
          if (_fechaLimiteEntrega.isBefore(_fechaPublicacion)) {
            _fechaLimiteEntrega = _fechaPublicacion.add(const Duration(days: 1));
          }
        } else {
          _fechaLimiteEntrega = picked;
        }
      });
    }
  }

  void _guardarLicitacion() async {
    if (!_formKey.currentState!.validate()) return;
    if (_empresaIdSelected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe seleccionar una Empresa'), backgroundColor: Colors.red),
      );
      return;
    }

    if (_fechaLimiteEntrega.isBefore(_fechaPublicacion)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La fecha límite debe ser posterior a la fecha de publicación.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final nuevaLicitacion = Licitacion(
      localId: widget.licitacion?.localId,
      id: widget.licitacion?.id ?? _uuid.v4(),
      empresaId: _empresaIdSelected!,
      titulo: _tituloController.text.trim(),
      fechaPublicacion: _fechaPublicacion,
      fechaLimiteEntrega: _fechaLimiteEntrega,
      presupuestoEstimado: _presupuestoController.text.trim().isNotEmpty
          ? double.tryParse(_presupuestoController.text.trim())
          : null,
      estado: _estadoSelected,
      diasAnticipacionAlerta: int.tryParse(_diasAlertaController.text.trim()) ?? 7,
      isSynced: false,
      updatedAt: DateTime.now(),
    );

    await ref.read(licitacionesProvider.notifier).guardarLicitacion(nuevaLicitacion);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Licitación registrada con éxito.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  String _formatFecha(DateTime date) => formatFecha(date);

  @override
  Widget build(BuildContext context) {
    final empresas = ref.watch(empresasProvider);

    // Seleccionar por defecto la primera empresa de la lista si hay disponibles
    if (_empresaIdSelected == null && empresas.isNotEmpty) {
      _empresaIdSelected = empresas.first.id;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar Licitación' : 'Registrar Licitación'),
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
                      'Datos de la Licitación',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _tituloController,
                      decoration: const InputDecoration(
                        labelText: 'Título de la Licitación *',
                        prefixIcon: Icon(Icons.assignment),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Ingrese el título' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _empresaIdSelected,
                      decoration: const InputDecoration(
                        labelText: 'Asociar a Empresa *',
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
                    TextFormField(
                      controller: _presupuestoController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Presupuesto Estimado (Opcional)',
                        prefixIcon: Icon(Icons.monetization_on),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value != null && value.trim().isNotEmpty) {
                          if (double.tryParse(value.trim()) == null) {
                            return 'Ingrese un número válido';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<EstadoLicitacion>(
                      value: _estadoSelected,
                      decoration: const InputDecoration(
                        labelText: 'Estado de la Licitación',
                        prefixIcon: Icon(Icons.flag),
                        border: OutlineInputBorder(),
                      ),
                      items: EstadoLicitacion.values.map((estado) {
                        return DropdownMenuItem(
                          value: estado,
                          child: Text(labelEstadoLicitacion(estado)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _estadoSelected = val;
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
                      'Plazos y Alertas',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Fecha de Publicación'),
                      subtitle: Text(_formatFecha(_fechaPublicacion)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      onTap: () => _seleccionarFecha(context, true),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: const Icon(Icons.alarm, color: Colors.orange),
                      title: const Text('Fecha Límite de Entrega'),
                      subtitle: Text(_formatFecha(_fechaLimiteEntrega)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      onTap: () => _seleccionarFecha(context, false),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _diasAlertaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Días de anticipación para alerta *',
                        prefixIcon: Icon(Icons.notification_important, color: Colors.orange),
                        border: OutlineInputBorder(),
                        helperText: 'Te avisaremos en el Dashboard esta cantidad de días antes del límite.',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Ingrese los días de anticipación';
                        }
                        if (int.tryParse(value.trim()) == null) {
                          return 'Ingrese un número válido';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _guardarLicitacion,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                _editando ? 'ACTUALIZAR LICITACIÓN' : 'REGISTRAR LICITACIÓN',
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
