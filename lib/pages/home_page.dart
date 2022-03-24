// Flutter imports:
import 'package:fake_tomograf/models/app_state.dart';
import 'package:fake_tomograf/pages/widgets/ct_scan_drawer.dart';
import 'package:fake_tomograf/view_models/rectangle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _resolutionController = TextEditingController();
  final _rectangleStartXController = TextEditingController();
  final _rectangleStartYController = TextEditingController();
  final _lengthXController = TextEditingController();
  final _widthYController = TextEditingController();
  final _absorptionCapacityController = TextEditingController();
  final _rayCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake CT Scan'),
      ),
      body: Center(
        child: Consumer<AppState>(
          builder: (context, state, _) => Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Expanded(child: CTScanDrawer()),
                Expanded(
                  child: state.isTomographReady ? _buildRectangleForm() : _buildCT(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCT() =>
      Form(
        child: Column(
          children: [
            TextFormField(
              controller: _resolutionController,
              decoration: const InputDecoration(
                label: Text('Rozdzielczość'),
              ),
            ),
            TextFormField(
              controller: _rayCountController,
              decoration: const InputDecoration(
                label: Text('Ilość wiązek'),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () =>
                Provider.of<AppState>(context, listen: false).createTomograph(
                    _resolutionController.text, _rayCountController.text),
              child: Text('Stwórz tomograf'),)
          ],
        ),
      );

  Widget _buildRectangleForm() =>
      Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _rectangleStartXController,
              decoration: const InputDecoration(
                label: Text('Lewy dolny róg prostokąta X'),
              ),
            ),
            TextFormField(
              controller: _rectangleStartYController,
              decoration: const InputDecoration(
                label: Text('Lewy dolny róg prostokąta Y'),
              ),
            ),
            TextFormField(
              controller: _lengthXController,
              decoration: const InputDecoration(
                label: Text('Długość prostokąta (x)'),
              ),
            ),
            TextFormField(
              controller: _widthYController,
              decoration: const InputDecoration(
                label: Text('Szerokość prostokoąta (y)'),
              ),
            ),
            TextFormField(
              controller: _absorptionCapacityController,
              decoration: const InputDecoration(
                label: Text('Zdolność pochłaniania'),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addRectangle,
              child: Text('Dodaj prostokąt'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _finishEditing,
              child: Text('Zakończ wprowadzanie'),
            ),
          ],
        ),
      );

  void _addRectangle() {
    Provider.of<AppState>(context, listen: false)
        .addRectangle(RectangleViewModel(
      rectangleStartX: _rectangleStartXController.text,
      rectangleStartY: _rectangleStartYController.text,
      rectangleXlength: _lengthXController.text,
      rectangleYwidth: _widthYController.text,
      absorptionCapacity: _absorptionCapacityController.text,
    ));
    _formKey.currentState?.reset();
  }

  void _finishEditing() {
    Provider.of<AppState>(context,listen: false).calculate();
  }
}
