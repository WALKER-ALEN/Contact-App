import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/themeController.dart';
import 'package:flutter_application_1/view/contactlistscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: ContactApp()));
}

class ContactApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact App',
      theme: ref.watch(themeProvider) ? ThemeData.dark() : ThemeData(),
      home: ContactListScreen(),
    );
  }
}
