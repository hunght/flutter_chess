import 'package:chess/chess.dart' as chess;
import 'package:chess_game/chess_board/chess_board_type.dart';

typedef Null MoveCallback(String moveNotation);
typedef Null CheckMateCallback(PieceColor color);
typedef Null CheckCallback(PieceColor color);

class BoardModel {
  /// The size of the board (The board is a square)
  double size;

  /// If the white side of the board is towards the user
  bool whiteSideTowardsUser;

  /// User moves can be enabled or disabled by this property
  bool enableUserMoves;

  /// Creates a logical game
  chess.Chess game = chess.Chess();

  /// Refreshes board
  void refreshBoard() {
    if (game.in_checkmate) {
      final onCheckMate =
          game.turn == chess.Color.WHITE ? PieceColor.White : PieceColor.Black;
    } else if (game.in_draw ||
        game.in_stalemate ||
        game.in_threefold_repetition ||
        game.insufficient_material) {
    } else if (game.in_check) {
      final onCheck =
          game.turn == chess.Color.WHITE ? PieceColor.White : PieceColor.Black;
    }
    // notifyListeners();
  }

  BoardModel({this.size, this.whiteSideTowardsUser, this.enableUserMoves});
}
