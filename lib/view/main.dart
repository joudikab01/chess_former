import 'package:chess_former/structure/level.dart';
import 'package:chess_former/view/cell.dart';
import 'package:flutter/material.dart';

import '../smart_play/level_with_cost.dart';
import '../structure/position.dart';
import '../structure/structure.dart';
import '../smart_play/state.dart' as state;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Structure structure;
  late List list;
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     Structure structure = Structure();
  //     structure.printBoard(Structure().board2);
  //     // structure.checkMoves(Position(x: 1, y: 1));
  //     // print(structure.getPlayerPosition().x);
  //     // print(structure.getPlayerPosition().y);
  //     structure.moveToPosition(Position(x: 1, y: 12));
  //
  //     // structure.checkMoves(Position(x: 1, y: 0));
  //     // for(int i=0;i<structure.availableMoves.length;i++){
  //     //   print("x=${structure.availableMoves[i].x} , y=${structure.availableMoves[i].y} \n " );
  //     // }
  //     print(structure.getPlayerPosition().x);
  //     print(structure.getPlayerPosition().y);
  //     // structure.checkMoves(Position(x: 4, y: 12));
  //     // for(int i=0;i<structure.availableMoves.length;i++){
  //     //   print("x=${structure.availableMoves[i].x} , y=${structure.availableMoves[i].y} \n " );
  //     // }
  //
  //     _counter++;
  //   });
  // }

  @override
  void initState() {
    structure = Structure();
    list = structure.level.board2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          state.State().dfs(Level(Position(x: 1, y: 1)));
          state.State().bfs(Level(Position(x: 1, y: 1)));
          state.State().ucs(LevelWithCost(Position(x: 1, y: 1),0));
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            list.length,
            (x) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  list[x].length,
                  (y) {
                    if (Position(x: x, y: y) ==
                        structure.level.playerPosition) {
                      return Cell(
                        position: Position(x: x, y: y),
                        t: list[x][y],
                        onPressed: () {
                          setState(
                            () {
                              structure.moveToPosition(Position(x: x, y: y));
                              structure.isFinal()
                                  ? showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          content: Text('winner'),
                                        );
                                      })
                                  : const SizedBox();
                            },
                          );
                        },
                        isAvailable: structure.availableMoves[x][y],
                        isPlayer: true,
                      );
                    } else {
                      return Cell(
                        position: Position(x: x, y: y),
                        t: list[x][y],
                        onPressed: () {
                          setState(
                            () {
                              structure.moveToPosition(Position(x: x, y: y));
                              structure.isFinal()
                                  ? showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          content: Text('winner'),
                                        );
                                      })
                                  : const SizedBox();
                            },
                          );
                        },
                        isAvailable: structure.availableMoves[x][y],
                        isPlayer: false,
                      );
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
