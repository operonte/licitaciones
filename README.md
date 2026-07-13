# licitaciones

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Android: Generar Release Keystore y firma

Para publicar la app en Google Play necesitas una keystore (firma de release). Pasos rápidos:

1. Generar keystore localmente (ejemplo):

```bash
keytool -genkey -v -keystore release-keystore.jks -alias key -keyalg RSA -keysize 2048 -validity 10000
```

2. Mover el `release-keystore.jks` al directorio `android/` o donde prefieras (en el ejemplo usamos `android/release-keystore.jks`).

3. Crear `android/key.properties` (NO comitear) con este contenido, basado en `android/key.properties.sample`:

```properties
storeFile=../release-keystore.jks
storePassword=<tu_store_password>
keyAlias=<tu_key_alias>
keyPassword=<tu_key_password>
```

4. El proyecto ya está preparado para usar `key.properties` en `android/app/build.gradle.kts` y usará la signing config `release` automáticamente si el archivo existe.

5. Para generar un APK firmado:

```bash
flutter build apk --release
```

Notas:
- Nunca comitees `android/key.properties` ni la keystore en el repositorio.
- Para CI, inyecta estas cuatro propiedades como secretos y crea el `key.properties` en tiempo de build.

