import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:zoned/ui/feeds/widget/item_incident.dart';
import 'package:zoned/utils/dummy_data.dart';

import '../create_feeds_page.dart';

class DropdownTypeIncident extends StatefulWidget {
  const DropdownTypeIncident({Key? key, required this.onChanged})
      : super(key: key);
  final Function(int) onChanged;

  @override
  State<DropdownTypeIncident> createState() => _DropdownTypeIncidentState();
}

class _DropdownTypeIncidentState extends State<DropdownTypeIncident> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            key: keyKu,
            hint: const Text('Choose Incidents'),
            value: dropdownValue,
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
                widget.onChanged(names.indexOf(value));
              });
            },
            items: names.map((String value) {
              var index = names.indexOf(value);
              return DropdownMenuItem(
                value: value,
                child: ItemIncident(name: value, myColor: colors[index]),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
