import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chess_game/models/board_model.dart';
import 'package:equatable/equatable.dart';

part 'chess_board_event.dart';
part 'chess_board_state.dart';

class ChessBoardBloc extends Bloc<ChessBoardEvent, ChessBoardState> {
  @override
  ChessBoardState get initialState => ChessBoardInitial();

  @override
  Stream<ChessBoardState> mapEventToState(
    ChessBoardEvent event,
  ) async* {
    if (event is ChessBoardFetched) {
      yield* _mapLoadAccountsToState();
    }
  }

  Stream<ChessBoardState> _mapLoadAccountsToState() async* {
    yield ChessBoardLoadSussess(
        boardModel:
            BoardModel(whiteSideTowardsUser: true, enableUserMoves: true));
  }
}
