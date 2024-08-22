import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoginPasswordVisibleProvider = StateProvider<bool>((ref) => true);
final isRegisterPasswordVisibleProvider = StateProvider<bool>((ref) => true);
final isRegisterConfirmPasswordVisibleProvider =
    StateProvider<bool>((ref) => true);

final checkboxValueProvider = StateProvider<bool>((ref) => false);
