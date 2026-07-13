# Mejoras Recomendadas para la App Licitaciones

## Resumen
La app está en estado funcional básico. Se lista aquí las mejoras recomendadas agrupadas por prioridad y categoría.

---

## 🔴 Críticas (Antes de Producción)

### 1. **Configuración de Firma Release (Android)**
- **Estado:** No configurada; APK debug solo para testing
- **Acción:** Generar keystore e integrar en CI/CD (ver `android/key.properties.sample` y `README.md`)
- **Impacto:** Necesario para publicar en Google Play Store

### 2. **Actualizar Dependencias Android**
- **Estado:** `isar_flutter_libs` requiere `compileSdkVersion 36` (hoy es parche en pub-cache)
- **Acción:** Upgradar `isar_flutter_libs` a versión compatible o resolver con constraint en `pubspec.yaml`
- **Impacto:** Evitar parches locales y asegurar builds reproducibles

### 3. **Políticas de Privacidad y Términos de Servicio**
- **Estado:** No definidas
- **Acción:** Crear `PRIVACY.md` y `TERMS.md`; incluir links en la app
- **Impacto:** Requisito legal para Play Store (especialmente si se recopilan datos)

### 4. **Configuración de Permisos Android**
- **Estado:** Mínimos permisos actuales; revisar si se necesitan más
- **Acción:** Documentar y justificar cada permiso solicitado en `AndroidManifest.xml`
- **Impacto:** Confianza del usuario; Play Store puede rechazar permisos innecesarios

---

## 🟡 Importantes (Antes de Primera Publicación)

### 5. **Iconos y Splash Screen Personalizados**
- **Estado:** Existen assets por defecto (Flutter Blue)
- **Acción:** Reemplazar con logo/marca personal en:
  - `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
  - `android/app/src/main/res/mipmap-*/ic_launcher.png`
  - `web/icons/`
- **Herramientas:** `flutter_launcher_icons` package o herramientas manuales

### 6. **Información de App Store**
- **Estado:** Nombre, descripción genéricos
- **Acciones:**
  - Crear descripción detallada (300-500 palabras)
  - Captura de pantallas (mínimo 2-5)
  - Elegir categoría (p. ej. "Business", "Utilities")
  - Configurar precio
- **Impacto:** Discoverability y conversión de usuarios

### 7. **Testing en Dispositivos Reales**
- **Estado:** Solo tests unitarios/widget
- **Acción:** Testear en Android 8+ (minSdk), iOS 11+; verificar:
  - Base de datos Isar (creación, lectura, escritura)
  - Navegación entre tabs
  - Rendimiento en conexiones lentas
- **Herramientas:** Firebase Test Lab (para Android), Testflight (para iOS)

### 8. **Análisis de Performance y Monitorización**
- **Estado:** Sin instrumentación
- **Acción (Opcional pero recomendado):** Integrar
  - Firebase Analytics (gratis, rastrear UX)
  - Firebase Crashlytics (errores en producción)
  - Sentry (alternativa)

---

## 🟢 Mejoras (Post-Lanzamiento)

### 9. **Internacionalización (i18n)**
- **Estado:** Hardcoded en español
- **Acción:** Usar `flutter_localizations` + ARB para:
  - Español e Inglés (mínimo)
  - Permitir futura expansión
- **Impacto:** Alcance más amplio

### 10. **Accesibilidad (A11y)**
- **Estado:** Basic material design; sin tests específicos
- **Acción:** 
  - Verificar tamaño de texto mínimo (14pt)
  - Etiquetar inputs (Semantics)
  - Testear con screen reader (TalkBack/VoiceOver)

### 11. **Autenticación y Seguridad**
- **Estado:** Sin autenticación; base de datos local no encriptada
- **Acción:**
  - Si hay datos sensibles: encriptar Isar (usar `encryptionKey`)
  - Considerar autenticación (OAuth/Firebase Auth) si es multi-usuario

### 12. **Backup y Sincronización**
- **Estado:** Solo almacenamiento local
- **Acción (Future):** 
  - Opción de backup a cloud (Google Drive, Dropbox)
  - Sincronización multi-dispositivo

### 13. **Documentación del Código**
- **Estado:** Mínima
- **Acción:** Añadir comentarios y docstrings en:
  - Servicios de base de datos (`isar_service.dart`)
  - Providers de estado (`riverpod` notifiers)
  - Funciones complejas

### 14. **Tests de Cobertura**
- **Estado:** Tests básicos; sin reporte de cobertura
- **Acción:** Ejecutar `flutter test --coverage` y revisar cobertura
- **Objetivo:** >70% cobertura en código crítico

---

## 📋 Checklist pre-Lanzamiento

Antes de subir a Play Store/App Store:

- [ ] Keystore generada y configurada en CI
- [ ] APK/AAB release compilado sin errores
- [ ] Versión actualizada (`pubspec.yaml` version)
- [ ] Build number incremented
- [ ] Pruebas manuales en dispositivos reales (mínimo Android 8, iOS 12)
- [ ] Screenshots y descripción en tienda
- [ ] Privacidad y Términos publicados
- [ ] Notificación de cambios (CHANGELOG.md)
- [ ] AAB generado para Play Store (no APK)
- [ ] Testeado en conexiones lentas / offline
- [ ] Iconos y splash finalizados

---

## Contacto y Contribuciones

Para reportar bugs o sugerir mejoras, abre un issue en el repositorio:
https://github.com/operonte/licitaciones/issues
