// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:fake_tomograf/models/app_state.dart';
import 'package:fake_tomograf/models/tomograph.dart';
import 'package:fake_tomograf/pages/widgets/ct_scan_drawer.dart';
import 'package:fake_tomograf/view_models/rectangle_view_model.dart';

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
  final _widthXController = TextEditingController();
  final _lengthYController = TextEditingController();
  final _absorptionCapacityController = TextEditingController();
  final _rayCountController = TextEditingController();

  List<double> calculatedPixels = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Center(
          child: Consumer<AppState>(
            builder: (context, state, _) => Container(
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: state.isTomographReady
                        ? CTScanDrawer(state.tomograph!, calculatedPixels)
                        : SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: const Center(
                              child: Text('Tu pojawi się tomograf'),
                            ),
                          ),
                  ),
                  const SizedBox(width: 36),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tomograf',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Żaneta Mielczarek, Julia Iskierka, Hubert Wawrzacz, Szymon Lipiec',
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 36),
                        state.isTomographReady
                            ? _buildRectangleForm()
                            : _buildCT(),
                        const SizedBox(height: 12),
                        state.isTomographReady
                            ? _buildRectanglesList(state.tomograph!)
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCT() => Form(
        child: Column(
          children: [
            TextFormField(
              controller: _resolutionController..text = '7',
              decoration: const InputDecoration(
                label: Text('Rozdzielczość'),
              ),
            ),
            TextFormField(
              controller: _rayCountController..text = '10',
              decoration: const InputDecoration(
                label: Text('Ilość wiązek'),
              ),
            ),
            const SizedBox(height: 36),
            ElevatedButton(
              onPressed: () => Provider.of<AppState>(context, listen: false)
                  .createTomograph(
                      _resolutionController.text, _rayCountController.text),
              child: const Text('Stwórz tomograf'),
            )
          ],
        ),
      );

  Widget _buildRectangleForm() => Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _rectangleStartXController..text = '1',
              decoration: const InputDecoration(
                label: Text('Lewy dolny róg prostokąta X'),
              ),
            ),
            TextFormField(
              controller: _rectangleStartYController..text = '1',
              decoration: const InputDecoration(
                label: Text('Lewy dolny róg prostokąta Y'),
              ),
            ),
            TextFormField(
              controller: _widthXController..text = '2',
              decoration: const InputDecoration(
                label: Text('Szerokość prostokąta (x)'),
              ),
            ),
            TextFormField(
              controller: _lengthYController..text = '3',
              decoration: const InputDecoration(
                label: Text('Długość prostokoąta (y)'),
              ),
            ),
            TextFormField(
              controller: _absorptionCapacityController..text = '4',
              decoration: const InputDecoration(
                label: Text('Zdolność pochłaniania'),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addRectangle,
              child: const Text('Dodaj prostokąt'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _finishEditing,
              child: const Text('Zakończ wprowadzanie'),
            ),
          ],
        ),
      );

  Widget _buildRectanglesList(Tomograph tomograph) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: tomograph.rectangles.length,
          itemBuilder: (context, index) {
            final rectangle = tomograph.rectangles[index];
            return ListTile(
              title: Text(
                'Prostakąt ${index + 1}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              subtitle: Text(
                  'Start: ${rectangle.pointBottomLeft}, szer: ${rectangle.width}, wys: ${rectangle.height}, opór: ${rectangle.resistance}'),
            );
          }),
    );
  }

  void _addRectangle() {
    Provider.of<AppState>(context, listen: false)
        .addRectangle(RectangleViewModel(
      rectangleStartX: _rectangleStartXController.text,
      rectangleStartY: _rectangleStartYController.text,
      rectangleXWidth: _widthXController.text,
      rectangleYLength: _lengthYController.text,
      absorptionCapacity: _absorptionCapacityController.text,
    ));
    _formKey.currentState?.reset();
  }

  void _finishEditing() {
    var pixels = Provider.of<AppState>(context, listen: false)
        .calculationsGoBrrr(int.parse(_resolutionController.text));
    setState(() {
      calculatedPixels = pixels;
    });
    pixels.asMap().forEach((key, value) {
      // if (value > 0) {
      //    print("${key} -> ${value}");
      // }
    });
  }
}
