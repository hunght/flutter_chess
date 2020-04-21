import 'package:chess_game/blocs/chess_board_bloc.dart';
import 'package:chess_game/chess_board/chess_board.dart';
import 'package:chess_game/utils/supervisor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocSupervisor.delegate = SupervisorBloc();

  List<BlocProvider> _getProviders() => [
        BlocProvider<ChessBoardBloc>(
          create: (BuildContext context) =>
              ChessBoardBloc()..add(ChessBoardFetched()),
        ),
      ];
  runApp(
    MultiBlocProvider(
      providers: _getProviders(),
      child: MaterialApp(
        title: 'Named Routes Demo',
        // Start the app with the "/" named route. In this case, the app starts
        // on the FirstScreen widget.
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) {
            return MyHomePage();
          },
          // When navigating to the "/second" route, build the SecondScreen widget.
          // '/video': (context) => VideoApp(),
        },
      ),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
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
              enableUserMoves: true,
            )
          ],
        ),
      ),
    );
  }
}
