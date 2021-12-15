import 'package:amiralbatti/board.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BattlePhase extends StatefulWidget {
  var hiddenBoardState;
  BattlePhase(this.hiddenBoardState, {Key? key}) : super(key: key);

  @override
  _BattlePhaseState createState() => _BattlePhaseState(hiddenBoardState);
}

class _BattlePhaseState extends State<BattlePhase> {
  List<List<int>> hiddenBoardState;
  _BattlePhaseState(this.hiddenBoardState);
  @override
  Widget build(BuildContext context) {
    isBattleStarted = true;
    print("building battle");
    // List<List<int>> visibleBoardState =
    //     List.generate(10, (index) => List.generate(10, (index) => 0));

    return Scaffold(
      appBar: AppBar(title: const Text("Battle Phase")),
      body: Center(child: Column(children: [Board(hiddenBoardState, this)])),
    );
  }
}
