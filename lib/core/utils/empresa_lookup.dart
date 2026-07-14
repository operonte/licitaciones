import '../../features/empresas/domain/models/empresa.dart';

String nombreEmpresa(List<Empresa> empresas, String empresaId) {
  final empresa = empresas.where((e) => e.id == empresaId).firstOrNull;
  return empresa?.razonSocial ?? 'Empresa no encontrada';
}
