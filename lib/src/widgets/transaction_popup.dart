import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_login/src/models/transactions.dart';
import 'package:provider_login/src/provider/user_provider.dart';

class TransactionPopUp extends StatefulWidget {
  const TransactionPopUp({super.key});

  @override
  State<TransactionPopUp> createState() => _TransactionPopUpState();
}

class _TransactionPopUpState extends State<TransactionPopUp> {
  String _type = 'income';
  String _category = '';
  String _description = '';
  DateTime? _selectedDate = DateTime.now();
  double _amount = 0.0;
  List<DateTime?> _dates = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('Add Transaction'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: _type,
              items: ['income', 'expense'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(child: Text(value), value: value);
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _type = newValue!;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) => _description = value,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) => _amount = double.parse(value),
              decoration: InputDecoration(
                hintText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) => _category = value,
              decoration: InputDecoration(
                hintText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Date'),
              onTap: () async {
                var results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(),
                  dialogSize: const Size(325, 400),
                  value: _dates,
                  borderRadius: BorderRadius.circular(15),
                );
                setState(() {
                  _selectedDate = results![0];
                  _dates = results;
                });
              },
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            TransactionData transaction = TransactionData(
              type: _type,
              category: _category,
              date: DateFormat('yyyy-MM-dd').format(_selectedDate!).toString(),
              amount: _amount.toString(),
              description: _description,
            );
            Provider.of<UserProvider>(context, listen: false).addTransaction(transaction);
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
