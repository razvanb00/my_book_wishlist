import 'dart:async';

import 'package:my_book_wishlist/domain/book.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBProvider {
  DBProvider._privateConstructor();

  static final DBProvider instance = DBProvider._privateConstructor();

  static Database? _database;

  //singleton
  Future<Database> get database async => _database ??= await initDB();

  //used to create the database and books table if not already existing
  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'books.db');

    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books(
        id INTEGER PRIMARY KEY,
        name TEXT,
        author TEXT,
        description TEXT,
        format TEXT
      )
    ''');
  }

  Future<List<Book>> getBooks() async {
    Database db = await instance.database;
    var books = await db.query('books', orderBy: 'name');
    List<Book> bookList = books.isNotEmpty
        ? books.map((book) => Book.fromMap(book)).toList()
        : [];
    return bookList;
  }

  Future<int> add(Book book) async {
    Database db = await instance.database;
    return await db.insert('books', book.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Book book) async {
    Database db = await instance.database;
    return await db
        .update("books", book.toMap(), where: 'id=?', whereArgs: [book.id]);
  }
}
