import 'package:flutter/material.dart';
import '../../features/establecimientos/domain/models/contacto.dart';
import '../utils/url_launcher_helper.dart';

class ContactoActions extends StatelessWidget {
  final Contacto contacto;

  const ContactoActions({super.key, required this.contacto});

  @override
  Widget build(BuildContext context) {
    final telefono = contacto.telefono?.trim() ?? '';
    final email = contacto.email?.trim() ?? '';

    return Row(
      children: [
        Expanded(
          child: Text(
            '${contacto.nombre ?? ''} (${contacto.cargo ?? ''})',
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (telefono.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.phone, size: 18),
            tooltip: 'Llamar',
            onPressed: () => llamarTelefono(context, telefono),
          ),
        if (email.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.email, size: 18),
            tooltip: 'Email',
            onPressed: () => enviarEmail(context, email),
          ),
      ],
    );
  }
}
