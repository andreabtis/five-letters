import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_wordle/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:english_words/english_words.dart';

import 'game.dart';

class _Constants {
  static const String baseUrl =
      'https://api.dictionaryapi.dev/api/v2/entries/en/';
  static String acceptHeader = 'application/json';
}

class _ResponseCodes {
  static int successCode = 200;
}

class GameApi {
  List<String> nounsList =
      nouns.where((element) => element.length == 5).toList();
  List<String> adjectivesList =
      adjectives.where((element) => element.length == 5).toList();

  Future<bool> isAValidWord(String word) async {
    final response =
        await http.get(Uri.parse(_Constants.baseUrl + word), headers: {
      HttpHeaders.acceptHeader: _Constants.acceptHeader,
    });

    if (response.statusCode == _ResponseCodes.successCode) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getRandomWord() async {
    adjectivesList.shuffle();
    nounsList.shuffle();

    for (String noun in nounsList) {
      if (!await Game.isWordUsedBefore(noun)) {
        await SharedPrefs.setWordToGuess(noun);
        await SharedPrefs.addUsedWord(noun);
        debugPrint("NOUN TO GUESS: $noun");
        return;
      }
    }
    for (String adjective in adjectivesList) {
      if (!await Game.isWordUsedBefore(adjective)) {
        await SharedPrefs.setWordToGuess(adjective);
        await SharedPrefs.addUsedWord(adjective);
        debugPrint("ADJECTIVE TO GUESS: $adjective");
        return;
      }
    }
  }
}
