part of 'chess_board_bloc.dart';

abstract class ChessBoardState extends Equatable {
  const ChessBoardState();
}

class ChessBoardInitial extends ChessBoardState {
  @override
  List<Object> get props => [];
}

class ChessBoardLoadSussess extends ChessBoardState {
  final BoardModel boardModel;

  ChessBoardLoadSussess({this.boardModel}) : super();
  @override
  List<Object> get props => [boardModel];
}
