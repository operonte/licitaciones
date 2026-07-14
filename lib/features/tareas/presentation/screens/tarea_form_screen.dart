import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/enum_labels.dart';
import '../providers/tareas_provider.dart';
import '../../../empresas/presentation/providers/empresas_provider.dart';
import '../../domain/models/tarea.dart';

class TareaFormScreen extends ConsumerStatefulWidget {
  final Tarea? tarea;
  final String? empresaId; // Si se pasa, se pre-selecciona la empresa

  const TareaFormScreen({super.key, this.tarea, this.empresaId});

  @override
  ConsumerState<TareaFormScreen> createState() => _TareaFormScreenState();
}

class _TareaFormScreenState extends ConsumerState<TareaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  String? _empresaIdSelected;
  PrioridadTarea _prioridadSelected = PrioridadTarea.media;
  CategoriaTarea _categoriaSelected = CategoriaTarea.otro;
  EstadoTarea _estadoSelected = EstadoTarea.pendiente;

  DateTime _fechaVencimiento = DateTime.now().add(const Duration(days: 7));

  bool get _editando => widget.tarea != null;

  @override
  void initState() {
    super.initState();
    final tarea = widget.tarea;
    if (tarea != null) {
      _empresaIdSelected = tarea.empresaId;
      _tituloController.text = tarea.titulo;
      _descripcionController.text = tarea.descripcion;
      _prioridadSelected = tarea.prioridad;
      _categoriaSelected = tarea.categoria;
      _estadoSelected = tarea.estado;
      _fechaVencimiento = tarea.fechaVencimiento;
    } else if (widget.empresaId != null) {
      _empresaIdSelected = widget.empresaId;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaVencimiento,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _fechaVencimiento = picked;
      });
    }
  }

  void _guardarTarea() async {
    if (!_formKey.currentState!.validate()) return;
    if (_empresaIdSelected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe seleccionar una Empresa'), backgroundColor: Colors.red),
      );
      return;
    }

    final nuevaTarea = Tarea(
      localId: widget.tarea?.localId,
      id: widget.tarea?.id ?? _uuid.v4(),
      empresaId: _empresaIdSelected!,
      titulo: _tituloController.text.trim(),
      descripcion: _descripcionController.text.trim(),
      fechaVencimiento: _fechaVencimiento,
      prioridad: _prioridadSelected,
      categoria: _categoriaSelected,
      estado: _estadoSelected,
      fechaRegistro: widget.tarea?.fechaRegistro ?? DateTime.now(),
    );

    await ref.read(tareasProvider.notifier).guardarTarea(nuevaTarea);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tarea guardada con éxito.'),
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

    // Seleccionar por defecto la primera empresa si hay disponibles y no hay selección
    if (_empresaIdSelected == null && empresas.isNotEmpty) {
      _empresaIdSelected = empresas.first.id;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar Tarea' : 'Nueva Tarea'),
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
                      'Datos de la Tarea',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _tituloController,
                      decoration: const InputDecoration(
                        labelText: 'Título *',
                        prefixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Ingrese el título' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descripcionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
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
                      'Configuración',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<PrioridadTarea>(
                      value: _prioridadSelected,
                      decoration: const InputDecoration(
                        labelText: 'Prioridad',
                        prefixIcon: Icon(Icons.priority_high),
                        border: OutlineInputBorder(),
                      ),
                      items: PrioridadTarea.values.map((prioridad) {
                        return DropdownMenuItem(
                          value: prioridad,
                          child: Text(labelPrioridadTarea(prioridad)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _prioridadSelected = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<CategoriaTarea>(
                      value: _categoriaSelected,
                      decoration: const InputDecoration(
                        labelText: 'Categoría',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(),
                      ),
                      items: CategoriaTarea.values.map((categoria) {
                        return DropdownMenuItem(
                          value: categoria,
                          child: Text(labelCategoriaTarea(categoria)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _categoriaSelected = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<EstadoTarea>(
                      value: _estadoSelected,
                      decoration: const InputDecoration(
                        labelText: 'Estado',
                        prefixIcon: Icon(Icons.flag),
                        border: OutlineInputBorder(),
                      ),
                      items: EstadoTarea.values.map((estado) {
                        return DropdownMenuItem(
                          value: estado,
                          child: Text(labelEstadoTarea(estado)),
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
                      'Fecha Límite',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Fecha de vencimiento'),
                      subtitle: Text(_formatFecha(_fechaVencimiento)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      onTap: () => _seleccionarFecha(context),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _guardarTarea,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                _editando ? 'ACTUALIZAR TAREA' : 'GUARDAR TAREA',
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
