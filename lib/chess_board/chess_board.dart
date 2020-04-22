import 'package:chess_game/models/board_model.dart';
import 'package:flutter/material.dart';

import 'board_rank.dart';

var whiteSquareList = [
  [
    "a8",
    "b8",
    "c8",
    "d8",
    "e8",
    "f8",
    "g8",
    "h8",
  ],
  [
    "a7",
    "b7",
    "c7",
    "d7",
    "e7",
    "f7",
    "g7",
    "h7",
  ],
  [
    "a6",
    "b6",
    "c6",
    "d6",
    "e6",
    "f6",
    "g6",
    "h6",
  ],
  [
    "a5",
    "b5",
    "c5",
    "d5",
    "e5",
    "f5",
    "g5",
    "h5",
  ],
  [
    "a4",
    "b4",
    "c4",
    "d4",
    "e4",
    "f4",
    "g4",
    "h4",
  ],
  [
    "a3",
    "b3",
    "c3",
    "d3",
    "e3",
    "f3",
    "g3",
    "h3",
  ],
  [
    "a2",
    "b2",
    "c2",
    "d2",
    "e2",
    "f2",
    "g2",
    "h2",
  ],
  [
    "a1",
    "b1",
    "c1",
    "d1",
    "e1",
    "f1",
    "g1",
    "h1",
  ],
];

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
