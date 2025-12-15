import 'package:flutter/material.dart';
import 'package:omnesoft_task/app/omnesoft_app.dart';
import 'package:omnesoft_task/app/register_app_dependencies.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/src/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final di = GetItDI();

  await registerAppDependencies(di: di);

  runApp(OmnesoftApp(di: di));
}
