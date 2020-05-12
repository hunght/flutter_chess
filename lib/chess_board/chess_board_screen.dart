import 'package:chess_game/blocs/chess_board_bloc.dart';
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chess_board.dart';

class ChessBoardScreen extends StatelessWidget {
  const ChessBoardScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChessBoardBloc, ChessBoardState>(
        listener: (BuildContext context, state) {
          if (state is ChessBoardLoadSussess) {
            if (state.eventTypeSussess == EventTypeSussess.promotionDialog) {
              _promotionDialog(
                  context: context, from: state.from, to: state.to);
            }
          }
        },
        child: _buildBlocBuilder());
  }

  BlocBuilder<ChessBoardBloc, ChessBoardState> _buildBlocBuilder() {
    return BlocBuilder<ChessBoardBloc, ChessBoardState>(
        builder: (context, state) {
      if (state is ChessBoardLoadSussess) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ChessBoard(
                  onMove: (move) {
                    print(move);
                  },
                  onCheck: (color) {
                    print(color);
                  },
                  onCheckMate: (color) {
                    print(color);
                  },
                  onDraw: () {},
                  size: MediaQuery.of(context).size.width,
                  boardModel: state.boardModel,
                )
              ],
            ),
          ),
        );
      }
      return Container();
    });
  }

  //helpers

  /// Show dialog when pawn reaches last square
  void _promotionDialog({BuildContext context, String from, String to}) async {
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
      BlocProvider.of<ChessBoardBloc>(context).add(
        ChessBoardPieceMoved(
            fromSquareName: from, toSquareName: to, value: value),
      );
    });
  }
}
