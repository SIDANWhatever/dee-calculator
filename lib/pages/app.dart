import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pageProvider.dart';
import '../providers/matchProvider.dart';
import '../components/addUser.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return
        // Column(children: <Widget>[
        Stack(children: <Widget>[
      SizedBox.expand(
          child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) => {
                    if (details.primaryVelocity! < 0)
                      {context.read<Pages>().changePage(1)}
                    else if (details.primaryVelocity! > 0)
                      {context.read<Pages>().changePage(0)}
                  })),
      Container(
          alignment: const Alignment(0.0, -0.6),
          child: MyCard(
              player: context.watch<Matches>().currentPlayers[0],
              userPosition: 0)),
      Container(
          alignment: const Alignment(-0.7, 0.0),
          child: MyCard(
              player: context.watch<Matches>().currentPlayers[1],
              userPosition: 1)),
      Container(
          alignment: const Alignment(0.7, 0.0),
          child: MyCard(
              player: context.watch<Matches>().currentPlayers[2],
              userPosition: 2)),
      Container(
          alignment: const Alignment(0.0, 0.6),
          child: MyCard(
              player: context.watch<Matches>().currentPlayers[3],
              userPosition: 3))
    ]);
  }
}

class MyCard extends StatefulWidget {
  final int player;
  final int userPosition;
  const MyCard({required this.player, required this.userPosition, super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: 130,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 5,
            child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => SimpleDialog(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          children: [
                            context.watch<Matches>().currentPlayers.contains(-1)
                                ? AddUser(userPosition: widget.userPosition)
                                : Result(winner: widget.player)
                          ],
                        ));
              },
              child: Container(
                child: widget.player == -1
                    ? const Icon(Icons.group_add)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context
                                .watch<Matches>()
                                .persons[widget.player]
                                .name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${context.watch<Matches>().persons[widget.player].cumulatedScore * context.watch<Matches>().unit}',
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
              ),
            )));
  }
}

class Result extends StatefulWidget {
  final int winner;
  const Result({required this.winner, super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void dispose() {
    super.dispose();
  }

  int firstPlayerRemainingCard = 1;
  int secondPlayerRemainingCard = 1;
  int thirdPlayerRemainingCard = 1;
  int fourthPlayerRemainingCard = 1;

  void countCards(BuildContext context, int player, int noOfCards) {
    var countedCards = noOfCards;
    if (noOfCards >= context.read<Matches>().x2) {
      countedCards = noOfCards * 2;
    }
    if (noOfCards >= context.read<Matches>().x3) {
      countedCards = noOfCards * 3;
    }
    if (noOfCards >= context.read<Matches>().x4) {
      countedCards = noOfCards * 4;
    }
    setState(() {
      switch (player) {
        case 0:
          firstPlayerRemainingCard = countedCards;
          break;
        case 1:
          secondPlayerRemainingCard = countedCards;
          break;
        case 2:
          thirdPlayerRemainingCard = countedCards;
          break;
        case 3:
          fourthPlayerRemainingCard = countedCards;
          break;
      }
    });
  }

  void click(BuildContext context) {
    // Calculate each's win and loss
    int firstPlayerIndex = context.read<Matches>().currentPlayers[0];
    int secondPlayerIndex = context.read<Matches>().currentPlayers[1];
    int thirdPlayerIndex = context.read<Matches>().currentPlayers[2];
    int fourthPlayerIndex = context.read<Matches>().currentPlayers[3];

    // // Calculate the true result
    // int firstPlayerResult = 0;
    // int secondPlayerResult = 0;
    // int thirdPlayerResult = 0;
    // int fourthPlayerResult = 0;

    // firstPlayerResult = (secondPlayerRemainingCard - firstPlayerRemainingCard) +
    //     (thirdPlayerRemainingCard - firstPlayerRemainingCard) +
    //     (fourthPlayerRemainingCard - firstPlayerRemainingCard);

    // secondPlayerResult =
    //     (firstPlayerRemainingCard - secondPlayerRemainingCard) +
    //         (thirdPlayerRemainingCard - secondPlayerRemainingCard) +
    //         (fourthPlayerRemainingCard - secondPlayerRemainingCard);

    // thirdPlayerResult = (firstPlayerRemainingCard - thirdPlayerRemainingCard) +
    //     (secondPlayerRemainingCard - thirdPlayerRemainingCard) +
    //     (fourthPlayerRemainingCard - thirdPlayerRemainingCard);

    // fourthPlayerResult =
    //     (firstPlayerRemainingCard - fourthPlayerRemainingCard) +
    //         (secondPlayerRemainingCard - fourthPlayerRemainingCard) +
    //         (thirdPlayerRemainingCard - fourthPlayerRemainingCard);

    // Write record in Match
    context.read<Matches>().addGameRecord(
        firstPlayerIndex,
        firstPlayerRemainingCard,
        secondPlayerIndex,
        secondPlayerRemainingCard,
        thirdPlayerIndex,
        thirdPlayerRemainingCard,
        fourthPlayerIndex,
        fourthPlayerRemainingCard);

    // Reset variables
    firstPlayerRemainingCard = 1;
    secondPlayerRemainingCard = 1;
    thirdPlayerRemainingCard = 1;
    fourthPlayerRemainingCard = 1;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 650,
        width: 320,
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Stack(
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      child: const Text(
                        "完！",
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                      alignment: const Alignment(0.0, -0.7),
                      child: ScoreCard(
                          setCountCallback: countCards,
                          win: context.watch<Matches>().currentPlayers[0] ==
                              widget.winner,
                          player: context.watch<Matches>().currentPlayers[0])),
                  Container(
                      alignment: const Alignment(-1.0, 0.0),
                      child: ScoreCard(
                          setCountCallback: countCards,
                          win: context.watch<Matches>().currentPlayers[1] ==
                              widget.winner,
                          player: context.watch<Matches>().currentPlayers[1])),
                  Container(
                      alignment: const Alignment(1.0, 0.0),
                      child: ScoreCard(
                          setCountCallback: countCards,
                          win: context.watch<Matches>().currentPlayers[2] ==
                              widget.winner,
                          player: context.watch<Matches>().currentPlayers[2])),
                  Container(
                      alignment: const Alignment(0.0, 0.7),
                      child: ScoreCard(
                          setCountCallback: countCards,
                          win: context.watch<Matches>().currentPlayers[3] ==
                              widget.winner,
                          player: context.watch<Matches>().currentPlayers[3])),
                  Container(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        color: Colors.white,
                        child: TextButton(
                          child:
                              const Text('下鋪!', style: TextStyle(fontSize: 20)),
                          onPressed: () => click(context),
                        ),
                      )),
                ],
              )),
        ));
  }
}

class ScoreCard extends StatefulWidget {
  final Function(BuildContext, int, int) setCountCallback;
  final int player;
  final bool win;
  const ScoreCard(
      {required this.player,
      required this.win,
      required this.setCountCallback,
      super.key});

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  @override
  void initState() {
    super.initState();
    if (widget.win == true) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => widget.setCountCallback(context, widget.player, 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.win
        ? WinnerDisplay(player: widget.player)
        : Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.white,
            elevation: 5,
            child: SizedBox(
              height: 140,
              width: 130,
              child: Stack(children: <Widget>[
                PlayerName(player: widget.player),
                Container(
                    height: 140,
                    padding: const EdgeInsets.only(top: 60),
                    // width: 130,
                    alignment: Alignment.bottomCenter,
                    child: ListWheelScrollView.useDelegate(
                        onSelectedItemChanged: (i) => {
                              widget.setCountCallback(
                                  context, widget.player, i + 1)
                            },
                        magnification: 1.5,
                        overAndUnderCenterOpacity: 0.6,
                        itemExtent: 22,
                        perspective: 0.001,
                        physics: const FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                            childCount: 13,
                            builder: (context, index) {
                              return PointTile(point: index);
                            })))
              ]),
            ));
  }
}

class WinnerDisplay extends StatelessWidget {
  final int player;
  const WinnerDisplay({required this.player, super.key});

  void click(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.white,
        elevation: 5,
        child: TextButton(
            onPressed: () => click(context),
            child: SizedBox(
                height: 125,
                width: 100,
                child: Stack(children: <Widget>[
                  PlayerName(player: player),
                  Container(
                      alignment: Alignment.center,
                      child: const Text("爽皮", style: TextStyle(fontSize: 20)))
                ]))));
  }
}

class PlayerName extends StatelessWidget {
  final int player;
  const PlayerName({required this.player, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        alignment: const Alignment(0.0, 0.5),
        child: Text(context.watch<Matches>().persons[player].name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )));
  }
}

// For the Score Card Scroll Wheel

class PointTile extends StatelessWidget {
  final int point;

  const PointTile({required this.point, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      (point + 1).toString(),
      style: const TextStyle(fontSize: 15, color: Colors.blueGrey),
    );
  }
}
