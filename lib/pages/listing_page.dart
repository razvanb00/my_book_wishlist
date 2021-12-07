import 'package:flutter/material.dart';
import 'package:my_book_wishlist/domain/book.dart';
import '/repo/repository.dart';
import '/repo/book_database.dart';
import 'add_page.dart';
import 'update_page.dart';

class ListingPage extends StatefulWidget {
  ListingPage({Key? key}) : super(key: key);

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  final String title = 'My Book Wishlist';

  //method to be called when a book is created and added repository
  Future<void> _pushAddPage() async {
    Book? newBook =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const AddPage();
    }));
    //check to see if the return was made pressing Add button
    if (newBook != null) {
      setState(() {
        DBProvider.instance.add(newBook);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: _buildBookList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddPage,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildBookList(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Book>>(
        future: DBProvider.instance.getBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
          //if the data is not loaded yet
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading...'));
          }
          return snapshot.data!.isEmpty
          ? const Center(child: Text("No data to display."))
          : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: snapshot.data!.length * 2,
            //the rest don't work
            itemBuilder: (context, item) {
              final index = item ~/ 2;
              if (item.isOdd) {
                return const Divider(thickness: 1);
              }
              //print(snapshot.data!.elementAt(index).id);
              return _rowBuilder(snapshot.data!.elementAt(index));
            },
          );
        },
      ),
    );
  }

  Widget _rowBuilder(Book book) {
    return ListTile(
      title: Text(book.name, style: const TextStyle(fontSize: 20)),
      subtitle: Text(" by " + book.author,
          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15)),
      tileColor: Colors.lightGreen,
      onTap: () async {
        Book? updatedBook = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) {
          return UpdatePage(book);
        }));
        if (updatedBook != null) {
          setState(() {
            DBProvider.instance.update(updatedBook);
          });
        }
      },
      trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            //confirmation dialog
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text("Are you sure?"),
                      actions: [
                        TextButton(
                            child: const Text("YES"),
                            onPressed: () {
                              //setState call trigger the rebuild of displayed list
                              setState(() {
                                DBProvider.instance.remove(book.id as int);
                              });
                              Navigator.pop(context, 'YES');
                            }),
                        TextButton(
                            child: const Text("NO"),
                            onPressed: () {
                              Navigator.pop(context, 'NO');
                            })
                      ],
                    ));
          }),
    );
  }
}
