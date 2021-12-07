import 'package:flutter/material.dart';
import 'package:my_book_wishlist/domain/book.dart';

class UpdatePage extends StatefulWidget {
  Book? currentBook;

  UpdatePage(this.currentBook, {Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  FormatEnum? _bookFormat;

  //controllers for input fields
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();

  bool _isReadonly = true;

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //if is null then assign value
    _bookFormat ??= widget.currentBook!.format;

    titleController.text = widget.currentBook!.name;
    authorController.text = widget.currentBook!.author;
    descriptionController.text = widget.currentBook!.description;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                      readOnly: _isReadonly,
                      decoration: const InputDecoration(labelText: "Title"),
                      style: const TextStyle(fontSize: 20),
                      controller: titleController,
                      onChanged: (_) {
                          widget.currentBook!.name = titleController.text;
                      },
                      validator: (value) {
                        //title text field
                        if (value!.isEmpty) {
                          return "Book title can not be empty";
                        }
                        return null;
                      }),
                  TextFormField(
                      readOnly: _isReadonly,
                      decoration: const InputDecoration(labelText: "Author"),
                      style: const TextStyle(fontSize: 20),
                      controller: authorController,
                      onChanged: (_) {
                          widget.currentBook!.author = authorController.text;
                      },
                      validator: (value) {
                        //title text field
                        if (value!.isEmpty) {
                          return "Book author can not be empty";
                        }
                        return null;
                      }),
                  TextFormField(
                    readOnly: _isReadonly,
                    decoration: const InputDecoration(labelText: "Description"),
                    style: const TextStyle(fontSize: 20),
                    controller: descriptionController,
                    onChanged: (_) {
                        widget.currentBook!.description = descriptionController.text;
                    },
                    maxLines: 4,
                  ),
                  const ListTile(
                      title:
                          Text("Book format:", style: TextStyle(fontSize: 20))),
                  RadioListTile(
                    value: FormatEnum.FIZIC,
                    title: const Text("PHISICAL"),
                    groupValue: _bookFormat,
                    onChanged: (FormatEnum? value) {
                      setState(() {
                        _bookFormat = FormatEnum.FIZIC;
                      });
                    },
                  ),
                  RadioListTile(
                    value: FormatEnum.AUDIOBOOK,
                    title: const Text("AUDIOBOOK"),
                    groupValue: _bookFormat,
                    onChanged: (FormatEnum? value) {
                      setState(() {
                        _bookFormat = FormatEnum.AUDIOBOOK;
                      });
                    },
                  ),
                  RadioListTile(
                    value: FormatEnum.PDF,
                    title: const Text("PDF"),
                    groupValue: _bookFormat,
                    onChanged: (FormatEnum? value) {
                      setState(() {
                        _bookFormat = FormatEnum.PDF;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green)),
                        child: const Text("Edit",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        onPressed: () {
                          if (_isReadonly) {
                            setState(() {
                              _isReadonly = false;
                            });
                          }
                        },
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green)),
                        child: const Text("Update",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String title = titleController.text;
                            String author = authorController.text;
                            String description = descriptionController.text;
                            Book updatedBook = Book(
                                id: widget.currentBook!.id,
                                name: title,
                                author: author,
                                description: description,
                                format: _bookFormat!);
                            //return the updated book to previous page to be modified
                            Navigator.pop(context, updatedBook);
                          }
                        },
                      )
                    ],
                  )
                ],
              )),
            )));

    //the second parameter is sent back as a return value for Navigator.push(..) call
    //Navigator.pop(context,0);
  }
}
