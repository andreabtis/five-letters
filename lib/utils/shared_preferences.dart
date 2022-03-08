import 'package:shared_preferences/shared_preferences.dart';

import '../features/game/matrix.dart';

class _Keys {
  static const String userName = 'userName';
  static const String scores = 'scores';
  static const String word = 'word';
  static const String gamesPlayed = 'gamesPlayed';
  static const String gamesWon = 'gamesWon';
  static const String lastGameWon = 'lastGameWon';
  static const String gameWinRate = 'gamesWonRatio';
  static const String usedWords = 'usedWords';
}

class SharedPrefs {
  Future<SharedPreferences> _instance() async =>
      await SharedPreferences.getInstance();

  static setUserName(String userName) async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    _prefs.setString(_Keys.userName, userName);
  }

  static setGamesPlayed(int gamesPlayed) async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    _prefs.setInt(_Keys.gamesPlayed, gamesPlayed);
  }

  static setWonGames(int gamesWon) async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    _prefs.setInt(_Keys.gamesWon, gamesWon);
  }

  static Future<String?> getUserName() async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    return _prefs.getString(_Keys.userName);
  }

  static Future<int?> getGamesPlayed() async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    return _prefs.getInt(_Keys.gamesPlayed);
  }

  static Future<int?> getWonGames() async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    return _prefs.getInt(_Keys.gamesWon);
  }

  static Future<bool?> getlastGameResult() async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    return _prefs.getBool(_Keys.lastGameWon);
  }

  static Future<double?> getGameWinRate() async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    return _prefs.getDouble(_Keys.gameWinRate);
  }

  static setGameWinRate(double winRate) async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    _prefs.setDouble(_Keys.gameWinRate, winRate);
  }

  static setLastGameResult(bool isWin) async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    _prefs.setBool(_Keys.lastGameWon, isWin);
  }

  static setWordToGuess(String word) async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    _prefs.setString(_Keys.word, word);
    Matrix.wordTarget = word;
  }

  static Future<String> getTheWordToGuess() async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    return _prefs.getString(_Keys.word) ?? '';
  }

  static addUsedWord(String usedWord) async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    List<String> usedWords = await getUsedWords();
    usedWords.add(usedWord);
    _prefs.setStringList(_Keys.usedWords, usedWords);
  }

  static Future<List<String>> getUsedWords() async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    return _prefs.getStringList(_Keys.usedWords) ?? [];
  }

  static Future<List<String>> getAllScores() async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    return _prefs.getStringList(_Keys.scores) ?? [];
  }

  static addLastScore(String score) async {
    SharedPreferences _prefs = await SharedPrefs()._instance();
    List<String> scores = await getAllScores();
    scores.add(score);
    _prefs.setStringList(_Keys.scores, scores);
  }

  static updateGamesWon(bool hasWon) async {
    int? wonGames = await getWonGames();

    await getWonGames() == null
        ? await setWonGames(hasWon ? 1 : 0)
        : await setWonGames(hasWon ? wonGames! + 1 : wonGames!);
  }

  static updateGamesPlayed() async {
    int? gamesPlayed = await getGamesPlayed();

    await getGamesPlayed() == null
        ? await setGamesPlayed(1)
        : await setGamesPlayed(gamesPlayed! + 1);
  }

  static updateGameRatio() async {
    int? gamesWon = await getWonGames();
    int? gamesPlayed = await getGamesPlayed();

    gamesWon == null || gamesPlayed == null
        ? await setGameWinRate(0)
        : await setGameWinRate(
            ((gamesWon / gamesPlayed) * 100).toDouble(),
          );
  }
}
