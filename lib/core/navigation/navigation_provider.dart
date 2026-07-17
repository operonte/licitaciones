import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to manage the selected index of the bottom navigation bar globally.
final navigationIndexProvider = StateProvider<int>((ref) => 0);
