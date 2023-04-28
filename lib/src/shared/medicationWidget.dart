import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MedicationSearchWidget extends StatefulWidget {
  const MedicationSearchWidget({super.key});

  @override
  _MedicationSearchWidgetState createState() => _MedicationSearchWidgetState();
}

class _MedicationSearchWidgetState extends State<MedicationSearchWidget> {
  String _searchText = '';
  final List<String> _selectedItems = [];

  // Define a function to update the search text and suggestions
  void _updateSearchText(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

  // Define a function to handle selecting a suggestion
  void _onSuggestionSelected(String suggestion) {
    setState(() {
      if (_selectedItems.contains(suggestion)) {
        _selectedItems.remove(suggestion);
      } else {
        _selectedItems.add(suggestion);
      }
      _searchText = '';
    });
  }

  // Read medication names from an Excel file
  List<String> _getMedications() {
    final file = File('rx.xlsx');
    final bytes = file.readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables['Sheet1'];

    if (sheet == null) {
      return [];
    }

    final medications = <String>[];
    for (var row in sheet.rows) {
      final displayNameValue = row[0]?.value;
      final displayNameSynonymValue = row[1]?.value;
      if (displayNameValue != null) {
        medications.add(displayNameValue.toString());
      }
      if (displayNameSynonymValue != null) {
        medications.add(displayNameSynonymValue.toString());
      }
    }
    return medications;
  }

  @override
  Widget build(BuildContext context) {
    // Get the list of medications from the Excel file
    List<String> medications = _getMedications();

    // Filter the medications based on the search text
    List<String> suggestions = medications
        .where((medication) =>
            medication.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Column(
      children: [
        TextField(
          onChanged: _updateSearchText,
          decoration: const InputDecoration(
            labelText: 'Search Medications',
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField(
          value: null,
          items: suggestions
              .map((suggestion) => DropdownMenuItem(
                    value: suggestion,
                    child: Text(suggestion),
                  ))
              .toList(),
          onChanged: (value) => _onSuggestionSelected(value!),
          decoration: const InputDecoration(
            labelText: 'Medications',
          ),
          isDense: true,
          isExpanded: true,
          selectedItemBuilder: (BuildContext context) {
            return _selectedItems.map<Widget>((String item) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(item),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
