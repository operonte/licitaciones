import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../features/empresas/domain/models/empresa.dart';
import '../../features/licitaciones/domain/models/licitacion.dart';
import '../../features/visitas/domain/models/visita.dart';
import '../../features/tareas/domain/models/tarea.dart';
import '../utils/enum_labels.dart';
import '../utils/date_utils.dart';

class ExportService {
  static Future<void> exportEmpresasToCSV(List<Empresa> empresas) async {
    final List<List<String>> rows = [
      ['Razón Social', 'RUT', 'Rubro', 'Estado', 'Fecha Registro', 'Notas Visita'],
      ...empresas.map((empresa) => [
        empresa.razonSocial,
        empresa.rut,
        empresa.rubro,
        labelEstadoRelacion(empresa.estadoRelacion),
        formatFecha(empresa.fechaRegistro),
        empresa.notasVisita,
      ]),
    ];

    final csvData = const ListToCsvConverter().convert(rows);
    await _shareCSVFile('empresas_export.csv', csvData);
  }

  static Future<void> exportLicitacionesToCSV(List<Licitacion> licitaciones, Map<String, String> empresasMap) async {
    final List<List<String>> rows = [
      ['Título', 'Empresa', 'Fecha Publicación', 'Fecha Límite', 'Presupuesto', 'Estado', 'Días Alerta'],
      ...licitaciones.map((licitacion) => [
        licitacion.titulo,
        empresasMap[licitacion.empresaId] ?? 'Desconocida',
        formatFecha(licitacion.fechaPublicacion),
        formatFecha(licitacion.fechaLimiteEntrega),
        licitacion.presupuestoEstimado?.toString() ?? 'N/A',
        labelEstadoLicitacion(licitacion.estado),
        licitacion.diasAnticipacionAlerta.toString(),
      ]),
    ];

    final csvData = const ListToCsvConverter().convert(rows);
    await _shareCSVFile('licitaciones_export.csv', csvData);
  }

  static Future<void> exportVisitasToCSV(List<Visita> visitas, Map<String, String> empresasMap) async {
    final List<List<String>> rows = [
      ['Empresa', 'Fecha Visita', 'Tipo', 'Resultado', 'Próxima Visita', 'Notas', 'Temas Tratados', 'Compromisos'],
      ...visitas.map((visita) => [
        empresasMap[visita.empresaId] ?? 'Desconocida',
        formatFecha(visita.fechaVisita),
        labelTipoVisita(visita.tipoVisita),
        labelResultadoVisita(visita.resultado),
        visita.proximaVisitaAgendada != null ? formatFecha(visita.proximaVisitaAgendada!) : 'No agendada',
        visita.notas,
        visita.temasTratados.join('; '),
        visita.compromisos.join('; '),
      ]),
    ];

    final csvData = const ListToCsvConverter().convert(rows);
    await _shareCSVFile('visitas_export.csv', csvData);
  }

  static Future<void> exportTareasToCSV(List<Tarea> tareas, Map<String, String> empresasMap) async {
    final List<List<String>> rows = [
      ['Título', 'Empresa', 'Descripción', 'Fecha Vencimiento', 'Prioridad', 'Categoría', 'Estado', 'Fecha Registro'],
      ...tareas.map((tarea) => [
        tarea.titulo,
        empresasMap[tarea.empresaId] ?? 'Desconocida',
        tarea.descripcion,
        formatFecha(tarea.fechaVencimiento),
        labelPrioridadTarea(tarea.prioridad),
        labelCategoriaTarea(tarea.categoria),
        labelEstadoTarea(tarea.estado),
        formatFecha(tarea.fechaRegistro),
      ]),
    ];

    final csvData = const ListToCsvConverter().convert(rows);
    await _shareCSVFile('tareas_export.csv', csvData);
  }

  static Future<void> _shareCSVFile(String filename, String csvData) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$filename';
    final file = File(path);
    await file.writeAsString(csvData);

    await Share.shareXFiles([XFile(path)], text: 'Exportar $filename');
  }
}
