import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoList extends StatefulWidget {
  @override
  State createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  final String textAppBarTitle = 'Todo list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(textAppBarTitle)),
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
                  child: Icon(
                    Icons.cancel,
                  )),
              key: Key(items[index]),
              child: ListTile(
                  title: Text(items[index]),
                  trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed: () {
                        setState(() {
                          items.removeAt(index);
                        });
                      })));
        });
  }

  final TextEditingController _textFieldController = TextEditingController();
  final String newActionText = 'Write new action todo';
  final String cancelText = 'Cancel';
  final String addText = 'Add';

  void _addNewItem(BuildContext context) {
    showDialog<AlertDialog>(
        context: context,
        builder: (context) {
          _textFieldController.text = '';
          return AlertDialog(
            title: Text(newActionText),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: 'Todo action'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(cancelText),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text(addText),
                onPressed: () {
                  setState(() {
                    if (_textFieldController.text.isNotEmpty) {
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
