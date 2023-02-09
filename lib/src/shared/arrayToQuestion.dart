import 'package:flutter/material.dart';
import 'package:migraine_aid/src/shared/staticTextWidget.dart';

class ArrayToCheckboxList extends StatefulWidget {
  final List<String> items;
  final ValueChanged<List<bool>> callback;
  const ArrayToCheckboxList({super.key, required this.items, required this.callback});

  @override
  ArrayToCheckboxListState createState() => ArrayToCheckboxListState();
}

class ArrayToCheckboxListState extends State<ArrayToCheckboxList> {
  List<bool> checkboxValues = [];

  @override
  void initState() {
    super.initState();
    checkboxValues = List.filled(widget.items.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(widget.items[index]),
            trailing: Checkbox(
              value: checkboxValues[index],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues[index] = value!;
                  widget.callback(checkboxValues);
                });
              },
            ),

          );
        });
  }
}
