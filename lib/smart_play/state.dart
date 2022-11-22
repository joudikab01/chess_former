import 'package:chess_former/graph/priority_queue.dart';
import 'package:chess_former/graph/queue.dart';
import 'package:chess_former/graph/stack.dart';
import 'package:chess_former/structure/level.dart';

import '../structure/position.dart';
import '../structure/types.dart';
import 'level_with_cost.dart';

class State {
  List<Position> availablePositions = [];
  Level level = Level(Position(x: 1, y: 1));

  clearAvailableMoves() {
    availablePositions.clear();
  }

  List<Position> checkMoves(Position currentPosition) {
    clearAvailableMoves();
    availablePositions
        .add(Position(x: currentPosition.x, y: currentPosition.y));

    //check left
    for (int i = currentPosition.y - 1; i >= 0; i--) {
      if (level.board2[currentPosition.x][i] == Types.wall) {
        break;
      } else {
        Position position = checkGround(Position(x: currentPosition.x, y: i));
        availablePositions.add(position);
      }
    }

    //check right
    for (int i = currentPosition.y + 1; i < 16; i++) {
      if (level.board2[currentPosition.x][i] == Types.wall) {
        break;
      } else {
        Position position = checkGround(Position(x: currentPosition.x, y: i));
        availablePositions.add(position);
      }
    }
    return availablePositions;
  }

  Position checkGround(Position position) {
    for (int k = position.x; k < 10; k++) {
      if (level.board2[k + 1][position.y] == Types.wall) {
        break;
      } else {
        position.x = k + 1;
      }
    }
    return position;
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

  bool isFinal(Position playerPosition) {
    Position p2 = getGoalPosition();
    if (p2 == playerPosition) {
      return true;
    }
    return false;
  }

  List<Level> getNextState(Position position) {
    List<Level> nextState = <Level>[];
    List<Position> positions = checkMoves(position);
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

  List<Level> dfs(Level initialLevel) {
    StackList<Level> stack = StackList<Level>();
    Set<Level> added = <Level>{};
    List<Level> visited = <Level>[];
    stack.push(initialLevel);
    added.add(initialLevel);
    visited.add(initialLevel);
    out:
    while (stack.isNotEmpty) {
      final level = stack.peek;
      print('dfs: ${level.playerPosition.x}  ${level.playerPosition.y}');
      print('_______________________________________________');
      if (isFinal(level.playerPosition)) {
        print('win!');
        break;
      }
      final children = getNextState(level.playerPosition);
      // print(children);
      for (var child in children) {
        // print(added.contains(child));
        // print('added child: $child');
        if (!added.contains(child)) {
          print(
              'not visited yet: ${child.playerPosition.x}  ${child.playerPosition.y}');
          // print('list of added $added');
          stack.push(child);
          added.add(child);
          visited.add(child);
          continue out;
        }
      }
      stack.pop();
    }
    print(visited.toString());
    print(visited.length);
    return visited;
  }

  List<Level> bfs(Level initialLevel) {
    QueueStack<Level> queue = QueueStack<Level>();
    Set<Level> added = <Level>{};
    List<Level> visited = <Level>[];

    queue.enqueue(initialLevel);
    added.add(initialLevel);

    while (true) {
      final level = queue.dequeue();
      print('bfs: ${level?.playerPosition}');
      print('_______________________________________________');
      if (isFinal(level!.playerPosition)) {
        print('win!');
        break;
      }
      visited.add(level);
      final children = getNextState(level.playerPosition);
      for (var child in children) {
        if (!added.contains(child)) {
          print('not visited yet: ${child.playerPosition}');
          queue.enqueue(child);
          added.add(child);
        }
      }
    }
    print(visited.toString());
    print(visited.length);
    return visited;
  }

  List<dynamic> ucs(LevelWithCost initialLevel) {
    PriorityQueue queue = PriorityQueue();
    Set<LevelWithCost> added = <LevelWithCost>{};
    List<LevelWithCost> visited = <LevelWithCost>[];

    queue.add(initialLevel);
    added.add(initialLevel);

    while (true) {
      final level = queue.pop();
      print('ucs: ${level?.playerPosition}');
      print('_______________________________________________');
      if (isFinal(level!.playerPosition)) {
        print('win!');
        break;
      }
      visited.add(level);
      final children = getNextState(level.playerPosition);
      for (var child in children) {
        if (!added.contains(LevelWithCost(child.playerPosition, level.cost + 1))) {
          print('not visited yet: ${child.playerPosition}');
          queue.add(LevelWithCost(child.playerPosition, level.cost + 1));
          added.add(LevelWithCost(child.playerPosition, level.cost + 1));
        }
      }
    }
    print(visited.toString());
    print(visited.length);
    return visited;
  }
}
