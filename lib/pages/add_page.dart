import 'package:flutter/material.dart';
import 'package:my_book_wishlist/domain/book.dart';
import '/repo/repository.dart';

class AddPage extends StatefulWidget {

  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  FormatEnum? _bookFormat = FormatEnum.FIZIC;

  //controllers for input fields
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();


  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add Book"), centerTitle: true),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          decoration: const InputDecoration(labelText: "Title"),
                          style: const TextStyle(fontSize: 20),
                          controller: titleController,
                          validator: (value) {
                            //title text field
                            if (value!.isEmpty) {
                              return "Book title can not be empty";
                            }
                            return null;
                          }),
                      TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Author"),
                          style: const TextStyle(fontSize: 20),
                          controller: authorController,
                          validator: (value) {
                            //title text field
                            if (value!.isEmpty) {
                              return "Book author can not be empty";
                            }
                            return null;
                          }),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Description"),
                        style: const TextStyle(fontSize: 20),
                        controller: descriptionController,
                        maxLines: 4,
                      ),
                      const ListTile(title: Text(
                        "Book format:",
                        style: TextStyle(fontSize: 20)
                      )),
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
                      ),RadioListTile(
                        value: FormatEnum.PDF,
                        title: const Text("PDF"),
                        groupValue: _bookFormat,
                        onChanged: (FormatEnum? value) {
                          setState(() {
                            _bookFormat = FormatEnum.PDF;
                          });
                        },
                      ),
                      TextButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                          child: const Text("Add", style: TextStyle(color: Colors.white,fontSize: 20)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String title = titleController.text;
                              String author = authorController.text;
                              String description = descriptionController.text;
                              Book b = Book(0,title,author,description,_bookFormat!);
                              //return the new book to previous page to be added to list
                              Navigator.pop(context,b);
                            }
                          },
                      )
                    ],
                  )),
            )));

    //the second parameter is sent back as a return value for Navigator.push(..) call
    //Navigator.pop(context,0);
  }
}
