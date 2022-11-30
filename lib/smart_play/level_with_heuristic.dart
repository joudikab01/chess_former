import 'package:chess_former/structure/position.dart';
import 'package:chess_former/structure/types.dart';

class LevelWithHeuristic {
  Position playerPosition;
  int cost;
  int heuristic;
  LevelWithHeuristic(this.playerPosition, this.cost, this.heuristic);
  //start state of the board of 2nd level
  List<List<Types>> board2 = [
    // y ======>
    //  x
    // ||
    // ||
    // ||
    // \/
    [
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
    ],
    [
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
    ],
    [
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.cell,
      Types.wall,
      Types.wall,
      Types.wall,
    ],
    [
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.wall,
      Types.cell,
      Types.wall,
      Types.cell,
      Types.cell,
    ],
    [
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
    ],
    [
      Types.wall,
      Types.wall,
      Types.cell,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
    ],
    [
      Types.cell,
      Types.wall,
      Types.cell,
      Types.wall,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
    ],
    [
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
    ],
    [
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.cell,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
    ],
    [
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.wall,
      Types.goal,
      Types.wall,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
      Types.cell,
    ],
    [
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
      Types.wall,
    ],
  ];

  //deep copy for the level
  LevelWithHeuristic copyWith({
    required Position playerPosition,
    required int cost,
    required int heuristic,
  }) {
    return LevelWithHeuristic(playerPosition, cost, heuristic);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelWithHeuristic &&
          runtimeType == other.runtimeType &&
          playerPosition == other.playerPosition &&
          cost == other.cost
      && heuristic == other.heuristic;

  @override
  int get hashCode =>
      playerPosition.hashCode ^ cost.hashCode ^ heuristic.hashCode;

  @override
  String toString() {
    return 'Level{playerPosition: $playerPosition,cost: $cost, heuristic: $heuristic }';
  }
}
