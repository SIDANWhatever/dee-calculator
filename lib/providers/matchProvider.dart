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

class MatchCard {
  List<Map<int, int>> matchCard;

  MatchCard({
    required this.matchCard,
  });
}

class Matches with ChangeNotifier {
  List<Person> persons = [];
  List<int> currentPlayers = [-1, -1, -1, -1];
  List<Match> matches = [];
  List<MatchCard> matchCards = [];
  int x2 = 8;
  int x3 = 10;
  int x4 = 13;
  double unit = 1;

  void addGameRecord(
      int player1,
      int firstPlayerRemainingCard,
      int player2,
      int secondPlayerRemainingCard,
      int player3,
      int thirdPlayerRemainingCard,
      int player4,
      int fourthPlayerRemainingCard) {
    // Calculate the true result
    int score1 = 0;
    int score2 = 0;
    int score3 = 0;
    int score4 = 0;

    score1 = (secondPlayerRemainingCard - firstPlayerRemainingCard) +
        (thirdPlayerRemainingCard - firstPlayerRemainingCard) +
        (fourthPlayerRemainingCard - firstPlayerRemainingCard);

    score2 = (firstPlayerRemainingCard - secondPlayerRemainingCard) +
        (thirdPlayerRemainingCard - secondPlayerRemainingCard) +
        (fourthPlayerRemainingCard - secondPlayerRemainingCard);

    score3 = (firstPlayerRemainingCard - thirdPlayerRemainingCard) +
        (secondPlayerRemainingCard - thirdPlayerRemainingCard) +
        (fourthPlayerRemainingCard - thirdPlayerRemainingCard);

    score4 = (firstPlayerRemainingCard - fourthPlayerRemainingCard) +
        (secondPlayerRemainingCard - fourthPlayerRemainingCard) +
        (thirdPlayerRemainingCard - fourthPlayerRemainingCard);

    Map<int, int> record1 = <int, int>{player1: score1};
    Map<int, int> record2 = <int, int>{player2: score2};
    Map<int, int> record3 = <int, int>{player3: score3};
    Map<int, int> record4 = <int, int>{player4: score4};

    Map<int, int> cardRecord1 = <int, int>{player1: firstPlayerRemainingCard};
    Map<int, int> cardRecord2 = <int, int>{player2: secondPlayerRemainingCard};
    Map<int, int> cardRecord3 = <int, int>{player3: thirdPlayerRemainingCard};
    Map<int, int> cardRecord4 = <int, int>{player4: fourthPlayerRemainingCard};

    persons[currentPlayers[player1]].addRecord(matches.length, score1);
    persons[currentPlayers[player2]].addRecord(matches.length, score2);
    persons[currentPlayers[player3]].addRecord(matches.length, score3);
    persons[currentPlayers[player4]].addRecord(matches.length, score4);

    matches.add(Match(match: [
      record1,
      record2,
      record3,
      record4,
    ]));

    matchCards.add(MatchCard(
        matchCard: [cardRecord1, cardRecord2, cardRecord3, cardRecord4]));
    notifyListeners();
  }

  void addUser(Person person, int userPosition) {
    if (currentPlayers[userPosition] == -1) {
      currentPlayers[userPosition] = persons.length;
    } else {
      var toReplace = currentPlayers.indexOf(-1);
      if (toReplace != -1) {
        currentPlayers[toReplace] = persons.length;
      }
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

  void setUnit(double mark) {
    unit = mark;
    notifyListeners();
  }

  void changePlayer(int currentIndex, int newPlayer) {
    currentPlayers[currentIndex] = newPlayer;
    notifyListeners();
  }

  void resetAll() {
    persons = [];
    matches = [];
    currentPlayers = [-1, -1, -1, -1];
    notifyListeners();
  }
}
