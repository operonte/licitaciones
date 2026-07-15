import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> llamarTelefono(BuildContext context, String telefono) async {
  final uri = Uri(scheme: 'tel', path: telefono.replaceAll(' ', ''));
  if (!await launchUrl(uri)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el teléfono')),
      );
    }
  }
}

Future<void> enviarEmail(BuildContext context, String email) async {
  final uri = Uri(scheme: 'mailto', path: email);
  if (!await launchUrl(uri)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el email')),
      );
    }
  }
}

Future<void> abrirMapa(BuildContext context, String direccion) async {
  final uri = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(direccion)}',
  );
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el mapa')),
      );
    }
  }
}

Future<void> abrirWeb(BuildContext context, String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace web')),
      );
    }
  }
}
