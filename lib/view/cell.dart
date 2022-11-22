import 'package:flutter/material.dart';

import '../structure/position.dart';
import '../structure/types.dart';

//cell is the ui piece of the game
class Cell extends StatefulWidget {
  final Position position;
  final Types t;
  late final Color color;
  final Function() onPressed;
  bool isPlayer;
  bool isAvailable;
  Cell({
    super.key,
    required this.position,
    required this.t,
    required this.onPressed,
    required this.isAvailable,
    required this.isPlayer,
  }) {
    if (t == Types.wall) {
      color = Colors.green;
    } else if (t == Types.goal) {
      color = Colors.red;
    } else if (t == Types.cell && isPlayer) {
      color = Colors.blue;
    } else {
      color = Colors.yellow;
    }

    // } else {
    //   color = Colors.blue;
    // }
  }

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(
          10,
        ),
        child: widget.isAvailable
            ? const CircleAvatar(
                backgroundColor: Colors.black26,
              )
            : const SizedBox(),
      ),
    );
  }
}
