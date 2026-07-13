# licitaciones

Una aplicación Flutter multiplataforma para gestionar licitaciones de seguridad, empresas y establecimientos.

## Características Principales

- 📋 **Dashboard:** Resumen de licitaciones próximas y estado comercial
- 🏢 **Gestión de Empresas:** Registrar y consultar empresas con datos de contacto
- 🏭 **Establecimientos:** Asociar establecimientos a empresas y guardar contactos
- 📜 **Licitaciones:** Crear, actualizar y gestionar licitaciones de seguridad
- 💾 **Base de Datos Local:** Isar para almacenamiento rápido y offline-first
- 🎨 **UI Responsiva:** Material Design 3 optimizado para Android e iOS

## Requisitos Previos

- Flutter 3.12.0 o superior
- Android SDK 31+ (para compilación) / minSdk 21 (en dispositivos)
- iOS 12.0+ (para compilación en Mac)
- Xcode 14+ (si compilas en macOS)
- Java 17+ (para compilación Android)

## Instalación y Setup

### 1. Clonar el Repositorio

```bash
git clone https://github.com/operonte/licitaciones.git
cd licitaciones
```

### 2. Instalar Dependencias

```bash
flutter pub get
```

### 3. Generar Código Generado (Modelos Isar)

```bash
flutter pub run build_runner build
```

Si necesitas regenerar forzadamente:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Ejecutar la App

En Android:

```bash
flutter run
```

En dispositivo iOS:

```bash
flutter run -d ios
```

En navegador (web):

```bash
flutter run -d chrome
```

## Desarrollo

### Ejecutar Tests

```bash
flutter test
```

### Análisis Estático

```bash
flutter analyze
```

### Estructura del Proyecto

```
lib/
├── main.dart               # Punto de entrada principal
├── core/
│   └── database/           # Servicios de Isar
└── features/
    ├── dashboard/          # Tab: Resumen
    ├── empresas/           # Tab: Gestión de empresas
    ├── establecimientos/   # Tab: Establecimientos
    └── licitaciones/       # Tab: Licitaciones
test/
├── database_test.dart      # Tests de BD
└── widget_test.dart        # Tests de UI
```

### Stack Tecnológico

- **Framework:** Flutter
- **State Management:** Riverpod 2.x
- **Base de Datos Local:** Isar 3.x
- **Arquitectura:** Clean Architecture con Riverpod providers

## CI/CD

Este repositorio incluye un workflow de GitHub Actions (`.github/workflows/flutter-ci.yml`) que:
1. Ejecuta `flutter analyze` en cada push/PR
2. Ejecuta tests unitarios y de widgets
3. Compila APK debug para Android
4. Compila versión web (opcional)

Los artefactos se guardan como artifacts de GitHub y están disponibles durante 5 días.

## Android: Configurar Firma Release

Para publicar la app en Google Play necesitas una keystore (firma de release).

### Opción 1: Generar Localmente

1. Generar keystore:

```bash
keytool -genkey -v -keystore release-keystore.jks -alias key -keyalg RSA -keysize 2048 -validity 10000
```

2. Mover al directorio `android/`:

```bash
mv release-keystore.jks android/
```

3. Crear `android/key.properties` copiando `android/key.properties.sample`:

```bash
cp android/key.properties.sample android/key.properties
```

4. Editar `android/key.properties` con tus valores

5. Compilar APK firmado:

```bash
flutter build apk --release
```

### Opción 2: Configurar en CI (Recomendado)

Ver `IMPROVEMENTS.md` para detalles de configuración en GitHub Actions.

**Nota:** Nunca comitees `android/key.properties` ni la keystore en el repositorio.

## Publicación

Para Play Store:
- Generar `aab`: `flutter build appbundle --release`
- Subir a Google Play Console

Para App Store:
- Generar `ipa`: `flutter build ios --release`
- Distribuir con Apple Transporter

## Documentación Adicional

- [IMPROVEMENTS.md](IMPROVEMENTS.md) — Mejoras recomendadas y checklist pre-lanzamiento
- [flutter.dev](https://docs.flutter.dev) — Documentación oficial de Flutter
- [Isar Database](https://isar.dev) — Base de datos local
- [Riverpod](https://riverpod.dev) — State management

## Licencia

Código abierto. Ver `LICENSE` para detalles.

## Contribuciones

Abre un issue o PR en [GitHub](https://github.com/operonte/licitaciones/issues)

