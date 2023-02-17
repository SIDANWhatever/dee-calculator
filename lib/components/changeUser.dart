import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/matchProvider.dart';

class ChangeUser extends StatefulWidget {
  const ChangeUser({super.key});

  @override
  State<ChangeUser> createState() => _ChangeUserState();
}

class _ChangeUserState extends State<ChangeUser> {
  @override
  void dispose() {
    super.dispose();
  }

  int toSitOut = 0;
  int toSitIn = 0;

  void setSitOut(int index) {
    setState(() {
      toSitOut = index;
    });
  }

  void setSitIn(int index) {
    setState(() {
      toSitIn = index;
    });
  }

  void click(BuildContext context) {
    context.read<Matches>().changePlayer(toSitOut, toSitIn);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400,
        width: 220,
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // const Expanded(
                  //     child: Text(
                  //   "請輸入玩家名字",
                  //   style: TextStyle(fontSize: 20),
                  // )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid))),
                      child: Row(children: [
                        const Text("換出"),
                        PlayerScroll(
                            isSitIn: false, setPlayerCallback: setSitOut)
                      ])),
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(children: [
                        const Text("換入"),
                        PlayerScroll(isSitIn: true, setPlayerCallback: setSitIn)
                      ])),
                  Expanded(
                    child: TextButton(
                      child: const Text('確定'),
                      onPressed: () => click(context),
                    ),
                  ),
                ],
              )),
        ));
  }
}

class PlayerScroll extends StatefulWidget {
  final Function(int) setPlayerCallback;
  final bool isSitIn;
  const PlayerScroll(
      {required this.isSitIn, required this.setPlayerCallback, super.key});

  @override
  State<PlayerScroll> createState() => _PlayerScrollState();
}

class _PlayerScrollState extends State<PlayerScroll> {
  int getNumberOfTile(BuildContext context) {
    if (widget.isSitIn) {
      return context.watch<Matches>().persons.length;
    } else {
      return context.watch<Matches>().currentPlayers.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        width: 130,
        alignment: Alignment.bottomCenter,
        child: ListWheelScrollView.useDelegate(
            onSelectedItemChanged: (i) => {widget.setPlayerCallback(i)},
            magnification: 1.5,
            overAndUnderCenterOpacity: 0.6,
            itemExtent: 25,
            perspective: 0.001,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
                childCount: getNumberOfTile(context),
                builder: (context, index) {
                  if (widget.isSitIn) {
                    return PlayerTile(player: index);
                  } else {
                    return CurrentPlayerTile(player: index);
                  }
                })));
  }
}

class CurrentPlayerTile extends StatelessWidget {
  final int player;

  const CurrentPlayerTile({required this.player, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context
          .watch<Matches>()
          .persons[context.watch<Matches>().currentPlayers[player]]
          .name,
      style: const TextStyle(fontSize: 15, color: Colors.blueGrey),
    );
  }
}

class PlayerTile extends StatelessWidget {
  final int player;

  const PlayerTile({required this.player, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<Matches>().persons[player].name,
      style: const TextStyle(fontSize: 15, color: Colors.blueGrey),
    );
  }
}
