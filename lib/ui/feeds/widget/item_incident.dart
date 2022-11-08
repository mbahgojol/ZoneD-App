import 'package:flutter/material.dart';

class ItemIncident extends StatelessWidget {
  const ItemIncident({Key? key, required this.name, required this.myColor})
      : super(key: key);

  final String name;
  final MaterialColor myColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: myColor, shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(name)
      ],
    );
  }
}
