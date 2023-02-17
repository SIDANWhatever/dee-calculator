import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pageProvider.dart';
import '../providers/matchProvider.dart';
import '../providers/showUnitProvider.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: <Widget>[
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
          child: context.watch<Matches>().matches.isNotEmpty
              ? const SingleChildScrollView(
                  scrollDirection: Axis.vertical, child: GameRecord())
              : const Text("Start a game to view record!")),
    ]);
  }
}

class GameRecord extends StatelessWidget {
  const GameRecord({super.key});

  List<Widget> loadRecords(BuildContext context) {
    List<Widget> personRecords = [];
    for (int i = 0; i < context.watch<Matches>().persons.length; i++) {
      personRecords.add(PersonRecord(
          person: context.watch<Matches>().persons[i], playerIndex: i));
    }
    return personRecords;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: const Alignment(0.0, 0.2),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: loadRecords(context),
            )));
  }
}

class PersonRecord extends StatelessWidget {
  final Person person;
  final int playerIndex;
  const PersonRecord(
      {required this.person, required this.playerIndex, super.key});

  List<Widget> loadPersonRecord(BuildContext context) {
    List<Widget> personRecord = [];

    bool showDollar = context.watch<ShowUnit>().showUnit == 0;

    if (showDollar) {
      for (var match in context.watch<Matches>().matches) {
        if (match.match[0][playerIndex] != null) {
          personRecord.add(Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                  '${match.match[0][playerIndex]! * context.watch<Matches>().unit}')));
        }
        if (match.match[1][playerIndex] != null) {
          personRecord.add(Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                  '${match.match[1][playerIndex]! * context.watch<Matches>().unit}')));
        }
        if (match.match[2][playerIndex] != null) {
          personRecord.add(Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                  '${match.match[2][playerIndex]! * context.watch<Matches>().unit}')));
        }
        if (match.match[3][playerIndex] != null) {
          personRecord.add(Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                  '${match.match[3][playerIndex]! * context.watch<Matches>().unit}')));
        }
        if (match.match[0][playerIndex] == null &&
            match.match[1][playerIndex] == null &&
            match.match[2][playerIndex] == null &&
            match.match[3][playerIndex] == null) {
          personRecord.add(Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: const Text("-")));
        }
      }
    } else {
      for (var match in context.watch<Matches>().matchCards) {
        if (match.matchCard[0][playerIndex] != null) {
          personRecord.add(Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text('${match.matchCard[0][playerIndex]!.round()}')));
        }
        if (match.matchCard[1][playerIndex] != null) {
          personRecord.add(Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text('${match.matchCard[1][playerIndex]!.round()}')));
        }
        if (match.matchCard[2][playerIndex] != null) {
          personRecord.add(Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text('${match.matchCard[2][playerIndex]!.round()}')));
        }
        if (match.matchCard[3][playerIndex] != null) {
          personRecord.add(Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text('${match.matchCard[3][playerIndex]!.round()}')));
        }
        if (match.matchCard[0][playerIndex] == null &&
            match.matchCard[1][playerIndex] == null &&
            match.matchCard[2][playerIndex] == null &&
            match.matchCard[3][playerIndex] == null) {
          personRecord.add(Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: const Text("-")));
        }
      }
    }

    return personRecord;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.orange),
            borderRadius: BorderRadius.circular(10)),
        width: 70,
        child: Column(
            children: <Widget>[
                  SizedBox(
                      height: 100,
                      child: Column(children: [
                        Container(
                            alignment: Alignment.center,
                            height: 20,
                            child: Text(
                              person.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            )),
                        Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          alignment: Alignment.center,
                          child: Text(
                            '${person.cumulatedScore * context.watch<Matches>().unit}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 16),
                          ),
                        )
                      ])),
                ] +
                loadPersonRecord(context)));
  }
}
