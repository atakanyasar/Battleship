import 'package:amiralbatti/placement.dart';
import 'package:amiralbatti/ship.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const boxSize = 40.0;

var isBattleStarted = false;

class Board extends StatefulWidget {
  var boardState;
  var parent;

  Board(this.boardState, this.parent) : super();

  @override
  _BoardState createState() => _BoardState(boardState, parent);
}

class _BoardState extends State<Board> {
  var boardState;
  var parentSetState;
  _BoardState(this.boardState, this.parentSetState);

  @override
  Widget build(BuildContext context) {
    print("building board");
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(boxSize),
        1: FixedColumnWidth(boxSize),
        2: FixedColumnWidth(boxSize),
        3: FixedColumnWidth(boxSize),
        4: FixedColumnWidth(boxSize),
        5: FixedColumnWidth(boxSize),
        6: FixedColumnWidth(boxSize),
        7: FixedColumnWidth(boxSize),
        8: FixedColumnWidth(boxSize),
        9: FixedColumnWidth(boxSize),
      },
      children: List.generate(10, (index) => getRow(boardState, index)),
    );
  }

  getRow(boardState, i) {
    return TableRow(
        children: List.generate(10, (index) => getCell(boardState, i, index)));
  }

  getCell(state, i, j) {
    return SizedBox(
      height: boxSize,
      child: DragTarget<String>(
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          if (isBattleStarted) {
            if (state[i][j] == 0 || state[i][j] == 1) {
              return ElevatedButton(
                child: const Text(""),
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: () {
                  setState(() {
                    if (state[i][j] == 1)
                      state[i][j]++;
                    else if (state[i][j] == 0) state[i][j]--;
                  });
                },
              );
            } else if (state[i][j] == -1) {
              return Container(child: Text(""), color: Colors.red);
            } else {
              return Container(
                child: const Icon(Icons.directions_boat_rounded, size: 10),
                color: Colors.green,
              );
            }
          } else {
            if (state[i][j] == 1) {
              return Container(
                child: const Icon(Icons.directions_boat_rounded, size: 10),
                color: Colors.green,
              );
            } else {
              return ElevatedButton(
                child: const Text(""),
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: () {},
              );
            }
          }
        },
        onWillAccept: (data) {
          var draggedShip = findDraggedShip(data)!;

          int c = findDraggedUnit(data)!;

          for (var k = 0; k < draggedShip.size; k++) {
            if (draggedShip.orientation == 'H') {
              if (j - c + k < 0) return false;
              if (j - c + k >= boardState[0].length) return false;
              if (boardState[i][j - c + k] == 1) return false;
            } else {
              if (i - c + k < 0) return false;
              if (i - c + k >= boardState.length) return false;
              if (boardState[i - c + k][j] == 1) return false;
            }
          }
          return true;
        },
        onAccept: (data) {
          var draggedShip = findDraggedShip(data)!;
          int c = findDraggedUnit(data)!;

          print("$c of ${draggedShip.name}");
          for (var k = 0; k < draggedShip.size; k++) {
            if (draggedShip.orientation == 'H') {
              boardState[i][j - c + k] = 1;
            } else {
              boardState[i - c + k][j] = 1;
            }
          }
          draggedShip.isPlaced = true;
          this.parentSetState(() {});
          // ships.add(Ship("test_ship", 1, 'V'));
          // ships = List.of(ships.reversed);
          // ships = [Ship('abc', 6, 'V')];

          // setState(() {});
          // parentSetState(() {});
        },
      ),
    );
  }

  findDraggedShip(data) {
    for (var ship in ships) {
      if (ship.name == data) {
        return ship;
      }
    }
    return null;
  }

  findDraggedUnit(data) {
    var draggedShip = findDraggedShip(data);
    print(draggedShip.sequence);
    for (var u = 0; u < draggedShip.sequence.length; u++) {
      var unit = draggedShip.sequence[u];
      // print("${u}: ${unit.dragging} of ${ship.name}");
      if (unit.dragging) {
        return u;
      }
    }
    return null;
  }
}
