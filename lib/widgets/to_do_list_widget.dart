import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoList extends StatefulWidget {
  State<StatefulWigit remote add origin https://github.com/NestorBurma1/Flutter-codlab2.gitdget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Todo list')),
        body: _buildList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addNewItem(context),
          tooltip: 'Add',
          child: Icon(Icons.add),
        ));
  }

  final List<String> items = ['item1', 'item2', 'item3'];

  Widget _buildList() {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (
          BuildContext ctxt,
          int index,
        ) {
          return Dismissible(
              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                });
              },
              background: Container(
                alignment: Alignment.centerLeft,
                color: Colors.green,
                child: Icon(Icons.check),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: Icon(Icons.cancel,)
              ),
              key: Key(items[index]),
              child: (ListTile(
                  title: Text(items[index]),
                  trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed: () {
                        setState(() {
                          items.removeAt(index);
                        });
                      }))));
        });
  }

  TextEditingController _textFieldController = TextEditingController();

  _addNewItem(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Write new action todo'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: 'Todo action'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Add'),
                onPressed: () {
                  setState(() {
                    if (_textFieldController.text.length > 0) {
                      items.add(_textFieldController.text);
                      _textFieldController.clear();
                    }
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
