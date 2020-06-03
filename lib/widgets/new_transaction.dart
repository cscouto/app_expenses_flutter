import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addNewTransaction(
      _titleController.text,
      double.parse(_amountController.text),
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.all(8),
            height: 50,
            child: TextField(
              style: TextStyle(fontSize: 16),
              //style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                //labelStyle: Theme.of(context).textTheme.bodyText1,
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              controller: _titleController,
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            //padding: EdgeInsets.all(8),
            height: 50,
            child: TextField(
              //style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                //labelStyle: Theme.of(context).textTheme.bodyText1,
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            height: 50,
            child: Row(
              children: <Widget>[
                Text(_selectedDate == null ? 'No date chosen.' : DateFormat.yMd().format(_selectedDate)),
                FlatButton(
                  onPressed: () => _presentDatePicker(),
                  child: Text('Choose Date'),
                )
              ],
            ),
          ),
          FlatButton(
            onPressed: _submitData,
            textColor: Colors.purple,
            child: Text('Add Transaction'),
          ),
        ],
      ),
    );
  }
}
