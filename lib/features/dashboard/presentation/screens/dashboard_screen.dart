import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../empresas/presentation/providers/empresas_provider.dart';
import '../../../establecimientos/presentation/providers/establecimientos_provider.dart';
import '../../../licitaciones/presentation/providers/licitaciones_provider.dart';
import '../../../licitaciones/domain/models/licitacion.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final empresas = ref.watch(empresasProvider);
    final establecimientos = ref.watch(establecimientosProvider);
    final proximasLicitaciones = ref.watch(proximasLicitacionesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Licitaciones & CRM',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Tarjetas de Resumen
              Text(
                'Resumen Comercial',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      title: 'Empresas',
                      value: '${empresas.length}',
                      icon: Icons.business,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      title: 'Sucursales',
                      value: '${establecimientos.length}',
                      icon: Icons.storefront,
                      color: Colors.teal.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildStatCard(
                context,
                title: 'Licitaciones Activas / Próximas',
                value: '${proximasLicitaciones.length}',
                icon: Icons.notifications_active,
                color: Colors.orange.shade800,
                isFullWidth: true,
              ),

              const SizedBox(height: 24),

              // 2. Sección de Alertas / Próximas Licitaciones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Próximas Licitaciones',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (proximasLicitaciones.isNotEmpty)
                    const Icon(Icons.arrow_downward, size: 18, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 12),

              if (proximasLicitaciones.isEmpty)
                _buildEmptyState(context)
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: proximasLicitaciones.length,
                  itemBuilder: (context, index) {
                    final licitacion = proximasLicitaciones[index];
                    // Buscar empresa asociada
                    final empresa = empresas.firstWhere(
                      (e) => e.id == licitacion.empresaId,
                      orElse: () => empresas.firstWhere(
                        (e) => e.id == licitacion.empresaId,
                        orElse: () => throw Exception('Empresa no encontrada'),
                      ),
                    );

                    return _buildLicitacionTile(context, licitacion, empresa.razonSocial);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    bool isFullWidth = false,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.05), color.withOpacity(0.15)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLicitacionTile(BuildContext context, Licitacion licitacion, String empresaNombre) {
    final diasRestantes = licitacion.fechaLimiteEntrega.difference(DateTime.now()).inDays;
    final esAlerta = diasRestantes <= licitacion.diasAnticipacionAlerta;

    Color badgeColor = Colors.grey;
    IconData alertIcon = Icons.info_outline;

    switch (licitacion.estado) {
      case EstadoLicitacion.proxima:
        badgeColor = Colors.blue;
        alertIcon = Icons.calendar_today;
        break;
      case EstadoLicitacion.activa:
        badgeColor = Colors.green;
        alertIcon = Icons.play_arrow;
        break;
      default:
        break;
    }

    if (esAlerta && diasRestantes >= 0) {
      badgeColor = Colors.red.shade700;
      alertIcon = Icons.warning_amber_rounded;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: esAlerta && diasRestantes >= 0
            ? BorderSide(color: Colors.red.shade300, width: 1.5)
            : BorderSide.none,
      ),
      elevation: esAlerta ? 3 : 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: badgeColor.withOpacity(0.1),
              child: Icon(alertIcon, color: badgeColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          licitacion.titulo,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: badgeColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          licitacion.estado.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: badgeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Empresa: $empresaNombre',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Límite: ${_formatFecha(licitacion.fechaLimiteEntrega)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: esAlerta && diasRestantes >= 0 ? Colors.red.shade800 : Colors.grey.shade700,
                          fontWeight: esAlerta && diasRestantes >= 0 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      Text(
                        diasRestantes < 0
                            ? 'Vencida'
                            : (diasRestantes == 0
                                ? '¡Vence Hoy!'
                                : 'Quedan $diasRestantes días'),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: diasRestantes < 0
                              ? Colors.grey
                              : (esAlerta ? Colors.red.shade800 : Colors.grey.shade800),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            Icon(Icons.assignment_turned_in_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No hay licitaciones próximas activas',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Registra una empresa y asóciale su primera licitación de seguridad.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade500),
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
