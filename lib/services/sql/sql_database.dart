import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_bank_card/services/sql/models/sql_card_model.dart';

class SqlService{
  static const String _databaseName = 'cards.db';

  static const cardTable = 'cards_data';
  static const columnCardId = 'id';
  static const columnCardName = 'card_name';
  static const columnCardNumber = 'card_number';
  static const columnCardExpiration = 'card_expiration';
  static const columnCardBalance = 'card_balance';
  static const columnCardImage = 'card_image';
  static const columnCardType = 'card_type';
  static const columnCardFileImage = 'file_image';


  SqlService._internal();

  static final SqlService instance = SqlService._internal();
  Database? _database;

  factory SqlService() => instance;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, _databaseName);

    // SQL code to create the database table
    var db = await openDatabase(path, version: 1, onCreate: createTables);
    return db;
  }


  void createTables(Database database, int version) async{
    await database.execute('''CREATE TABLE $cardTable(
      $columnCardId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $columnCardNumber TEXT,
      $columnCardName TEXT,
      $columnCardExpiration TEXT,
      $columnCardBalance TEXT,
      $columnCardImage TEXT,
      $columnCardFileImage TEXT,
      $columnCardType TEXT)
    ''');
  }

  Future<List<Map<String, dynamic>>?> getCardsMapList() async {
    final db = await database;

    var result = await db?.query(cardTable, orderBy: '$columnCardName ASC');
    return result;
  }

  Future<int?> insertCard(SqlCardModel card) async {
    final db = await database;
    var result = await db?.insert(cardTable, card.toJson());
    return result;
  }

  Future<int?> updateCard(SqlCardModel card) async {
    final db = await database;
    var result = await db?.update(cardTable, card.toJson(), where: '$columnCardId = ?', whereArgs: [card.id]);
    return result;
  }

  Future<int?> deleteCard(int id) async {
    final db = await database;
    int? result = await db?.rawDelete('DELETE FROM $cardTable WHERE $columnCardId = $id');
    return result;
  }

  Future<List<SqlCardModel>> getCardList() async {
    var cardMapList = await getCardsMapList();
    int count = cardMapList?.length ?? 0;

    List<SqlCardModel> cardList = [];
    for (int i = 0; i < count; i++) {
      cardList.add(SqlCardModel.fromJson(cardMapList![i]));
    }
    return cardList;
  }

}