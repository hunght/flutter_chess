import 'package:chess_game/models/board_model.dart';
import 'package:flutter/material.dart';

import 'board_rank.dart';
import 'chess_board_constant.dart';

/// The Chessboard Widget
class ChessBoard extends StatefulWidget {
  /// Size of chessboard
  final double size;

  /// Callback for when move is made
  final MoveCallback onMove;

  /// Callback for when a player is checkmated
  final CheckMateCallback onCheckMate;

  /// Callback for when a player is in check
  final CheckCallback onCheck;

  /// Callback for when the game is a draw
  final VoidCallback onDraw;
  final BoardModel boardModel;
  ChessBoard({
    this.size = 200.0,
    @required this.onMove,
    @required this.onCheckMate,
    @required this.onCheck,
    @required this.onDraw,
    @required this.boardModel,
  });

  @override
  _ChessBoardState createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      child: Stack(
        children: <Widget>[
          Container(
            height: widget.size,
            width: widget.size,
            color: Colors.greenAccent,
          ),
          //Overlaying draggables/ dragTargets onto the squares
          Center(
            child: Container(
              height: widget.size,
              width: widget.size,
              child: buildChessBoard(widget.boardModel),
            ),
          )
        ],
      ),
    );
  }

  /// Builds the board
  Widget buildChessBoard(BoardModel boardModel) {
    return Column(
      children: widget.boardModel.whiteSideTowardsUser
          ? whiteSquareList.map((row) {
              return ChessBoardRank(
                boardModel: boardModel,
                children: row,
                size: widget.size,
              );
            }).toList()
          : whiteSquareList.reversed.map((row) {
              return ChessBoardRank(
                boardModel: boardModel,
                size: widget.size,
                children: row.reversed.toList(),
              );
            }).toList(),
    );
  }
}
