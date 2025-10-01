import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

void main() {
  // ProviderScope pour Riverpod
  runApp(const ProviderScope(child: FrigoApp()));
}