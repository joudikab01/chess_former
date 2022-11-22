import 'package:chess_former/structure/position.dart';
import 'package:chess_former/structure/types.dart';

class LevelWithCost {
  Position playerPosition;
  int cost;
  LevelWithCost(this.playerPosition, this.cost);
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

  // Level addPosition(Position position){
  //   path.add(position);
  //   return this;
  // }

  //deep copy for the level
  LevelWithCost copyWith({
    required Position playerPosition,
    required int cost,
  }) {
    return LevelWithCost(playerPosition, cost);
  }

  //override the equal method to compare two objects of
  // Level instead of comparing their reference
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is Level &&
  //         runtimeType == other.runtimeType &&
  //         playerPosition == other.playerPosition &&
  //         //path == other.path &&
  //         board2 == other.board2;

  // @override
  // int get hashCode => playerPosition.hashCode ^
  // //path.hashCode ^
  // board2.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelWithCost &&
          runtimeType == other.runtimeType &&
          playerPosition == other.playerPosition;

  @override
  int get hashCode => playerPosition.hashCode;

  @override
  String toString() {
    return 'Level{playerPosition: $playerPosition,cost: $cost }';
  }
}
