part of 'chess_board_bloc.dart';

enum EventTypeSussess {
  promotionDialog,
  darkBrown,
}

abstract class ChessBoardState extends Equatable {
  final BoardModel boardModel;
  const ChessBoardState({this.boardModel});
}

class ChessBoardInitial extends ChessBoardState {
  @override
  List<Object> get props => [];
}

class ChessBoardLoadSussess extends ChessBoardState {
  final EventTypeSussess eventTypeSussess;
  final String from;
  final String to;
  final BoardModel boardModel;

  ChessBoardLoadSussess(
      {this.boardModel, this.eventTypeSussess, this.from, this.to})
      : super();
  @override
  List<Object> get props => [boardModel, eventTypeSussess];
}
