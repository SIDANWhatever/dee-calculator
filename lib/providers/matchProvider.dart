import 'package:flutter/material.dart';

class Person {
  final String name;
  // final Icon icon;
  // Map<int, int> records;
  int cumulatedScore;

  void addRecord(int game, int score) {
    // records[game] = score;
    cumulatedScore += score;
  }

  Person(
      {required this.name,
      // required this.icon,
      // required this.records,
      this.cumulatedScore = 0});
}

class Match {
  List<Map<int, int>> match;

  Match({
    required this.match,
  });
}

class Matches with ChangeNotifier {
  List<Person> persons = [];
  List<int> currentPlayers = [];
  List<Match> matches = [];
  int x2 = 8;
  int x3 = 10;
  int x4 = 13;

  void addGameRecord(int player1, int score1, int player2, int score2,
      int player3, int score3, int player4, int score4) {
    Map<int, int> record1 = <int, int>{player1: score1};
    Map<int, int> record2 = <int, int>{player2: score2};
    Map<int, int> record3 = <int, int>{player3: score3};
    Map<int, int> record4 = <int, int>{player4: score4};

    persons[player1].addRecord(matches.length, score1);
    persons[player2].addRecord(matches.length, score2);
    persons[player3].addRecord(matches.length, score3);
    persons[player4].addRecord(matches.length, score4);

    matches.add(Match(match: [
      record1,
      record2,
      record3,
      record4,
    ]));
    notifyListeners();
  }

  void addUser(Person person) {
    if (persons.length < 4) {
      currentPlayers.add(persons.length);
    }
    persons.add(person);
    notifyListeners();
  }

  void removeUser(Person person) {
    persons.remove(person);
    notifyListeners();
  }

  void setX2(int mark) {
    x2 = mark;
    notifyListeners();
  }

  void setX3(int mark) {
    x3 = mark;
    notifyListeners();
  }

  void setX4(int mark) {
    x4 = mark;
    notifyListeners();
  }

  void changePlayer(int currentIndex, int newPlayer) {
    currentPlayers[currentIndex] = newPlayer;
    notifyListeners();
  }

  void resetAll() {
    persons = [];
    matches = [];
    currentPlayers = [];
    notifyListeners();
  }
}
