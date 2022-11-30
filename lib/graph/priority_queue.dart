import 'package:chess_former/smart_play/level_with_heuristic.dart';

import '../smart_play/level_with_cost.dart';

class PriorityQueue {
  List<LevelWithCost> queue = <LevelWithCost>[];
  PriorityQueue();

  /// Add a new item to the queue and ensure the highest priority element
  /// is at the front of the queue.
  add(LevelWithCost value) {
    queue.add(value);
    queue.sort((a, b) {
      return a.cost - b.cost;
    });
  }

  ///
  /// Return the highest priority element in the queue.
  pop() {
    return queue.removeAt(0);
  }

  bool empty() {
    return queue.isEmpty;
  }
}

class PriorityQueueAlt {
  List<LevelWithHeuristic> queue = <LevelWithHeuristic>[];
  PriorityQueueAlt();

  /// Add a new item to the queue and ensure the highest priority element
  /// is at the front of the queue.
  add(LevelWithHeuristic value) {
    queue.add(value);
    queue.sort((a, b) {
      return (a.cost + a.heuristic) - (b.cost + b.heuristic);
    });
  }

  ///
  /// Return the highest priority element in the queue.
  pop() {
    return queue.removeAt(0);
  }

  bool empty() {
    return queue.isEmpty;
  }
}
