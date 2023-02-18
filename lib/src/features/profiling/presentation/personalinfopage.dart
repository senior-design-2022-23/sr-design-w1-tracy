import 'package:flutter/material.dart';
import 'package:migraine_aid/src/features/profiling/presentation/sleeppage.dart';

import '../../../shared/continueButton.dart';
import '../../../shared/userFunctions.dart';

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
  String? sexOption = "N/A";
  final List<bool> _selectedSex = <bool>[true, false, false];
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
            body: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 30),
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
                        style: const TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Height",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      // Container for same line Text Field
                      Row(children: <Widget>[
                        Flexible(
                          flex: 0,
                          // First Name Form Field
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text(
                                "ft",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white70),
                              ),
                              border: UnderlineInputBorder(),
                              constraints: BoxConstraints(maxWidth: 150),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Flexible(
                          flex: 10,
                          // Last Name Form Field
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text(
                                "in",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white70),
                              ),
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ]),
                      const SizedBox(height: 20),
                      const Text(
                        "Weight",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            constraints: BoxConstraints(maxWidth: 150),
                            label: Text(
                              "lbs",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            )),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Sex",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      const SizedBox(height: 5),
                      ToggleButtons(
                        direction: Axis.horizontal,
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0; i < _selectedSex.length; i++) {
                              _selectedSex[i] = i == index;
                            }
                            sexOption = ['N/A', 'Male', 'Female'][index];
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3)),
                        selectedBorderColor: Colors.white,
                        selectedColor: Colors.black,
                        fillColor: Colors.white,
                        color: Colors.white,
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 110.0,
                        ),
                        isSelected: _selectedSex,
                        children: const <Widget>[
                          Text(
                            'Prefer Not to\n Specify',
                            textAlign: TextAlign.center,
                          ),
                          Text('Male'),
                          Text('Female')
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Date of Birth",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () =>
                            _restorableDatePickerRouteFuture.present(),
                        style: TextButton.styleFrom(
                            minimumSize: const Size(330, 70),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255)),
                        child: const Text(
                          'Open Date Picker',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ContinueButton(callback: () async {
                        //TODO: update this when part 2 is ready
                        goToPage(context, const SleepPage());
                      }),
                    ],
                  ),
                ),
              ),
            )));
  }
}
