import 'package:chess_former/graph/priority_queue.dart';
import 'package:chess_former/graph/queue.dart';
import 'package:chess_former/graph/stack.dart';
import 'package:chess_former/smart_play/level_with_heuristic.dart';
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
        if (!added
            .contains(LevelWithCost(child.playerPosition, level.cost + 1))) {
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

  int heuristic(Position playerPosition) {
    Position target = Position(x: 9, y: 9);
    if (playerPosition.x == target.x) {
      print((playerPosition.y - target.y).abs());
      return (playerPosition.y - target.y).abs();
    } else {
      Position hole;
      for (int i = playerPosition.y + 1; i < 16; i++) {
        if (level.board2[playerPosition.x + 1][i] == Types.cell) {
          hole = Position(x: playerPosition.x, y: i);
          Position endOfHole = checkGround(hole);
          if (endOfHole.x > target.x) {
            print(100);
            return 100;
          } else {
            print((hole.y - playerPosition.y).abs());
            return (hole.y - playerPosition.y).abs();
          }
        }
      }
      for (int i = playerPosition.y; i > 0; i--) {
        if (level.board2[playerPosition.x + 1][i] == Types.cell) {
          hole = Position(x: playerPosition.x, y: i);
          Position endOfHole = checkGround(hole);
          if (endOfHole.x > target.x) {
            print(100);
            return 100;
          } else {
            print((hole.y - playerPosition.y).abs());
            return (hole.y - playerPosition.y).abs();
          }
        }
      }
    }
    print(111);
    return 100;
  }

  List<LevelWithHeuristic> aStar(LevelWithHeuristic initialLevel) {
    PriorityQueueAlt queue = PriorityQueueAlt();
    Set<Level> added = <Level>{};
    List<LevelWithHeuristic> visited = <LevelWithHeuristic>[];

    queue.add(initialLevel);
    added.add(Level(initialLevel.playerPosition));

    while (true) {
      final level = queue.pop();
      print('astar: ${level?.playerPosition}');
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
          queue.add(LevelWithHeuristic(child.playerPosition, level.cost + 1,
              heuristic(child.playerPosition)));
          added.add(child);
        }
      }
    }
    print(visited[visited.length - 1].toString());
    print(visited.length);
    return visited;
  }
}
