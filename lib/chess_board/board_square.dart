import 'package:flutter/material.dart';

import 'dart:async';
import 'package:chess_game/models/board_model.dart';
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:chess/chess.dart' as chess;

/// A single square on the chessboard
class BoardSquare extends StatelessWidget {
  /// The square name (a2, d3, e4, etc.)
  final String squareName;
  final double size;
  final BoardModel boardModel;
  BoardSquare(
      {this.squareName, @required this.boardModel, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: DragTarget(
        builder: (context, accepted, rejected) {
          return boardModel.game.get(squareName) != null
              ? Stack(
                  children: <Widget>[
                    Container(
                      color: boardModel.game.square_color(squareName) == 'light'
                          ? Colors.lightBlue
                          : Colors.blue,
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
                        boardModel.game.get(squareName).type.toUpperCase(),
                        boardModel.game.get(squareName).color,
                      ],
                    ),
                  ],
                )
              : Container(
                  color: boardModel.game.square_color(squareName) == 'light'
                      ? Colors.lightBlue
                      : Colors.blue,
                  width: size / 8,
                  height: size / 8,
                );
        },
        onWillAccept: (willAccept) {
          return boardModel.enableUserMoves ? true : false;
        },
        onAccept: (List moveInfo) {
          // A way to check if move occurred.
          chess.Color moveColor = boardModel.game.turn;

          if (moveInfo[1] == "P" &&
              ((moveInfo[0][1] == "7" &&
                      squareName[1] == "8" &&
                      moveInfo[2] == chess.Color.WHITE) ||
                  (moveInfo[0][1] == "2" &&
                      squareName[1] == "1" &&
                      moveInfo[2] == chess.Color.BLACK))) {
            _promotionDialog(context).then((value) {
              boardModel.game.move(
                  {"from": moveInfo[0], "to": squareName, "promotion": value});
              boardModel.refreshBoard();
            });
          } else {
            boardModel.game.move({"from": moveInfo[0], "to": squareName});
          }
          if (boardModel.game.turn != moveColor) {
            final move =
                moveInfo[1] == "P" ? squareName : moveInfo[1] + squareName;
          }
          boardModel.refreshBoard();
        },
      ),
    );
  }

  /// Show dialog when pawn reaches last square
  Future<String> _promotionDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Choose promotion'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                child: WhiteQueen(),
                onTap: () {
                  Navigator.of(context).pop("q");
                },
              ),
              InkWell(
                child: WhiteRook(),
                onTap: () {
                  Navigator.of(context).pop("r");
                },
              ),
              InkWell(
                child: WhiteBishop(),
                onTap: () {
                  Navigator.of(context).pop("b");
                },
              ),
              InkWell(
                child: WhiteKnight(),
                onTap: () {
                  Navigator.of(context).pop("n");
                },
              ),
            ],
          ),
        );
      },
    ).then((value) {
      return value;
    });
  }

  /// Get image to display on square
  Widget _getImageToDisplay({double size, BoardModel model}) {
    Widget imageToDisplay = Container();

    if (model.game.get(squareName) == null) {
      return Container();
    }

    String piece = model.game
            .get(squareName)
            .color
            .toString()
            .substring(0, 1)
            .toUpperCase() +
        model.game.get(squareName).type.toUpperCase();

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
