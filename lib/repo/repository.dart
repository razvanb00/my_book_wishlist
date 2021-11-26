import 'package:flutter/material.dart';
import 'package:my_book_wishlist/domain/book.dart';

class BookMockRepository{
  
  late List<Book> booklist = List.empty(growable: true);
  int maxExistingId = 10;

  BookMockRepository(){
    booklist.add(Book(1, "Sapiens", "Yuval N. Hararri", "Scurta descriere a istoriei omenirii", FormatEnum.FIZIC));
    booklist.add(Book(2, "Tata bogat, tata sarac", "Robert Kyiosaky", "Educatie financiara in familie", FormatEnum.FIZIC));
    booklist.add(Book(3, "Titlu test 1", "Autor test 1", "Descriere test 1", FormatEnum.PDF));
    booklist.add(Book(4, "Titlu test 2", "Autor test 2", "Descriere test 2", FormatEnum.PDF));
    booklist.add(Book(5, "Titlu test 3", "Autor test 3", "Descriere test 3", FormatEnum.AUDIOBOOK));
    booklist.add(Book(6, "Titlu test 4", "Autor test 4", "Descriere test 4", FormatEnum.PDF));
    booklist.add(Book(7, "Titlu test 5", "Autor test 5", "Descriere test 5", FormatEnum.AUDIOBOOK));
    booklist.add(Book(8, "Titlu test 6", "Autor test 6", "Descriere test 6", FormatEnum.FIZIC));
    booklist.add(Book(9, "Titlu test 7", "Autor test 7", "Descriere test 7", FormatEnum.PDF));
    booklist.add(Book(10, "Titlu test 8", "Autor test 8", "Descriere test 8", FormatEnum.AUDIOBOOK));
  }

  List<Book> getAllBooks(){
    return booklist;
  }

  void add(Book b){
    b.id = (++maxExistingId);
    booklist.add(b);
  }

  void updateBook(Book updatedBook) {
    for(var b in booklist){
      if (b.id == updatedBook.id){
        b.description = updatedBook.description;
        b.name = updatedBook.name;
        b.author = updatedBook.author;
        b.format = updatedBook.format;
        return;
      }
    }
  }
}