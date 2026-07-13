import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/empresas_provider.dart';
import '../../../establecimientos/presentation/providers/establecimientos_provider.dart';
import 'empresa_form_screen.dart';
import '../../domain/models/empresa.dart';

class EmpresasListScreen extends ConsumerWidget {
  const EmpresasListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final empresas = ref.watch(empresasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Empresas Registradas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: empresas.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: empresas.length,
              itemBuilder: (context, index) {
                final empresa = empresas[index];
                return _buildEmpresaCard(context, ref, empresa);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmpresaFormScreen(),
            ),
          );
        },
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
        title: Text(
          empresa.razonSocial,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Text('RUT: ${empresa.rut} ', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const Text(' • ', style: TextStyle(color: Colors.grey)),
                Text(empresa.rubro, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: stateColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                empresa.estadoRelacion.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: stateColor,
                ),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () => _confirmarEliminacion(context, ref, empresa),
        ),
        childrenPadding: const EdgeInsets.all(16.0),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Establecimientos (${sucursales.length})',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const Divider(height: 16),
          if (sucursales.isEmpty)
            const Text(
              'No hay establecimientos registrados para esta empresa.',
              style: TextStyle(color: Colors.grey, fontSize: 13, fontStyle: FontStyle.italic),
            )
          else
            ...sucursales.map((sucursal) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Card(
                    color: Colors.grey.shade50.withOpacity(0.03),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                sucursal.nombreSucursal,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.security, size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${sucursal.cantidadGuardiasEstimados} guardias',
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  sucursal.direccion,
                                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          if (sucursal.contactos.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            const Text(
                              'Contactos:',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            ...sucursal.contactos.map((contacto) => Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.person_outline, size: 12, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          '${contacto.nombre} (${contacto.cargo}) - ${contacto.telefono} - ${contacto.email}',
                                          style: const TextStyle(fontSize: 11, color: Colors.black54),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
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
        content: Text('¿Está seguro de eliminar a "${empresa.razonSocial}"? Esto también eliminará sus sucursales y licitaciones asociadas.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCELAR'),
          ),
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
            Text(
              'No hay empresas registradas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Las asesorías de seguridad nos permiten auditar a los clientes y registrar sus datos para futuras prospecciones.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade500),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmpresaFormScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Registrar Primera Empresa'),
            ),
          ],
        ),
      ),
    );
  }
}
