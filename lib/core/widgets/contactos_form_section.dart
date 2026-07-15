import 'package:flutter/material.dart';
import '../../features/establecimientos/domain/models/contacto.dart';

/// Widget reutilizable para gestionar una lista de contactos en formularios.
/// Soporta agregar, editar y eliminar contactos con un máximo configurable (por defecto 3).
class ContactosFormSection extends StatelessWidget {
  final List<Map<String, TextEditingController>> controllers;
  final VoidCallback onAdd;
  final void Function(int) onRemove;
  final String title;
  final int maxContacts;
  final bool isRequired;

  const ContactosFormSection({
    super.key,
    required this.controllers,
    required this.onAdd,
    required this.onRemove,
    this.title = 'Contactos',
    this.maxContacts = 3,
    this.isRequired = false,
  });

  /// Helper estático para inicializar controladores a partir de una lista de Contactos de dominio.
  static List<Map<String, TextEditingController>> initControllers(List<Contacto> contactos) {
    return contactos.map((c) => {
      'nombre': TextEditingController(text: c.nombre ?? ''),
      'cargo': TextEditingController(text: c.cargo ?? ''),
      'telefono': TextEditingController(text: c.telefono ?? ''),
      'email': TextEditingController(text: c.email ?? ''),
    }).toList();
  }

  /// Helper estático para crear un mapa de controladores vacío.
  static Map<String, TextEditingController> createEmptyController() {
    return {
      'nombre': TextEditingController(),
      'cargo': TextEditingController(),
      'telefono': TextEditingController(),
      'email': TextEditingController(),
    };
  }

  /// Helper estático para hacer dispose de una lista de controladores.
  static void disposeControllers(List<Map<String, TextEditingController>> controllersList) {
    for (var contacto in controllersList) {
      contacto.forEach((key, controller) => controller.dispose());
    }
  }

  /// Helper estático para convertir los controladores en una lista de modelos de Contacto.
  static List<Contacto> toModelList(List<Map<String, TextEditingController>> controllersList) {
    return controllersList
        .where((controllers) => controllers['nombre']!.text.trim().isNotEmpty)
        .map((controllers) => Contacto(
              nombre: controllers['nombre']!.text.trim(),
              cargo: controllers['cargo']!.text.trim(),
              telefono: controllers['telefono']!.text.trim(),
              email: controllers['email']!.text.trim(),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                if (controllers.length < maxContacts)
                  TextButton.icon(
                    onPressed: onAdd,
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar'),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Máximo $maxContacts contactos',
              style: TextStyle(fontSize: 12, color: theme.brightness == Brightness.dark ? Colors.grey[400] : Colors.grey[600]),
            ),
            const Divider(),
            if (controllers.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'No hay contactos agregados.',
                  style: TextStyle(
                    color: theme.brightness == Brightness.dark ? Colors.grey[500] : Colors.grey[400],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controllers.length,
                itemBuilder: (context, index) {
                  final contactMap = controllers[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark
                          ? theme.colorScheme.surfaceContainerHighest.withOpacity(0.3)
                          : Colors.blue.shade50.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.brightness == Brightness.dark
                            ? Colors.grey.shade800
                            : Colors.blue.shade100,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Contacto #${index + 1}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => onRemove(index),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: contactMap['nombre'],
                          decoration: const InputDecoration(
                            labelText: 'Nombre *',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (isRequired || (value != null && value.trim().isNotEmpty)) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Ingrese el nombre del contacto';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: contactMap['cargo'],
                          decoration: const InputDecoration(
                            labelText: 'Cargo / Puesto *',
                            prefixIcon: Icon(Icons.work_outline),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (isRequired || (value != null && value.trim().isNotEmpty)) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Ingrese el cargo o puesto';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: contactMap['telefono'],
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Teléfono',
                            prefixIcon: Icon(Icons.phone_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: contactMap['email'],
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Ingrese un email válido';
                              }
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
