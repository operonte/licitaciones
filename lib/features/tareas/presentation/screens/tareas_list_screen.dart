import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/enum_labels.dart';
import '../../../../core/utils/empresa_lookup.dart';
import '../providers/tareas_provider.dart';
import '../../../empresas/presentation/providers/empresas_provider.dart';
import 'tarea_form_screen.dart';
import '../../domain/models/tarea.dart';

class TareasListScreen extends ConsumerStatefulWidget {
  const TareasListScreen({super.key});

  @override
  ConsumerState<TareasListScreen> createState() => _TareasListScreenState();
}

class _TareasListScreenState extends ConsumerState<TareasListScreen> {
  String _busqueda = '';
  EstadoTarea? _filtroEstado;

  @override
  Widget build(BuildContext context) {
    final tareas = ref.watch(tareasProvider);
    final empresas = ref.watch(empresasProvider);

    final filtradas = tareas.where((tarea) {
      if (_busqueda.isEmpty && _filtroEstado == null) return true;
      
      final q = _busqueda.toLowerCase();
      final empresa = nombreEmpresa(empresas, tarea.empresaId).toLowerCase();
      final coincideBusqueda = empresa.contains(q) || tarea.titulo.toLowerCase().contains(q);
      
      final coincideEstado = _filtroEstado == null || tarea.estado == _filtroEstado;
      
      return coincideBusqueda && coincideEstado;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton<EstadoTarea?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (estado) {
              setState(() {
                _filtroEstado = estado;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('Todas'),
              ),
              ...EstadoTarea.values.map((estado) => PopupMenuItem(
                value: estado,
                child: Text(labelEstadoTarea(estado)),
              )),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar por título o empresa...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: _filtroEstado != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _filtroEstado = null),
                      )
                    : null,
              ),
              onChanged: (v) => setState(() => _busqueda = v),
            ),
          ),
          if (_filtroEstado != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Chip(
                label: Text('Filtro: ${labelEstadoTarea(_filtroEstado!)}'),
                onDeleted: () => setState(() => _filtroEstado = null),
                deleteIcon: const Icon(Icons.close),
              ),
            ),
          Expanded(
            child: filtradas.isEmpty
                ? _buildEmptyState(context, empresas.isNotEmpty)
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: filtradas.length,
                    itemBuilder: (context, index) {
                      final tarea = filtradas[index];
                      return _buildTareaCard(context, ref, tarea, nombreEmpresa(empresas, tarea.empresaId));
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (empresas.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Debe registrar al menos una Empresa.'), backgroundColor: Colors.orange),
            );
            return;
          }
          Navigator.push(context, MaterialPageRoute(builder: (_) => const TareaFormScreen()));
        },
        label: const Text('Nueva Tarea'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTareaCard(BuildContext context, WidgetRef ref, Tarea tarea, String empresaNombre) {
    Color prioridadColor = Colors.grey;
    switch (tarea.prioridad) {
      case PrioridadTarea.baja:
        prioridadColor = Colors.green;
        break;
      case PrioridadTarea.media:
        prioridadColor = Colors.orange;
        break;
      case PrioridadTarea.alta:
        prioridadColor = Colors.red;
        break;
    }

    Color estadoColor = Colors.grey;
    switch (tarea.estado) {
      case EstadoTarea.pendiente:
        estadoColor = Colors.blue;
        break;
      case EstadoTarea.enProgreso:
        estadoColor = Colors.orange;
        break;
      case EstadoTarea.completada:
        estadoColor = Colors.green;
        break;
      case EstadoTarea.cancelada:
        estadoColor = Colors.grey;
        break;
    }

    final diasRestantes = tarea.fechaVencimiento.difference(DateTime.now()).inDays;
    final esVencida = diasRestantes < 0 && (tarea.estado == EstadoTarea.pendiente || tarea.estado == EstadoTarea.enProgreso);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: esVencida ? BorderSide(color: Colors.red.shade300, width: 1.5) : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TareaFormScreen(tarea: tarea))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      tarea.titulo,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    onPressed: () => _confirmarEliminacion(context, ref, tarea),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Empresa: $empresaNombre',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: prioridadColor.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                    child: Text(labelPrioridadTarea(tarea.prioridad), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: prioridadColor)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: estadoColor.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                    child: Text(labelEstadoTarea(tarea.estado), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: estadoColor)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: Colors.blue.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                    child: Text(labelCategoriaTarea(tarea.categoria), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (tarea.descripcion.isNotEmpty) ...[
                Text(
                  tarea.descripcion,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: esVencida ? Colors.red : Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    'Vence: ${formatFecha(tarea.fechaVencimiento)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: esVencida ? Colors.red : Colors.grey.shade700,
                      fontWeight: esVencida ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    diasRestantes < 0
                        ? 'Vencida'
                        : (diasRestantes == 0 ? 'Vence hoy' : 'Faltan $diasRestantes días'),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: esVencida ? Colors.red : Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref, Tarea tarea) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Tarea'),
        content: const Text('¿Eliminar esta tarea?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              ref.read(tareasProvider.notifier).eliminarTarea(tarea.id);
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
            Icon(Icons.check_circle_outline, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 20),
            const Text('No hay tareas registradas'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                if (!tieneEmpresas) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registre una empresa primero.')));
                  return;
                }
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TareaFormScreen()));
              },
              icon: const Icon(Icons.add),
              label: const Text('Crear Primera Tarea'),
            ),
          ],
        ),
      ),
    );
  }
}
