import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/enum_labels.dart';
import '../providers/empresas_provider.dart';
import '../../../establecimientos/presentation/providers/establecimientos_provider.dart';
import '../../domain/models/empresa.dart';
import '../../../establecimientos/domain/models/establecimiento.dart';
import '../../../../core/widgets/contactos_form_section.dart';

class EmpresaFormScreen extends ConsumerStatefulWidget {
  final Empresa? empresa;

  const EmpresaFormScreen({super.key, this.empresa});

  @override
  ConsumerState<EmpresaFormScreen> createState() => _EmpresaFormScreenState();
}

class _EmpresaFormScreenState extends ConsumerState<EmpresaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  // Controllers for Empresa
  final _razonSocialController = TextEditingController();
  final _rutController = TextEditingController();
  final _rubroController = TextEditingController();
  final _notasController = TextEditingController();
  EstadoRelacion _estadoRelacionSelected = EstadoRelacion.prospecto;

  bool get _editando => widget.empresa != null;

  // Contactos de Empresa (máximo 3)
  final List<Map<String, TextEditingController>> _contactosEmpresaControllers = [];

  // Sucursal section toggle
  bool _agregarSucursal = false;

  // Controllers for Establecimiento
  final _nombreSucursalController = TextEditingController();
  final _direccionController = TextEditingController();
  final _guardiasController = TextEditingController();

  // Dynamic Contact list for Establecimiento (máximo 3)
  final List<Map<String, TextEditingController>> _contactoControllers = [];

  @override
  void initState() {
    super.initState();
    final e = widget.empresa;
    if (e != null) {
      _razonSocialController.text = e.razonSocial;
      _rutController.text = e.rut;
      _rubroController.text = e.rubro;
      _notasController.text = e.notasVisita;
      _estadoRelacionSelected = e.estadoRelacion;
      _contactosEmpresaControllers.addAll(ContactosFormSection.initControllers(e.contactos));
    }
  }

  void _agregarNuevoContactoEmpresa() {
    if (_contactosEmpresaControllers.length < 3) {
      setState(() {
        _contactosEmpresaControllers.add(ContactosFormSection.createEmptyController());
      });
    }
  }

  void _eliminarContactoEmpresa(int index) {
    setState(() {
      _contactosEmpresaControllers[index].forEach((key, controller) => controller.dispose());
      _contactosEmpresaControllers.removeAt(index);
    });
  }

  void _agregarNuevoContacto() {
    if (_contactoControllers.length < 3) {
      setState(() {
        _contactoControllers.add(ContactosFormSection.createEmptyController());
      });
    }
  }

  void _eliminarContacto(int index) {
    setState(() {
      _contactoControllers[index].forEach((key, controller) => controller.dispose());
      _contactoControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    _razonSocialController.dispose();
    _rutController.dispose();
    _rubroController.dispose();
    _notasController.dispose();
    _nombreSucursalController.dispose();
    _direccionController.dispose();
    _guardiasController.dispose();
    ContactosFormSection.disposeControllers(_contactosEmpresaControllers);
    ContactosFormSection.disposeControllers(_contactoControllers);
    super.dispose();
  }

  void _guardarFormulario() async {
    if (!_formKey.currentState!.validate()) return;

    final empresaId = widget.empresa?.id ?? _uuid.v4();

    // Extraer contactos de empresa
    final contactosEmpresa = ContactosFormSection.toModelList(_contactosEmpresaControllers);

    // 1. Guardar Empresa con contactos
    final nuevaEmpresa = Empresa(
      localId: widget.empresa?.localId,
      id: empresaId,
      razonSocial: _razonSocialController.text.trim(),
      rut: _rutController.text.trim(),
      rubro: _rubroController.text.trim(),
      estadoRelacion: _estadoRelacionSelected,
      fechaRegistro: widget.empresa?.fechaRegistro ?? DateTime.now(),
      contactos: contactosEmpresa,
      notasVisita: _notasController.text.trim(),
      isSynced: false,
      updatedAt: DateTime.now(),
    );

    await ref.read(empresasProvider.notifier).guardarEmpresa(nuevaEmpresa);

    // 2. Guardar Establecimiento si está habilitado (solo en creación)
    if (_agregarSucursal && !_editando) {
      final contactosList = ContactosFormSection.toModelList(_contactoControllers);

      final nuevoEstablecimiento = Establecimiento(
        id: _uuid.v4(),
        empresaId: empresaId,
        nombreSucursal: _nombreSucursalController.text.trim(),
        direccion: _direccionController.text.trim(),
        cantidadGuardiasEstimados: int.tryParse(_guardiasController.text.trim()) ?? 0,
        contactos: contactosList,
        isSynced: false,
        updatedAt: DateTime.now(),
      );

      await ref.read(establecimientosProvider.notifier).guardarEstablecimiento(nuevoEstablecimiento);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Empresa guardada exitosamente!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar Empresa' : 'Registrar Empresa'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Sección Empresa
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Datos de la Empresa',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _razonSocialController,
                      decoration: const InputDecoration(
                        labelText: 'Razón Social *',
                        prefixIcon: Icon(Icons.business),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Ingrese la razón social' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _rutController,
                      decoration: const InputDecoration(
                        labelText: 'RUT o NIT *',
                        prefixIcon: Icon(Icons.badge),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Ingrese el RUT o identificación' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _rubroController,
                      decoration: const InputDecoration(
                        labelText: 'Rubro / Actividad *',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty ? 'Ingrese el rubro de la empresa' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<EstadoRelacion>(
                      value: _estadoRelacionSelected,
                      decoration: const InputDecoration(
                        labelText: 'Estado de la Relación',
                        prefixIcon: Icon(Icons.handshake),
                        border: OutlineInputBorder(),
                      ),
                      items: EstadoRelacion.values.map((estado) {
                        return DropdownMenuItem(
                          value: estado,
                          child: Text(labelEstadoRelacion(estado)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _estadoRelacionSelected = val;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Sección Contactos de Empresa (máximo 3)
            ContactosFormSection(
              controllers: _contactosEmpresaControllers,
              onAdd: _agregarNuevoContactoEmpresa,
              onRemove: _eliminarContactoEmpresa,
              title: 'Contactos de Empresa',
            ),

            const SizedBox(height: 16),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _notasController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Notas de visita y seguimiento',
                    hintText: 'Anota conversaciones, compromisos, próximos pasos...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Toggle para Sucursal
            if (!_editando)
            SwitchListTile(
              title: const Text(
                'Agregar Establecimiento (Sucursal) inicial',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Registra una instalación para auditar de inmediato.'),
              value: _agregarSucursal,
              onChanged: (val) {
                setState(() {
                  _agregarSucursal = val;
                });
              },
            ),

            const SizedBox(height: 8),

            // Sección Establecimiento (Sucursal)
            if (_agregarSucursal)
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Datos del Establecimiento',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nombreSucursalController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre de la Sucursal *',
                          prefixIcon: Icon(Icons.storefront),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => _agregarSucursal && (value == null || value.trim().isEmpty)
                            ? 'Ingrese el nombre de la sucursal'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _direccionController,
                        decoration: const InputDecoration(
                          labelText: 'Dirección Completa *',
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => _agregarSucursal && (value == null || value.trim().isEmpty)
                            ? 'Ingrese la dirección'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _guardiasController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Cantidad Guardias Estimados',
                          prefixIcon: Icon(Icons.security),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (_agregarSucursal && value != null && value.isNotEmpty) {
                            if (int.tryParse(value) == null) {
                              return 'Ingrese un número válido';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      ContactosFormSection(
                        controllers: _contactoControllers,
                        onAdd: _agregarNuevoContacto,
                        onRemove: _eliminarContacto,
                        title: 'Contactos en Sucursal',
                        isRequired: _agregarSucursal,
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _guardarFormulario,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                _editando ? 'ACTUALIZAR EMPRESA' : 'GUARDAR EMPRESA',
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
