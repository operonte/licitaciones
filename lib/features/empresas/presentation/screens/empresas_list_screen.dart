import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/enum_labels.dart';
import '../../../../core/widgets/contacto_actions.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../providers/empresas_provider.dart';
import '../../../establecimientos/presentation/providers/establecimientos_provider.dart';
import 'empresa_form_screen.dart';
import '../../../establecimientos/presentation/screens/establecimiento_form_screen.dart';
import '../../../visitas/presentation/screens/visita_form_screen.dart';
import '../../../tareas/presentation/screens/tarea_form_screen.dart';
import '../../domain/models/empresa.dart';

class EmpresasListScreen extends ConsumerStatefulWidget {
  const EmpresasListScreen({super.key});

  @override
  ConsumerState<EmpresasListScreen> createState() => _EmpresasListScreenState();
}

class _EmpresasListScreenState extends ConsumerState<EmpresasListScreen> {
  String _busqueda = '';

  @override
  Widget build(BuildContext context) {
    final empresas = ref.watch(empresasProvider);
    final filtradas = empresas.where((e) {
      if (_busqueda.isEmpty) return true;
      final q = _busqueda.toLowerCase();
      return e.razonSocial.toLowerCase().contains(q) ||
          e.rut.toLowerCase().contains(q) ||
          e.rubro.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Empresas Registradas', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre, RUT o rubro...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _busqueda = v),
            ),
          ),
          Expanded(
            child: filtradas.isEmpty
                ? _buildEmptyState(context)
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: filtradas.length,
                    itemBuilder: (context, index) => _buildEmpresaCard(context, ref, filtradas[index]),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EmpresaFormScreen())),
        label: const Text('Nueva Empresa'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmpresaCard(BuildContext context, WidgetRef ref, Empresa empresa) {
    final sucursales = ref.watch(establecimientosPorEmpresaProvider(empresa.id));

    Color stateColor = Colors.grey;
    switch (empresa.estadoRelacion) {
      case EstadoRelacion.prospecto:
        stateColor = Colors.blue;
        break;
      case EstadoRelacion.asesorado:
        stateColor = Colors.teal;
        break;
      case EstadoRelacion.enLicitacion:
        stateColor = Colors.orange;
        break;
      case EstadoRelacion.clienteActivo:
        stateColor = Colors.green;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        title: Text(empresa.razonSocial, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('RUT: ${empresa.rut} • ${empresa.rubro}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: stateColor.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
              child: Text(labelEstadoRelacion(empresa.estadoRelacion),
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: stateColor)),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EmpresaFormScreen(empresa: empresa)),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _confirmarEliminacion(context, ref, empresa),
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.all(16.0),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (empresa.notasVisita.isNotEmpty) ...[
            const Text('Notas de visita', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(empresa.notasVisita, style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
            const Divider(height: 16),
          ],
          if (empresa.contactos.isNotEmpty) ...[
            const Text('Contactos empresa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ...empresa.contactos.map((c) => ContactoActions(contacto: c)),
            const Divider(height: 16),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Establecimientos (${sucursales.length})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              TextButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EstablecimientoFormScreen(empresaId: empresa.id)),
                ),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Agregar'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Historial de Visitas', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              TextButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => VisitaFormScreen(empresaId: empresa.id)),
                ),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Nueva Visita'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tareas', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              TextButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TareaFormScreen(empresaId: empresa.id)),
                ),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Nueva Tarea'),
              ),
            ],
          ),
          const Divider(height: 16),
          if (sucursales.isEmpty)
            const Text('No hay establecimientos registrados.', style: TextStyle(color: Colors.grey, fontSize: 13, fontStyle: FontStyle.italic))
          else
            ...sucursales.map((sucursal) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(sucursal.nombreSucursal, style: const TextStyle(fontWeight: FontWeight.bold))),
                              IconButton(
                                icon: const Icon(Icons.map, size: 18),
                                tooltip: 'Abrir mapa',
                                onPressed: () => abrirMapa(context, sucursal.direccion),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, size: 18),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => EstablecimientoFormScreen(empresaId: empresa.id, establecimiento: sucursal)),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                                onPressed: () => ref.read(establecimientosProvider.notifier).eliminarEstablecimiento(sucursal.id),
                              ),
                            ],
                          ),
                          Text(sucursal.direccion, style: const TextStyle(fontSize: 12)),
                          Text('${sucursal.cantidadGuardiasEstimados} guardias estimados', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ...sucursal.contactos.map((c) => ContactoActions(contacto: c)),
                        ],
                      ),
                    ),
                  ),
                )),
        ],
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref, Empresa empresa) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Empresa'),
        content: Text('¿Eliminar "${empresa.razonSocial}" y sus sucursales y licitaciones asociadas?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              ref.read(empresasProvider.notifier).eliminarEmpresa(empresa.id);
              Navigator.pop(context);
            },
            child: const Text('ELIMINAR'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.business_center_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 20),
            Text('No hay empresas registradas', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EmpresaFormScreen())),
              icon: const Icon(Icons.add),
              label: const Text('Registrar Primera Empresa'),
            ),
          ],
        ),
      ),
    );
  }
}
