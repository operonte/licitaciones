import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../providers/establecimientos_provider.dart';
import '../../domain/models/establecimiento.dart';
import '../../domain/models/contacto.dart';

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
      for (final c in est.contactos) {
        _contactoControllers.add({
          'nombre': TextEditingController(text: c.nombre ?? ''),
          'cargo': TextEditingController(text: c.cargo ?? ''),
          'telefono': TextEditingController(text: c.telefono ?? ''),
          'email': TextEditingController(text: c.email ?? ''),
        });
      }
    }
  }

  void _agregarContacto() {
    if (_contactoControllers.length < 3) {
      setState(() {
        _contactoControllers.add({
          'nombre': TextEditingController(),
          'cargo': TextEditingController(),
          'telefono': TextEditingController(),
          'email': TextEditingController(),
        });
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
    for (final c in _contactoControllers) {
      c.forEach((_, ctrl) => ctrl.dispose());
    }
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    final contactos = _contactoControllers
        .where((c) => c['nombre']!.text.trim().isNotEmpty)
        .map((c) => Contacto(
              nombre: c['nombre']!.text.trim(),
              cargo: c['cargo']!.text.trim(),
              telefono: c['telefono']!.text.trim(),
              email: c['email']!.text.trim(),
            ))
        .toList();

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Contactos', style: TextStyle(fontWeight: FontWeight.bold)),
                if (_contactoControllers.length < 3)
                  TextButton.icon(onPressed: _agregarContacto, icon: const Icon(Icons.add), label: const Text('Agregar')),
              ],
            ),
            ..._contactoControllers.asMap().entries.map((entry) {
              final i = entry.key;
              final c = entry.value;
              return Card(
                margin: const EdgeInsets.only(top: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Contacto #${i + 1}'),
                          IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _eliminarContacto(i)),
                        ],
                      ),
                      TextFormField(controller: c['nombre'], decoration: const InputDecoration(labelText: 'Nombre')),
                      TextFormField(controller: c['cargo'], decoration: const InputDecoration(labelText: 'Cargo')),
                      TextFormField(controller: c['telefono'], decoration: const InputDecoration(labelText: 'Teléfono')),
                      TextFormField(controller: c['email'], decoration: const InputDecoration(labelText: 'Email')),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _guardar, child: Text(_editando ? 'ACTUALIZAR' : 'GUARDAR')),
          ],
        ),
      ),
    );
  }
}
