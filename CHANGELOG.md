# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

## [1.1.0] - 2026-07-13

### Agregado
- ✨ **Gestión de Contactos:** Registrar hasta 3 contactos por empresa
- 📞 Campos: nombre, cargo/puesto, teléfono, email
- 🎨 UI mejorada en formulario de empresas con sección dedicada a contactos
- ⚡ Soporte para añadir/editar/eliminar contactos en tiempo real

### Mejorado
- Limpieza de código: eliminada pantalla innecesaria (Licitaciones ya ordena por fecha)
- Validaciones mejoradas en formularios

## [0.1.0] - 2026-07-13

### Agregado
- 🎉 **Primera release:** Versión inicial funcional
- Dashboard con resumen de licitaciones próximas y estado comercial
- Gestión completa de empresas (crear, editar, eliminar)
- Gestión de establecimientos con contactos
- Sistema de licitaciones con filtrado y búsqueda
- Base de datos local con Isar
- State management con Riverpod
- Tests unitarios y de widgets
- Workflow de CI/CD en GitHub Actions
- APK debug publicada en Releases

### Infraestructura
- GitHub Actions workflow para análisis, tests y builds
- Configuración de firma Android (key.properties)
- Documentación completa en README y IMPROVEMENTS

### Conocido (Limitaciones)
- Solo APK debug disponible (no release firmado)
- Sin autenticación de usuario
- Datos almacenados localmente (sin sincronización cloud)
- Sin internacionalización (solo español)
- Iconos y splash screen con branding por defecto (Flutter)

---

## [Próximas Mejoras Planeadas]

- [ ] APK/AAB release firmado para Play Store
- [ ] Integración con Firebase (Analytics, Crashlytics)
- [ ] Autenticación y multi-usuario
- [ ] Backup y sincronización en la nube
- [ ] Internacionalización (i18n)
- [ ] Mejoras de accesibilidad
- [ ] Encriptación de datos sensibles

---

Formato basado en [Keep a Changelog](https://keepachangelog.com/).
