class Book{
  int id;
  String name;
  String author;
  String description;
  FormatEnum format;

  Book(this.id, this.name, this.author, this.description, this.format);

}

enum FormatEnum{
  FIZIC, PDF, AUDIOBOOK
}