// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:fake_tomograf/models/dependency_provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fake CT Scan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DependencyProvider(
        child: HomePage(),
      ),
    );
  }
}
