import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/licitaciones_provider.dart';
import '../../../empresas/presentation/providers/empresas_provider.dart';
import 'licitacion_form_screen.dart';
import '../../domain/models/licitacion.dart';

class LicitacionesListScreen extends ConsumerWidget {
  const LicitacionesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final licitaciones = ref.watch(licitacionesProvider);
    final empresas = ref.watch(empresasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Licitaciones de Seguridad',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: licitaciones.isEmpty
          ? _buildEmptyState(context, empresas.isNotEmpty)
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: licitaciones.length,
              itemBuilder: (context, index) {
                final lic = licitaciones[index];
                // Buscar empresa asociada
                final empresa = empresas.firstWhere(
                  (e) => e.id == lic.empresaId,
                  orElse: () => empresas.firstWhere(
                    (e) => e.id == lic.empresaId,
                    orElse: () => throw Exception('Empresa no encontrada'),
                  ),
                );
                return _buildLicitacionCard(context, ref, lic, empresa.razonSocial);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (empresas.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Debe registrar al menos una Empresa para asociar una licitación.'),
                backgroundColor: Colors.orange,
              ),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LicitacionFormScreen(),
            ),
          );
        },
        label: const Text('Nueva Licitación'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLicitacionCard(BuildContext context, WidgetRef ref, Licitacion lic, String empresaNombre) {
    Color badgeColor = Colors.grey;
    switch (lic.estado) {
      case EstadoLicitacion.proxima:
        badgeColor = Colors.blue;
        break;
      case EstadoLicitacion.activa:
        badgeColor = Colors.green;
        break;
      case EstadoLicitacion.presentada:
        badgeColor = Colors.purple;
        break;
      case EstadoLicitacion.ganada:
        badgeColor = Colors.teal;
        break;
      case EstadoLicitacion.perdida:
        badgeColor = Colors.red;
        break;
    }

    final diasRestantes = lic.fechaLimiteEntrega.difference(DateTime.now()).inDays;
    final esAlerta = (lic.estado == EstadoLicitacion.proxima || lic.estado == EstadoLicitacion.activa) &&
        diasRestantes <= lic.diasAnticipacionAlerta &&
        diasRestantes >= 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: esAlerta ? BorderSide(color: Colors.red.shade300, width: 1.5) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lic.titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                  onPressed: () => _confirmarEliminacion(context, ref, lic),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Empresa: $empresaNombre',
              style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    lic.estado.name.toUpperCase(),
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: badgeColor),
                  ),
                ),
                const SizedBox(width: 8),
                if (lic.presupuestoEstimado != null)
                  Text(
                    'Presupuesto: \$${lic.presupuestoEstimado!.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Publicación: ${_formatFecha(lic.fechaPublicacion)}',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    Text(
                      'Límite de Entrega: ${_formatFecha(lic.fechaLimiteEntrega)}',
                      style: TextStyle(
                        fontSize: 11,
                        color: esAlerta ? Colors.red.shade800 : Colors.black87,
                        fontWeight: esAlerta ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: esAlerta ? Colors.red.shade50 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    diasRestantes < 0
                        ? 'Plazo Vencido'
                        : (diasRestantes == 0
                            ? 'Vence Hoy'
                            : 'Faltan $diasRestantes días'),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: esAlerta
                          ? Colors.red.shade800
                          : (diasRestantes < 0 ? Colors.grey : Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref, Licitacion lic) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Licitación'),
        content: Text('¿Está seguro de eliminar la licitación "${lic.titulo}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCELAR'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              ref.read(licitacionesProvider.notifier).eliminarLicitacion(lic.id);
              Navigator.pop(context);
            },
            child: const Text('ELIMINAR'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool tieneEmpresas) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 20),
            Text(
              'No hay licitaciones registradas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Las licitaciones nos indican las fechas clave para prospectar nuestros servicios de seguridad y guardias de manera oportuna.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade500),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                if (!tieneEmpresas) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Debe registrar primero una Empresa.'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LicitacionFormScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Registrar Primera Licitación'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatFecha(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
