import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'board.dart';
import 'dart:math' as math;

class ShipUnit extends StatelessWidget {
  ShipUnit({Key? key}) : super(key: key);

  var dragging = false;

  @override
  Widget build(BuildContext context) {
    // color: const Color(0xFF000000),
    return Listener(
        // onPointerUp: (event) => {dragging = false, print("up")},
        onPointerDown: (event) => {dragging = true, print("dragging")},
        child: Container(
            height: boxSize,
            width: boxSize,
            child: Icon(Icons.directions_boat_rounded),
            color: Colors.transparent));
  }
}
