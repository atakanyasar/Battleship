import 'package:amiralbatti/battle.dart';
import 'package:amiralbatti/board.dart';
import 'package:amiralbatti/placement.dart';
import 'package:amiralbatti/ship_unit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Ship extends StatefulWidget {
  int size = 0;
  String name = "ship_0", orientation = 'H';
  var sequence;
  bool isPlaced = false;

  Ship(this.name, this.size, this.orientation) {
    sequence = List.generate(size, (index) => ShipUnit());
  }

  @override
  State<Ship> createState() => _Ship(this);
}

class _Ship extends State<Ship> {
  var parent;

  _Ship(this.parent);

  @override
  Widget build(BuildContext context) {
    print("building ${parent.name}");

    return Draggable(
      data: parent.name,
      child: InkWell(
          onTap: () {
            setState(() {
              if (parent.orientation == 'H') {
                parent.orientation = 'V';
              } else {
                parent.orientation = 'H';
              }
              print("oriented");
            });
          },
          child: getSequence(parent.size)),
      feedback: getSequence(parent.size),
      childWhenDragging: const SizedBox(
        height: boxSize,
        width: boxSize,
      ),
      onDragEnd: (details) {
        for (var ship in ships) {
          if (ship.name == parent.name) {
            for (var unit in ship.sequence) {
              unit.dragging = false;
            }
          }
        }
      },
    );
  }

  getSequence(s) {
    if (parent.orientation == 'H') {
      return Row(
        children: parent.sequence,
      );
    } else {
      return Column(
        children: parent.sequence,
      );
    }
    // return parent.sequence;
  }
}
