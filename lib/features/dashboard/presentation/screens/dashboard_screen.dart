import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/enum_labels.dart';
import '../../../../core/utils/empresa_lookup.dart';
import '../../../../core/utils/export_service.dart';
import '../../../empresas/presentation/providers/empresas_provider.dart';
import '../../../licitaciones/presentation/providers/licitaciones_provider.dart';
import '../../../visitas/presentation/providers/visitas_provider.dart';
import '../../../tareas/presentation/providers/tareas_provider.dart';
import '../../../licitaciones/domain/models/licitacion.dart';
import '../../../empresas/domain/models/empresa.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final empresas = ref.watch(empresasProvider);
    final proximasLicitaciones = ref.watch(proximasLicitacionesProvider);
    final visitas = ref.watch(visitasProvider);
    final tareas = ref.watch(tareasProvider);
    final tareasVencidas = ref.watch(tareasVencidasProvider);
    final proximasVisitas = ref.watch(proximasVisitasProvider);

    // Calcular métricas de negocio
    final totalEmpresas = empresas.length;
    final clientesActivos = empresas.where((e) => e.estadoRelacion == EstadoRelacion.clienteActivo).length;
    final prospectos = empresas.where((e) => e.estadoRelacion == EstadoRelacion.prospecto).length;
    final enLicitacion = empresas.where((e) => e.estadoRelacion == EstadoRelacion.enLicitacion).length;
    
    final licitacionesGanadas = empresas.isNotEmpty 
        ? (empresas.where((e) => e.estadoRelacion == EstadoRelacion.clienteActivo).length / totalEmpresas * 100).round()
        : 0;
    
    final valorPipeline = empresas.fold<double>(0, (sum, empresa) {
      if (empresa.estadoRelacion == EstadoRelacion.enLicitacion || 
          empresa.estadoRelacion == EstadoRelacion.asesorado) {
        return sum + 1; // Simplificado: cada oportunidad cuenta como 1 unidad
      }
      return sum;
    });

    // Crear mapa de empresas para exportación
    final empresasMap = {for (var e in empresas) e.id: e.razonSocial};

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Licitaciones & CRM',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (choice) async {
              switch (choice) {
                case 'export_empresas':
                  await ExportService.exportEmpresasToCSV(empresas);
                  break;
                case 'export_licitaciones':
                  await ExportService.exportLicitacionesToCSV(proximasLicitaciones, empresasMap);
                  break;
                case 'export_visitas':
                  await ExportService.exportVisitasToCSV(visitas, empresasMap);
                  break;
                case 'export_tareas':
                  await ExportService.exportTareasToCSV(tareas, empresasMap);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'export_empresas',
                child: Row(
                  children: [
                    Icon(Icons.business, size: 18),
                    SizedBox(width: 8),
                    Text('Exportar Empresas'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'export_licitaciones',
                child: Row(
                  children: [
                    Icon(Icons.assignment, size: 18),
                    SizedBox(width: 8),
                    Text('Exportar Licitaciones'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'export_visitas',
                child: Row(
                  children: [
                    Icon(Icons.directions_walk, size: 18),
                    SizedBox(width: 8),
                    Text('Exportar Visitas'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'export_tareas',
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 18),
                    SizedBox(width: 8),
                    Text('Exportar Tareas'),
                  ],
                ),
              ),
            ],
          ),
        ],
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
                      value: '$totalEmpresas',
                      icon: Icons.business,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      title: 'Clientes',
                      value: '$clientesActivos',
                      icon: Icons.handshake,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      title: 'Prospectos',
                      value: '$prospectos',
                      icon: Icons.person_search,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      title: 'En Licitación',
                      value: '$enLicitacion',
                      icon: Icons.gavel,
                      color: Colors.purple.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      title: 'Tasa Conversión',
                      value: '$licitacionesGanadas%',
                      icon: Icons.trending_up,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      title: 'Pipeline',
                      value: '$valorPipeline',
                      icon: Icons.filter_list,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 2. Alertas y Tareas Vencidas
              if (tareasVencidas.isNotEmpty) ...[
                Text(
                  '⚠️ Tareas Vencidas',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade700,
                      ),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tareasVencidas.length > 3 ? 3 : tareasVencidas.length,
                  itemBuilder: (context, index) {
                    final tarea = tareasVencidas[index];
                    final empresaNombre = nombreEmpresa(empresas, tarea.empresaId);
                    return _buildTareaVencidaTile(context, tarea, empresaNombre);
                  },
                ),
                if (tareasVencidas.length > 3)
                  TextButton(
                    onPressed: () {
                      // Navegar a pantalla de tareas
                    },
                    child: Text('Ver ${tareasVencidas.length - 3} más'),
                  ),
                const SizedBox(height: 24),
              ],

              // 3. Próximas Visitas
              if (proximasVisitas.isNotEmpty) ...[
                Text(
                  '📅 Próximas Visitas',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: proximasVisitas.length > 3 ? 3 : proximasVisitas.length,
                  itemBuilder: (context, index) {
                    final visita = proximasVisitas[index];
                    final empresaNombre = nombreEmpresa(empresas, visita.empresaId);
                    return _buildVisitaTile(context, visita, empresaNombre);
                  },
                ),
                if (proximasVisitas.length > 3)
                  TextButton(
                    onPressed: () {
                      // Navegar a pantalla de visitas
                    },
                    child: Text('Ver ${proximasVisitas.length - 3} más'),
                  ),
                const SizedBox(height: 24),
              ],

              // 4. Sección de Alertas / Próximas Licitaciones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '📜 Próximas Licitaciones',
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
                    final empresaNombre = nombreEmpresa(empresas, licitacion.empresaId);
                    return _buildLicitacionTile(context, licitacion, empresaNombre);
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

  Widget _buildTareaVencidaTile(BuildContext context, dynamic tarea, String empresaNombre) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.red.shade300, width: 1.5),
      ),
      elevation: 2,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.warning, color: Colors.white),
        ),
        title: Text(tarea.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$empresaNombre • Venció ${formatFecha(tarea.fechaVencimiento)}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _buildVisitaTile(BuildContext context, dynamic visita, String empresaNombre) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.directions_walk, color: Colors.white),
        ),
        title: Text(empresaNombre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${labelTipoVisita(visita.tipoVisita)} • ${formatFecha(visita.proximaVisitaAgendada!)}'),
        trailing: const Icon(Icons.chevron_right),
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
                          labelEstadoLicitacion(licitacion.estado),
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
                        'Límite: ${formatFecha(licitacion.fechaLimiteEntrega)}',
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
}
