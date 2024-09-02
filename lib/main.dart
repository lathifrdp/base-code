import 'package:coba/app.dart';
import 'package:coba/core/client/client.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await Client().setupClient();
  initializeDateFormatting();
  runApp(const App());
}
