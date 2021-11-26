import 'package:flutter/material.dart';
import 'package:my_book_wishlist/domain/book.dart';
import '/repo/repository.dart';
import 'add_page.dart';
import 'update_page.dart';

class ListingPage extends StatefulWidget {
  ListingPage({Key? key}) : super(key: key);

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  final String title = 'My Book Wishlist';
  final BookMockRepository repo = BookMockRepository();

  //method to be called when a book is created and added repository
  Future<void> _pushAddPage() async {
    Book? newBook =
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const AddPage();
    }));
    //check to see if the return was made pressing Add button
    if (newBook != null) {
      setState(() {
        repo.add(newBook);
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
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: repo.booklist.length * 2,
      itemBuilder: (context, item) {
        final index = item ~/ 2;
        if (item.isOdd) {
          return const Divider(thickness: 1);
        }
        return _rowBuilder(repo.booklist.elementAt(index));
      },
    );
  }

  Widget _rowBuilder(Book book) {
    return ListTile(
      title: Text(book.name, style: TextStyle(fontSize: 20)),
      subtitle: Text(" by " + book.author,
          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15)),
      tileColor: Colors.lightGreen,
      onTap: () async {
        Book? updatedBook = await Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return UpdatePage(book);
        }));
        if(updatedBook != null){
          setState(() {
            repo.updateBook(updatedBook);
          });
        }
      },
      trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            //confirmation dialog
            showDialog(
                context: context,
                builder: (_) =>
                    AlertDialog(
                      title: const Text("Are you sure?"),
                      actions: [
                        TextButton(
                            child: const Text("YES"),
                            onPressed: () {
                              //setState call trigger the rebuild of displayed list
                              setState(() {
                                repo.booklist.remove(book);
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
