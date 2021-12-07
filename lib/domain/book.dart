class Book {
  int? id;
  String name;
  String author;
  String description;
  FormatEnum format;

  Book({this.id, required this.name, required this.author, required this.description, required this.format});
  //Book(this.id, this.name, this.author, this.description, this.format);

  factory Book.fromMap(Map<String, dynamic> json) =>
      Book(
        id: json['id'],
        name: json['name'],
        author: json['author'],
        description: json['description'],
        format: getEnumFromString(json['format'].toString()),
      );

  //converts a book object to a map used by database when performing CRUD operations
  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
      'author' : author,
      'description': description,
      'format': format.toString(),
    };
  }

  static FormatEnum getEnumFromString(String format) {
    FormatEnum f;
    format == 'FormatEnum.PDF'
        ? f = FormatEnum.PDF
        : (format == 'FormatEnum.AUDIOBOOK'
            ? f = FormatEnum.AUDIOBOOK
            : f = FormatEnum.FIZIC);
    return f;
  }

}

enum FormatEnum {
  FIZIC,
  PDF,
  AUDIOBOOK,
}