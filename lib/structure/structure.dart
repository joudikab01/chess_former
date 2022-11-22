import 'package:chess_former/structure/level.dart';
import 'package:chess_former/structure/position.dart';
import 'package:chess_former/structure/types.dart';

class Structure {
  // List<List<Types>> board2 = [
  //   // y ======>
  //   //  x
  //   // ||
  //   // ||
  //   // ||
  //   // \/
  //   [
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //   ],
  //   [
  //     Types.cell,
  //     Types.play,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //   ],
  //   [
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.cell,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //   ],
  //   [
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.wall,
  //     Types.cell,
  //     Types.wall,
  //     Types.cell,
  //     Types.cell,
  //   ],
  //   [
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //   ],
  //   [
  //     Types.wall,
  //     Types.wall,
  //     Types.cell,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //   ],
  //   [
  //     Types.cell,
  //     Types.wall,
  //     Types.cell,
  //     Types.wall,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //   ],
  //   [
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //   ],
  //   [
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.cell,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //   ],
  //   [
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.wall,
  //     Types.goal,
  //     Types.wall,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //     Types.cell,
  //   ],
  //   [
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //     Types.wall,
  //   ],
  // ];

  Level level = Level(
    Position(
      x: 1,
      y: 1,
    ),
  );

  //used to save available moves for this position (for algorithm purposes)
  List<Position> availablePositions = [];
  //used to save available moves (but for the ui)
  List<List<bool>> availableMoves =
      List.generate(11, (x) => List.generate(16, (y) => false));

  //constructor
  Structure();

  clearAvailableMoves() {
    availableMoves.clear();
    availablePositions.clear();
    availableMoves = List.generate(
      11,
      (x) => List.generate(
        16,
        (y) => false,
      ),
    );
  }

  //return current player position
  Position getPlayerPosition() {
    Position position = level.playerPosition;
    return position;
  }

  // Structure copyWith(
  //    List<List<Types>> board2,
  //    List<List<bool>> availableMoves,
  // ) {
  //   return Structure(
  //     board:board2 ,
  //     availableMoves: availableMoves ,
  //   );
  // }

  void checkMoves(Position currentPosition) {
    clearAvailableMoves();
    availableMoves[currentPosition.x][currentPosition.y] = true;
    availablePositions
        .add(Position(x: currentPosition.x, y: currentPosition.y));

    //check up
    for (int i = currentPosition.x - 1; i >= 0; i--) {
      if (level.board2[i][currentPosition.y] == Types.wall) {
        break;
      } else {
        availableMoves[i][currentPosition.y] = true;
        availablePositions.add(Position(x: i, y: currentPosition.y));
      }
    }

    //check left
    for (int i = currentPosition.y - 1; i >= 0; i--) {
      if (level.board2[currentPosition.x][i] == Types.wall) {
        break;
      } else {
        availableMoves[currentPosition.x][i] = true;
        availablePositions.add(Position(x: currentPosition.x, y: i));
      }
    }

    //check right
    for (int i = currentPosition.y + 1; i < 16; i++) {
      if (level.board2[currentPosition.x][i] == Types.wall) {
        break;
      } else {
        availableMoves[currentPosition.x][i] = true;
        availablePositions.add(Position(x: currentPosition.x, y: i));
      }
    }
  }

  void moveToPosition(Position position) {
    Position currentPosition = getPlayerPosition();
    checkMoves(currentPosition);
    // for (int i = 0; i < availableMoves.length; i++) {
    // for (int j = 0; j < availableMoves[i].length; j++) {
    if (availableMoves[position.x][position.y]) {
      print("you can move to position ${position.x},${position.y}");
      // board2[currentPosition.x][currentPosition.y] = Types.cell;
      // board2[position.x][position.y] = Types.play;
      level.playerPosition = Position(x: position.x, y: position.y);
      checkGround(position);
      // printBoard(board2);
      if (!isFinal()) {
        checkMoves(position);
      } else {
        clearAvailableMoves();
      }
      return;
      // }
      // }
    } else {
      print("you cannot move to position ${position.x},${position.y}");
    }
  }

  void checkGround(Position position) {
    for (int k = position.x; k < 10; k++) {
      if (level.board2[k + 1][position.y] == Types.wall) {
        break;
      } else {
        level.board2[position.x][position.y] = Types.cell;
        position.x = k + 1;
      }
    }
    level.playerPosition = Position(x: position.x, y: position.y);
    // board2[position.x][position.y] = Types.play;
  }

  Position getGoalPosition() {
    Position position = Position(x: -1, y: -1);
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 16; j++) {
        if (level.board2[i][j] == Types.goal) {
          position = Position(x: i, y: j);
          return position;
        }
      }
    }
    return position;
  }

  bool isFinal() {
    Position p2 = getGoalPosition();
    if (p2 == level.playerPosition) {
      return true;
    }
    return false;
  }

  void printBoard(List<List<Types>> board) {
    for (int i = 0; i < 10; i++) {
      String sr = '';
      for (int j = 0; j < 16; j++) {
        sr = "$sr${board[i][j].toString()} | ";
      }
      print(sr);
    }
  }

  List<Level> getNextState() {
    List<Level> nextState = <Level>[];
    List<Position> positions = availablePositions;
    for (Position position in positions) {
      //deep copying the next level_state
      Level l =
          Level(Position(x: level.playerPosition.x, y: level.playerPosition.y))
              .copyWith(playerPosition: position);
      nextState.add(l);
      // print('${l.playerPosition.x}  ${l.playerPosition.y}');
      // print('_______________________________________________');
    }
    return nextState;
  }

  //override the equal method to compare two objects of Structure instead of comparing their reference
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Structure &&
          runtimeType == other.runtimeType &&
          level.board2 == other.level.board2 &&
          availableMoves == other.availableMoves;

  @override
  int get hashCode => level.board2.hashCode ^ availableMoves.hashCode;
}
