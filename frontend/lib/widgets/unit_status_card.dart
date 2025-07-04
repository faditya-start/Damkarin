import 'package:flutter/material.dart';
import '../models/unit.dart';

Widget UnitStatusCard(UnitModel unit) {
  return Card(
    color: unit.status == "Siaga" ? Colors.green : Colors.orange,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text("${unit.name}: ${unit.status}"),
    ),
  );
}