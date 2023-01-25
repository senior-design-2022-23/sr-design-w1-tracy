import 'package:flutter/material.dart';

class PersonalInformationPage extends StatefulWidget {
  final String name;
  final String? restorationId;
  PersonalInformationPage({required this.name, this.restorationId});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage>
    with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? sexOption = "N/A";
    // Top Level Container
    return Container(
      // Background Gradient Decoration
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromARGB(255, 124, 154, 88),
            Color.fromARGB(255, 141, 184, 86),
            Color.fromARGB(255, 101, 120, 78),
            Color.fromARGB(255, 109, 144, 67)
          ])),

      // Structural Container for Widgets
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.only(top: 100, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Back Arrow Button
              Transform.translate(
                offset: const Offset(-20, 0),
                child: IconButton(
                  color: const Color.fromARGB(255, 101, 101, 101),
                  icon: const Icon(Icons.arrow_back_ios),
                  tooltip: 'Back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                "Hi ${widget.name}, let's setup your profile!",
                style: TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 255, 255, 255)),
              ),
              Transform.translate(
                  offset: const Offset(0, 40),
                  child: Text(
                    "Height",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  )),
              // Container for same line Text Field
              Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Row(children: <Widget>[
                    Flexible(
                      flex: 0,
                      // First Name Form Field
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          constraints: BoxConstraints(maxWidth: 150),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          labelText: 'ft',
                        ),
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      flex: 10,
                      // Last Name Form Field
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          labelText: 'in',
                        ),
                      ),
                    ),
                    const Spacer(),
                  ])),
              Transform.translate(
                  offset: const Offset(0, 20),
                  child: Text(
                    "Weight",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  )),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  constraints: BoxConstraints(maxWidth: 150),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  labelText: 'lbs',
                ),
              ),
              Transform.translate(
                  offset: const Offset(0, 20),
                  child: Text(
                    "Sex",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  )),
              Transform.translate(
                  offset: const Offset(0, 20),
                  child: Row(
                    children: [
                      Flexible(
                          child: ListTile(
                              textColor: Colors.white,
                              trailing: const Text('Male'),
                              leading: Radio<String>(
                                  value: "Male",
                                  groupValue: sexOption,
                                  onChanged: (String? value) {
                                    setState(() {
                                      sexOption = value!;
                                    });
                                  }))),
                      Flexible(
                          child: ListTile(
                              textColor: Colors.white,
                              trailing: const Text('Female'),
                              leading: Radio<String>(
                                  value: "Female",
                                  groupValue: sexOption,
                                  onChanged: (String? value) {
                                    setState(() {
                                      sexOption = value;
                                    });
                                  }))),
                      Flexible(
                          child: ListTile(
                              textColor: Colors.white,
                              trailing: const Text('Prefer Not to Specify'),
                              leading: Radio<String>(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    return Colors.white;
                                  }),
                                  value: "N/A",
                                  groupValue: sexOption,
                                  onChanged: (String? value) {
                                    setState(() {
                                      sexOption = value!;
                                    });
                                  }))),
                    ],
                  )),
              Transform.translate(
                  offset: const Offset(0, 20),
                  child: Text(
                    "Date of Birth",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  )),
              Transform.translate(
                  offset: const Offset(0, 40),
                  child: ElevatedButton(
                    onPressed: () => _restorableDatePickerRouteFuture.present(),
                    style: TextButton.styleFrom(
                        minimumSize: const Size(330, 70),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255)),
                    child: const Text(
                      'Open Date Picker',
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                          width: 1, color: Color.fromARGB(255, 255, 255, 255)),
                      minimumSize: const Size(330, 70),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
