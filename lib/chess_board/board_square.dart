import 'dart:async';
import 'package:flutter/material.dart';
import 'package:chess_game/models/board_model.dart';
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';

/// A single square on the chessboard
class BoardSquare extends StatelessWidget {
  /// The square name (a2, d3, e4, etc.)
  final String squareName;
  final double size;
  final BoardModel boardModel;
  final bool isLightColor;
  final String piece;
  final Function({String from, String to}) onAcceptMove;
  BoardSquare({
    this.squareName,
    @required this.boardModel,
    @required this.size,
    @required this.piece,
    @required this.onAcceptMove,
    @required this.isLightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: DragTarget(
        builder: (context, accepted, rejected) {
          return piece != null
              ? Stack(
                  children: <Widget>[
                    Container(
                      color: isLightColor ? Colors.lightBlue : Colors.blue,
                      width: size / 8,
                      height: size / 8,
                    ),
                    Draggable(
                      child:
                          _getImageToDisplay(size: size / 8, model: boardModel),
                      feedback: _getImageToDisplay(
                          size: (1.2 * (size / 8)), model: boardModel),
                      onDragCompleted: () {},
                      data: [
                        squareName,
                      ],
                    ),
                  ],
                )
              : Container(
                  color: isLightColor ? Colors.lightBlue : Colors.blue,
                  width: size / 8,
                  height: size / 8,
                );
        },
        onWillAccept: (willAccept) {
          return boardModel.enableUserMoves ? true : false;
        },
        onAccept: (List moveInfo) {
          onAcceptMove(from: moveInfo[0], to: squareName);
          // A way to check if move occurred.
        },
      ),
    );
  }

  /// Get image to display on square
  Widget _getImageToDisplay({double size, BoardModel model}) {
    Widget imageToDisplay = Container();

    if (piece.isEmpty) {
      return Container();
    }

    // String piece = model.game
    //         .get(squareName)
    //         .color
    //         .toString()
    //         .substring(0, 1)
    //         .toUpperCase() +
    //     model.game.get(squareName).type.toUpperCase();

    switch (piece) {
      case "WP":
        imageToDisplay = WhitePawn(size: size);
        break;
      case "WR":
        imageToDisplay = WhiteRook(size: size);
        break;
      case "WN":
        imageToDisplay = WhiteKnight(size: size);
        break;
      case "WB":
        imageToDisplay = WhiteBishop(size: size);
        break;
      case "WQ":
        imageToDisplay = WhiteQueen(size: size);
        break;
      case "WK":
        imageToDisplay = WhiteKing(size: size);
        break;
      case "BP":
        imageToDisplay = BlackPawn(size: size);
        break;
      case "BR":
        imageToDisplay = BlackRook(size: size);
        break;
      case "BN":
        imageToDisplay = BlackKnight(size: size);
        break;
      case "BB":
        imageToDisplay = BlackBishop(size: size);
        break;
      case "BQ":
        imageToDisplay = BlackQueen(size: size);
        break;
      case "BK":
        imageToDisplay = BlackKing(size: size);
        break;
      default:
        imageToDisplay = WhitePawn(size: size);
    }

    return imageToDisplay;
  }
}
