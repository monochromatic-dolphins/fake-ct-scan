import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CTScanDrawer extends StatefulWidget {
  const CTScanDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CTScanDrawerState();
}

class _CTScanDrawerState extends State<CTScanDrawer> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Text('Tu będzie tomograf jak go narysuję'),
        ),
          ),]
      );
}
