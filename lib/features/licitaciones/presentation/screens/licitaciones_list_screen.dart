import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/enum_labels.dart';
import '../../../../core/utils/empresa_lookup.dart';
import '../providers/licitaciones_provider.dart';
import '../../../empresas/presentation/providers/empresas_provider.dart';
import 'licitacion_form_screen.dart';
import '../../domain/models/licitacion.dart';

class LicitacionesListScreen extends ConsumerStatefulWidget {
  const LicitacionesListScreen({super.key});

  @override
  ConsumerState<LicitacionesListScreen> createState() => _LicitacionesListScreenState();
}

class _LicitacionesListScreenState extends ConsumerState<LicitacionesListScreen> {
  String _busqueda = '';

  @override
  Widget build(BuildContext context) {
    final licitaciones = ref.watch(licitacionesProvider);
    final empresas = ref.watch(empresasProvider);

    final filtradas = licitaciones.where((lic) {
      if (_busqueda.isEmpty) return true;
      final q = _busqueda.toLowerCase();
      final empresa = nombreEmpresa(empresas, lic.empresaId).toLowerCase();
      return lic.titulo.toLowerCase().contains(q) || empresa.contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Licitaciones de Seguridad', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar por título o empresa...',
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
                      final lic = filtradas[index];
                      return _buildLicitacionCard(context, ref, lic, nombreEmpresa(empresas, lic.empresaId));
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
          Navigator.push(context, MaterialPageRoute(builder: (_) => const LicitacionFormScreen()));
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
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LicitacionFormScreen(licitacion: lic))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(lic.titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis)),
                  IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20), onPressed: () => _confirmarEliminacion(context, ref, lic)),
                ],
              ),
              Text('Empresa: $empresaNombre', style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: badgeColor.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                    child: Text(labelEstadoLicitacion(lic.estado), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: badgeColor)),
                  ),
                  const SizedBox(width: 8),
                  if (lic.presupuestoEstimado != null)
                    Text('Presupuesto: \$${lic.presupuestoEstimado!.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12)),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Publicación: ${formatFecha(lic.fechaPublicacion)}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      Text('Límite: ${formatFecha(lic.fechaLimiteEntrega)}',
                          style: TextStyle(fontSize: 11, color: esAlerta ? Colors.red.shade800 : Colors.black87, fontWeight: esAlerta ? FontWeight.bold : FontWeight.normal)),
                    ],
                  ),
                  Text(
                    diasRestantes < 0 ? 'Vencida' : (diasRestantes == 0 ? 'Vence hoy' : 'Faltan $diasRestantes días'),
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: esAlerta ? Colors.red.shade800 : Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref, Licitacion lic) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Licitación'),
        content: Text('¿Eliminar "${lic.titulo}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
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
            const Text('No hay licitaciones registradas'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                if (!tieneEmpresas) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registre una empresa primero.')));
                  return;
                }
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LicitacionFormScreen()));
              },
              icon: const Icon(Icons.add),
              label: const Text('Registrar Primera Licitación'),
            ),
          ],
        ),
      ),
    );
  }
}
