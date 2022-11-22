//define the position of the cell (row, column)

class Position {
  int x;
  int y;
  Position({
    required this.x,
    required this.y,
  });


  @override
  String toString() {
    return 'Position{x: $x, y: $y}';
  }
  //override the equal method to compare two objects of Position instead of comparing their reference
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}