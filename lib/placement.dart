import 'package:amiralbatti/battle.dart';
import 'package:amiralbatti/board.dart';
import 'package:amiralbatti/ship.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Ship> ships = [];

print_ships() {
  print(List.generate(ships.length, (index) => ships[index].name));
}

class Placement extends StatefulWidget {
  Placement({Key? key}) : super(key: key) {
    ships = [
      Ship("ship_a", 5, 'V'),
      Ship("ship_b", 4, 'V'),
      Ship("ship_c", 3, 'V'),
      Ship("ship_d", 3, 'V'),
      Ship("ship_e", 2, 'V')
    ];
  }

  @override
  _PlacementState createState() => _PlacementState();
}

class _PlacementState extends State<Placement> {
  List<List<int>> boardState =
      List.generate(10, (index) => List.generate(10, (index) => 0));

  @override
  Widget build(BuildContext context) {
    isBattleStarted = false;

    print("building placement");

    return Scaffold(
      appBar: AppBar(title: const Text("Placement")),
      body: Column(children: _design()),
    );
  }

  _design() {
    return <Widget>[
      Board(boardState, setState),
      const SizedBox(height: 20),
      Row(children: _builder()),
      _confirmPlacementButton(),
    ];
  }

  _builder() {
    return List.generate(ships.length, (index) {
      if (index < ships.length && ships[index].isPlaced == false)
        return ships[index];
      else
        return SizedBox();
    });
  }

  _confirmPlacementButton() {
    for (var ship in ships)
      if (ship.isPlaced == false) return SizedBox.shrink();
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BattlePhase(boardState)));
        },
        child: Text("Confirm Placement"),
      ),
    );
  }
}
