import 'dart:async';
import 'package:chess/chess.dart' as chess;
import 'package:bloc/bloc.dart';
import 'package:chess_game/models/board_model.dart';
import 'package:equatable/equatable.dart';

part 'chess_board_event.dart';
part 'chess_board_state.dart';

class ChessBoardBloc extends Bloc<ChessBoardEvent, ChessBoardState> {
  /// Creates a logical game
  chess.Chess game = chess.Chess();

  @override
  ChessBoardState get initialState => ChessBoardInitial();

  @override
  Stream<ChessBoardState> mapEventToState(
    ChessBoardEvent event,
  ) async* {
    if (event is ChessBoardFetched) {
      yield* _mapChessBoardFetchedToState();
    }
    if (event is ChessBoardPieceMoved) {
      yield* _mapChessBoardPieceMovedToState(event);
    }
  }

  Stream<ChessBoardState> _mapChessBoardFetchedToState() async* {
    yield ChessBoardLoadSussess(
      boardModel: BoardModel(
          whiteSideTowardsUser: true,
          enableUserMoves: true,
          chessFEN: game.fen,
          game: game),
    );
  }

  Stream<ChessBoardState> _mapChessBoardPieceMovedToState(
      ChessBoardPieceMoved event) async* {
    final state = this.state;
    // chess.Color moveColor = game.turn;
    final typeFromSquareName =
        game.get(event.fromSquareName).type.toUpperCase();
    final colorFromSquareName = game.get(event.fromSquareName).color;
    if (typeFromSquareName == "P" &&
        ((event.fromSquareName[1] == "7" &&
                typeFromSquareName == "8" &&
                colorFromSquareName == chess.Color.WHITE) ||
            (event.fromSquareName[1] == "2" &&
                typeFromSquareName == "1" &&
                colorFromSquareName == chess.Color.BLACK))) {
      yield ChessBoardLoadSussess(
        eventTypeSussess: EventTypeSussess.promotionDialog,
        boardModel: state.boardModel,
      );
    } else {
      game.move({
        "from": event.fromSquareName,
        "to": event.toSquareName,
        "value": event.value
      });
      yield ChessBoardLoadSussess(
        boardModel: state.boardModel,
      );
    }
    // if (game.turn != moveColor) {
    //   final move = typeFromSquareName == "P"
    //       ? event.toSquareName
    //       : typeFromSquareName + event.toSquareName;
    // }
  }
}
