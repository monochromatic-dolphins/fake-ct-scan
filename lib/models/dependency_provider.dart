// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:fake_tomograf/models/app_state.dart';

class DependencyProvider extends StatefulWidget {
  const DependencyProvider({
    required this.child,
    GlobalKey? key,
  }) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => _DependencyProviderState();
}

class _DependencyProviderState extends State<DependencyProvider> {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppState()),
        ],
        child: widget.child,
      );
}
