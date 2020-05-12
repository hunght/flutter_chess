part of 'chess_board_bloc.dart';

abstract class ChessBoardEvent extends Equatable {
  const ChessBoardEvent();
}

class ChessBoardFetched extends ChessBoardEvent {
  @override
  List<Object> get props => [];
}

class ChessBoardPieceMoved extends ChessBoardEvent {
  final String fromSquareName;
  final String toSquareName;
  final String value;
  ChessBoardPieceMoved({this.fromSquareName, this.toSquareName, this.value});
  @override
  List<Object> get props => [fromSquareName, toSquareName];
}
