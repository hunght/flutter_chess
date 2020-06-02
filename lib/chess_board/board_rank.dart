import 'package:chess_game/blocs/chess_board_bloc.dart';
import 'package:chess_game/models/board_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'board_square.dart';

/// Creates a rank(row) on the chessboard
class ChessBoardRank extends StatelessWidget {
  /// The list of squares in the rank
  final List<String> children;
  final double size;
  final BoardModel boardModel;
  ChessBoardRank(
      {this.children, @required this.boardModel, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: children
            .map(
              (squareName) => BoardSquare(
                squareName: squareName,
                boardModel: boardModel,
                size: size,
                isLightColor:
                    boardModel.game.square_color(squareName) == 'light',
                piece: boardModel.game.get(squareName),
                onAcceptMove: ({String from, String to}) {},
              ),
            )
            .toList(),
      ),
    );
  }
}
