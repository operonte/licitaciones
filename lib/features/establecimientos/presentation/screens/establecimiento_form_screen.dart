import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../providers/establecimientos_provider.dart';
import '../../domain/models/establecimiento.dart';
import '../../../../core/widgets/contactos_form_section.dart';

class EstablecimientoFormScreen extends ConsumerStatefulWidget {
  final String empresaId;
  final Establecimiento? establecimiento;

  const EstablecimientoFormScreen({
    super.key,
    required this.empresaId,
    this.establecimiento,
  });

  @override
  ConsumerState<EstablecimientoFormScreen> createState() => _EstablecimientoFormScreenState();
}

class _EstablecimientoFormScreenState extends ConsumerState<EstablecimientoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _guardiasController = TextEditingController();
  final List<Map<String, TextEditingController>> _contactoControllers = [];

  bool get _editando => widget.establecimiento != null;

  @override
  void initState() {
    super.initState();
    final est = widget.establecimiento;
    if (est != null) {
      _nombreController.text = est.nombreSucursal;
      _direccionController.text = est.direccion;
      _guardiasController.text = est.cantidadGuardiasEstimados.toString();
      _contactoControllers.addAll(ContactosFormSection.initControllers(est.contactos));
    }
  }

  void _agregarContacto() {
    if (_contactoControllers.length < 3) {
      setState(() {
        _contactoControllers.add(ContactosFormSection.createEmptyController());
      });
    }
  }

  void _eliminarContacto(int index) {
    setState(() {
      _contactoControllers[index].forEach((_, c) => c.dispose());
      _contactoControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _direccionController.dispose();
    _guardiasController.dispose();
    ContactosFormSection.disposeControllers(_contactoControllers);
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    final contactos = ContactosFormSection.toModelList(_contactoControllers);

    final est = Establecimiento(
      localId: widget.establecimiento?.localId,
      id: widget.establecimiento?.id ?? _uuid.v4(),
      empresaId: widget.empresaId,
      nombreSucursal: _nombreController.text.trim(),
      direccion: _direccionController.text.trim(),
      cantidadGuardiasEstimados: int.tryParse(_guardiasController.text.trim()) ?? 0,
      contactos: contactos,
      isSynced: false,
      updatedAt: DateTime.now(),
    );

    await ref.read(establecimientosProvider.notifier).guardarEstablecimiento(est);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_editando ? 'Editar Sucursal' : 'Nueva Sucursal')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre sucursal *', border: OutlineInputBorder()),
              validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _direccionController,
              decoration: const InputDecoration(labelText: 'Dirección *', border: OutlineInputBorder()),
              validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _guardiasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Guardias estimados', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ContactosFormSection(
              controllers: _contactoControllers,
              onAdd: _agregarContacto,
              onRemove: _eliminarContacto,
              title: 'Contactos en Establecimiento',
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _guardar, child: Text(_editando ? 'ACTUALIZAR' : 'GUARDAR')),
          ],
        ),
      ),
    );
  }
}
