import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:migraine_aid/src/features/profiling/presentation/activitypage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/alcoholpage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/dietpage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/medicalpage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/personalinfopage.dart';
import 'package:migraine_aid/src/features/profiling/presentation/sleeppage.dart';
import 'package:migraine_aid/src/shared/continueButton.dart';
import 'package:migraine_aid/src/shared/toggleButton.dart';

void main() {
  group('PersonalInformationPage', () {
    final personalInfoPage = PersonalInformationPage(name: 'John Doe');

    testWidgets('Renders correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(home: personalInfoPage));
      expect(find.byType(PersonalInformationPage), findsOneWidget);
      expect(
          find.text('Hi John Doe, let\'s setup your profile!'), findsOneWidget);
      expect(find.text('Height'), findsOneWidget);
      expect(find.text('Weight'), findsOneWidget);
      expect(find.text('Sex'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
    });

    testWidgets('Back button unresponsive', (tester) async {
      await tester.pumpWidget(MaterialApp(home: personalInfoPage));
      expect(find.byType(PersonalInformationPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pump();

      // Popping navigation with one page should'nt mutate stack
      expect(find.byType(PersonalInformationPage), findsOneWidget);
    });

    testWidgets('Selecting a date updates the state', (tester) async {
      await tester.pumpWidget(MaterialApp(home: personalInfoPage));
      expect(find.text('Selected: 25/7/2021'), findsNothing);

      await tester.tap(find.text('Select Date'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Selected: 25/7/2021'), findsOneWidget);
    });
  });

  group('SleepPage', () {
    testWidgets('should display correct widgets', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SleepPage()));

      expect(find.text('About how many hours a night do you generally sleep?'),
          findsOneWidget);
      expect(find.text('Is your sleep pattern regular'), findsOneWidget);
      expect(find.byTooltip('-1'), findsOneWidget);
      expect(find.byTooltip('+1'), findsOneWidget);
      expect(find.byType(ToggleButton), findsOneWidget);
    });

    testWidgets('should update sleep hours when +/- buttons are pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SleepPage()));

      expect(find.text('0'), findsOneWidget);

      for (int i = 0; i < 4; i++) {
        await tester.tap(find.byTooltip('+1'));
        await tester.pump();
      }

      expect(find.text('0'), findsNothing);
      expect(find.text('4'), findsOneWidget);

      await tester.tap(find.byTooltip('-1'));
      await tester.pump();

      expect(find.text('4'), findsNothing);
      expect(find.text('3'), findsOneWidget);
    });
  });

  testWidgets('should\'nt decrement sleep hours when under 3 hours',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SleepPage()));
    expect(find.text('0'), findsOneWidget);
    for (int i = 0; i < 4; i++) {
      await tester.tap(find.byTooltip('-1'));
      await tester.pump();
      expect(find.text('$i'), findsOneWidget);
      await tester.tap(find.byTooltip('+1'));
      await tester.pump();
      expect(find.text('${i + 1}'), findsOneWidget);
    }
  });

  testWidgets('should\'nt increment sleep hours when over 16 hours',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SleepPage()));
    expect(find.text('0'), findsOneWidget);
    for (int i = 0; i < 16; i++) {
      await tester.tap(find.byTooltip('+1'));
      await tester.pump();
    }
    expect(find.text('16'), findsOneWidget);
    await tester.tap(find.byTooltip('+1'));
    await tester.pump();
    expect(find.text('17'), findsNothing);
    expect(find.text('16'), findsOneWidget);
  });

  group('AlcoholPage widget', () {
    testWidgets('should display correct widgets', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AlcoholPage()));
      expect(find.text('How often do you drink alcohol every week?'),
          findsOneWidget);
      expect(
          find.text(
              'On average, how much alcohol do you consume when you drink?'),
          findsOneWidget);
      expect(find.byType(DropdownButton<String>), findsNWidgets(2));
    });

    testWidgets('dropdown buttons should display correct values',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AlcoholPage()));

      final dropdownButtons = find.byType(DropdownButton<String>);

      // check first dropdown button
      await tester.tap(dropdownButtons.at(0), warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.text('None (0x)'), findsWidgets);
      expect(find.text('Little or Rarely (1-2x)'), findsWidgets);
      expect(find.text('Often (3-4x)'), findsWidgets);
      expect(find.text('Frequently (5-6x)'), findsWidgets);
      expect(find.text('Everyday (>=7x)'), findsWidgets);

      // check second dropdown button
      await tester.tap(dropdownButtons.at(1), warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.text('1-2'), findsWidgets);
      expect(find.text('3-4'), findsWidgets);
      expect(find.text('5-6'), findsWidgets);
      expect(find.text('7-9'), findsWidgets);
      expect(find.text('10+'), findsWidgets);
    });

    // testWidgets('AlcoholPage stores data on continue button tap',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(home: AlcoholPage()));

    //   final dropdownButtons = find.byType(DropdownButton<String>);

    //   // select values for dropdown buttons
    //   await tester.tap(dropdownButtons.at(0));
    //   await tester.tap(find.text('Often (3-4x)').last);
    //   await tester.pumpAndSettle();
    //   await tester.tap(dropdownButtons.at(1));
    //   await tester.tap(find.text('7-9').last);
    //   await tester.pumpAndSettle();

    //   // tap continue button
    //   await tester.tap(find.byType(ContinueButton));
    //   await tester.pumpAndSettle();

    //   // check that data was stored
    //   // note: replace storeAlcohol() function with a mock function that returns true or false as needed
    //   expect(await storeAlcohol('Often (3-4x)', '7-9'), true);
    // });
  });

  group('ActivityPage widget', () {
    testWidgets('should display correct widgets', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ActivityPage()));
      expect(find.text('How often do you exercise?'), findsOneWidget);
      expect(
          find.text(
              'Approximately how many bottles of water do you drink a day?'),
          findsOneWidget);
      expect(find.byType(DropdownButton<String>), findsNWidgets(2));
    });

    testWidgets('dropdown buttons should display correct values',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ActivityPage()));

      final dropdownButtons = find.byType(DropdownButton<String>);

      final gymOptionButtons = find.byType(DropdownButton<String>).at(1);
      final waterOptionButtons = find.byType(DropdownButton<String>).at(1);

      // check first dropdown button
      await tester.tap(gymOptionButtons, warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.text('None (0x)'), findsWidgets);
      expect(find.text('Little or Rarely (1-2x)'), findsWidgets);
      expect(find.text('Often (3-4x)'), findsWidgets);
      expect(find.text('Frequently (5-6x)'), findsWidgets);
      expect(find.text('Everyday (>=7x)'), findsWidgets);

      // check second dropdown button
      await tester.tap(waterOptionButtons, warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.text('Unsure'), findsWidgets);
      expect(find.text('1-2 bottles'), findsWidgets);
      expect(find.text('3-4 bottles'), findsWidgets);
      expect(find.text('5-6 bottles'), findsWidgets);
      expect(find.text('7-8 bottles'), findsWidgets);
      expect(find.text('9-10 bottles'), findsWidgets);
      expect(find.text('10+ bottles'), findsWidgets);
    });
  });

  group('DietPage widget', () {
    testWidgets('should display correct widgets', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: DietPage()));
      expect(
          find.text(
              'Do you have any of the following dietary preferences and/or restrictions?'),
          findsOneWidget);
    });
  });

  group('MedicalPage widget', () {
    testWidgets('should display correct widgets', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MedicalPageIntro()));
      expect(find.text('Tell us a bit about your Medical History'),
          findsOneWidget);
    });
  });
}
