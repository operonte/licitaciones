import '../../features/empresas/domain/models/empresa.dart';
import '../../features/licitaciones/domain/models/licitacion.dart';
import '../../features/visitas/domain/models/visita.dart';
import '../../features/tareas/domain/models/tarea.dart';

String labelEstadoRelacion(EstadoRelacion estado) {
  switch (estado) {
    case EstadoRelacion.prospecto:
      return 'Prospecto';
    case EstadoRelacion.asesorado:
      return 'Asesorado';
    case EstadoRelacion.enLicitacion:
      return 'En licitación';
    case EstadoRelacion.clienteActivo:
      return 'Cliente activo';
  }
}

String labelEstadoLicitacion(EstadoLicitacion estado) {
  switch (estado) {
    case EstadoLicitacion.proxima:
      return 'Próxima';
    case EstadoLicitacion.activa:
      return 'Activa';
    case EstadoLicitacion.presentada:
      return 'Presentada';
    case EstadoLicitacion.ganada:
      return 'Ganada';
    case EstadoLicitacion.perdida:
      return 'Perdida';
  }
}

String labelTipoVisita(TipoVisita tipo) {
  switch (tipo) {
    case TipoVisita.primera:
      return 'Primera visita';
    case TipoVisita.seguimiento:
      return 'Seguimiento';
    case TipoVisita.cierre:
      return 'Cierre';
    case TipoVisita.postVenta:
      return 'Post-venta';
  }
}

String labelResultadoVisita(ResultadoVisita resultado) {
  switch (resultado) {
    case ResultadoVisita.interesado:
      return 'Interesado';
    case ResultadoVisita.noInteresado:
      return 'No interesado';
    case ResultadoVisita.pendiente:
      return 'Pendiente';
    case ResultadoVisita.contratoFirmado:
      return 'Contrato firmado';
  }
}

String labelPrioridadTarea(PrioridadTarea prioridad) {
  switch (prioridad) {
    case PrioridadTarea.baja:
      return 'Baja';
    case PrioridadTarea.media:
      return 'Media';
    case PrioridadTarea.alta:
      return 'Alta';
  }
}

String labelCategoriaTarea(CategoriaTarea categoria) {
  switch (categoria) {
    case CategoriaTarea.llamada:
      return 'Llamada';
    case CategoriaTarea.email:
      return 'Email';
    case CategoriaTarea.visita:
      return 'Visita';
    case CategoriaTarea.documento:
      return 'Documento';
    case CategoriaTarea.otro:
      return 'Otro';
  }
}

String labelEstadoTarea(EstadoTarea estado) {
  switch (estado) {
    case EstadoTarea.pendiente:
      return 'Pendiente';
    case EstadoTarea.enProgreso:
      return 'En progreso';
    case EstadoTarea.completada:
      return 'Completada';
    case EstadoTarea.cancelada:
      return 'Cancelada';
  }
}
