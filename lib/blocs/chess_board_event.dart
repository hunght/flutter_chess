part of 'chess_board_bloc.dart';

abstract class ChessBoardEvent extends Equatable {
  const ChessBoardEvent();
}

class ChessBoardFetched extends ChessBoardEvent {
  @override
  List<Object> get props => [];
}
