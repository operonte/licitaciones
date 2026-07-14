import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/enum_labels.dart';
import '../../../../core/utils/empresa_lookup.dart';
import '../providers/visitas_provider.dart';
import '../../../empresas/presentation/providers/empresas_provider.dart';
import 'visita_form_screen.dart';
import '../../domain/models/visita.dart';

class VisitasListScreen extends ConsumerStatefulWidget {
  const VisitasListScreen({super.key});

  @override
  ConsumerState<VisitasListScreen> createState() => _VisitasListScreenState();
}

class _VisitasListScreenState extends ConsumerState<VisitasListScreen> {
  String _busqueda = '';

  @override
  Widget build(BuildContext context) {
    final visitas = ref.watch(visitasProvider);
    final empresas = ref.watch(empresasProvider);

    final filtradas = visitas.where((vis) {
      if (_busqueda.isEmpty) return true;
      final q = _busqueda.toLowerCase();
      final empresa = nombreEmpresa(empresas, vis.empresaId).toLowerCase();
      return empresa.contains(q) || vis.notas.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitas Comerciales', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar por empresa o notas...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _busqueda = v),
            ),
          ),
          Expanded(
            child: filtradas.isEmpty
                ? _buildEmptyState(context, empresas.isNotEmpty)
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: filtradas.length,
                    itemBuilder: (context, index) {
                      final vis = filtradas[index];
                      return _buildVisitaCard(context, ref, vis, nombreEmpresa(empresas, vis.empresaId));
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
          Navigator.push(context, MaterialPageRoute(builder: (_) => const VisitaFormScreen()));
        },
        label: const Text('Nueva Visita'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildVisitaCard(BuildContext context, WidgetRef ref, Visita vis, String empresaNombre) {
    Color tipoColor = Colors.grey;
    switch (vis.tipoVisita) {
      case TipoVisita.primera:
        tipoColor = Colors.blue;
        break;
      case TipoVisita.seguimiento:
        tipoColor = Colors.teal;
        break;
      case TipoVisita.cierre:
        tipoColor = Colors.orange;
        break;
      case TipoVisita.postVenta:
        tipoColor = Colors.green;
        break;
    }

    Color resultadoColor = Colors.grey;
    switch (vis.resultado) {
      case ResultadoVisita.interesado:
        resultadoColor = Colors.green;
        break;
      case ResultadoVisita.noInteresado:
        resultadoColor = Colors.red;
        break;
      case ResultadoVisita.pendiente:
        resultadoColor = Colors.orange;
        break;
      case ResultadoVisita.contratoFirmado:
        resultadoColor = Colors.purple;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VisitaFormScreen(visita: vis))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      empresaNombre,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    onPressed: () => _confirmarEliminacion(context, ref, vis),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: tipoColor.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                    child: Text(labelTipoVisita(vis.tipoVisita), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: tipoColor)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: resultadoColor.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                    child: Text(labelResultadoVisita(vis.resultado), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: resultadoColor)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (vis.notas.isNotEmpty) ...[
                Text(
                  vis.notas,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    'Visita: ${formatFecha(vis.fechaVisita)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
              if (vis.proximaVisitaAgendada != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.event, size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      'Próxima: ${formatFecha(vis.proximaVisitaAgendada!)}',
                      style: TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref, Visita vis) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Visita'),
        content: const Text('¿Eliminar esta visita?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              ref.read(visitasProvider.notifier).eliminarVisita(vis.id);
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
            Icon(Icons.directions_walk_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 20),
            const Text('No hay visitas registradas'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                if (!tieneEmpresas) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registre una empresa primero.')));
                  return;
                }
                Navigator.push(context, MaterialPageRoute(builder: (_) => const VisitaFormScreen()));
              },
              icon: const Icon(Icons.add),
              label: const Text('Registrar Primera Visita'),
            ),
          ],
        ),
      ),
    );
  }
}
