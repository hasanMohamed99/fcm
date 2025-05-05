import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:io';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(
    String routeName, {
    Object? arguments,
  }) =>
      Navigator.of(this).pushNamed(
        routeName,
        arguments: arguments,
      );

  Future<dynamic> pushReplacementNamed(
    String routeName, {
    Object? arguments,
  }) =>
      Navigator.of(this).pushReplacementNamed(
        routeName,
        arguments: arguments,
      );

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
    required RoutePredicate predicate,
  }) =>
      Navigator.of(this).pushNamedAndRemoveUntil(
        routeName,
        predicate,
        arguments: arguments,
      );

  void pop() => Navigator.of(this).pop();

  void popUntil(
    String routeName,
  ) =>
      Navigator.of(this).popUntil(
        (route) => route.settings.name == routeName,
      );
}

extension MapExtension<K, V> on Map<K, V>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;

  void printPrettyMap() {
    if (this == null) {
      debugPrint('null');
      return;
    }
    const encoder = JsonEncoder.withIndent('  ');
    debugPrint(encoder.convert(this));
  }
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;

  void redDebugPrint() {
    if (Platform.isAndroid) {
      debugPrint('\x1B[91m$this\x1B[0m');
    } else {
      debugPrint("🔴 $this");
    }
  }

  void greenDebugPrint() {
    if (Platform.isAndroid) {
      debugPrint('\x1B[92m$this\x1B[0m');
    } else {
      debugPrint("🟢 $this");
    }
  }

  void yellowDebugPrint() {
    if (Platform.isAndroid) {
      debugPrint('\x1B[93m$this\x1B[0m');
    } else {
      debugPrint("🟡 $this");
    }
  }

  void blueDebugPrint() {
    if (Platform.isAndroid) {
      debugPrint('\x1B[94m$this\x1B[0m');
    } else {
      debugPrint("🔵 $this");
    }
  }

  void magentaDebugPrint() {
    if (Platform.isAndroid) {
      debugPrint('\x1B[95m$this\x1B[0m');
    } else {
      debugPrint("🟣 $this");
    }
  }

  void orangeDebugPrint() {
    if (Platform.isAndroid) {
      debugPrint('\x1B[38;5;214m$this\x1B[0m');
    } else {
      debugPrint("🟠 $this");
    }
  }

  void releasePrint() {
    if (Platform.isAndroid) {
      // ignore: avoid_print
      print("release: \x1B[92m$this\x1B[0m");
    } else {
      // ignore: avoid_print
      print("release: 🟢 $this");
    }
  }

  String removeExtension() {
    List<String> parts = this!.split('.');
    if (parts.length > 1) {
      parts.removeLast(); // Remove the extension
    }
    return parts.join('.');
  }
}

extension DoubleExtension on double {
  double toMb() => this / 1024 / 1024;
}

extension IntExtension on int {
  bool toBool() {
    return this == 0 ? false : true;
  }
}
