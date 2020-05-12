import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            color: Color.fromRGBO(52, 53, 64, 1.0),
            //color: Color.fromRGBO(11,0,0, 1.0),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: _Body(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  double localX = 0;
  double localY = 0;
  bool defaultPosition = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double percentageX = (localX / (size.width - 40)) * 100;
    double percentageY = (localY / 230) * 100;
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(defaultPosition ? 0 : (0.3 * (percentageY / 50) + -0.3))
        ..rotateY(defaultPosition ? 0 : (-0.3 * (percentageX / 50) + 0.3)),
      alignment: FractionalOffset.center,
      child: Container(
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          color: Color(0xFFCCCCCC),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 60),
                color: Color.fromARGB(120, 0, 0, 0),
                blurRadius: 22,
                spreadRadius: -20),
          ],
        ),
        child: GestureDetector(
          onPanCancel: () => setState(() => defaultPosition = true),
          onPanDown: (_) => setState(() => defaultPosition = false),
          onPanEnd: (_) => setState(() {
            localY = 115;
            localX = (size.width - 40) / 2;
            defaultPosition = true;
          }),
          onPanUpdate: (details) {
            if (mounted) setState(() => defaultPosition = false);
            if (details.localPosition.dx > 0 &&
                details.localPosition.dy < 230) {
              if (details.localPosition.dx < size.width - 40 &&
                  details.localPosition.dy > 0) {
                localX = details.localPosition.dx;
                localY = details.localPosition.dy;
              }
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.black,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(
                          defaultPosition ? 0.0 : (8 * (percentageX / 50) + -8),
                          defaultPosition ? 0.0 : (8 * (percentageY / 50) + -8),
                          0.0),
                    alignment: FractionalOffset.center,
                    child: Opacity(
                      opacity: 0.4,
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/sfxp-crossplatform.appspot.com/o/resources%2Fcardbg.jpg?alt=media',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Transform(
                        transform: Matrix4.translationValues(
                          (size.width - 90) - localX,
                          (230 - 50) - localY,
                          0.0,
                        ),
                        child: AnimatedOpacity(
                          opacity: defaultPosition ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.decelerate,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.22),
                                blurRadius: 100,
                                spreadRadius: 40,
                              )
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(
                          defaultPosition
                              ? 0.0
                              : (15 * (percentageX / 50) + -15),
                          defaultPosition
                              ? 0.0
                              : (15 * (percentageY / 50) + -15),
                          0.0),
                    alignment: FractionalOffset.center,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 22, top: 15),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/sfxp-crossplatform.appspot.com/o/resources%2Fsfxp_white.png?alt=media",
                                    width: 90,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            '5048 3817 4921 8497',
                            style: TextStyle(
                              fontFamily: "CreditCard",
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              Text(
                                'THRU 09/22',
                                style: TextStyle(
                                    fontFamily: "CreditCard",
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
