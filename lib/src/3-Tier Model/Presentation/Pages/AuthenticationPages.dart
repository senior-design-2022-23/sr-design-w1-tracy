import 'package:flutter/material.dart' hide Page;
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';

import '../../Application/NavigationService.dart';
import '../../Application/PageSetBuilder.dart';
import '../Widgets/BodyWidgets.dart';
import 'TemplatePage.dart';

String? validateEmail(String input, String field) {
  if (input.isEmpty || input.trim() == "")
    return "Required Field: Enter $field";
  if (!input.contains("@") && !input.contains(".")) {
    return "Please enter valid $field";
  }
  return null;
}

String? validateText(String input, String field) {
  if (input.isEmpty || input.trim() == "") {
    return "Required Field: Enter $field";
  }

  if (input.allMatches(".*\\d.*").isNotEmpty) {
    return "Please Enter Text Only";
  }
  return null;
}

class WelcomePage extends Page {
  List<BodyWidget> bodyWidgets = [];
  WelcomePage(NavigationController controller) {
    Widget subheaderText = WidgetConstructor.createText("Please Sign In Below",
        align: TextAlign.center, fontWeight: FontWeight.bold);
    Widget imageWidget =
        WidgetConstructor.createImage("assets/images/logo.png");
    Widget signInButton =
        WidgetConstructor.createButton(controller.toSignIn, text: "Sign In");
    Widget signUpButton =
        WidgetConstructor.createButton(controller.toSignUp, text: "Sign Up");

    Map<Widget?, double> spacingConfig = {subheaderText: 60, imageWidget: 60};
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList);
    template =
        TemplatePage(body: finalBody, buttons: [signInButton, signUpButton]);
  }
}

class SignInPage extends Page {
  List<BodyWidget> bodyWidgets = [];
  Future<dynamic Function()> canContinue(
      String username, String password, NavigationController controller) async {
    return () async {
      final parseUser;
      if (bodyWidgets
          .every((bodyWidget) => bodyWidget.validateInput() == null)) {
        parseUser = await ParseServer.getUser(username, password);
        if (parseUser != null) {
          return controller.toProfling();
        }
      }
      return () {};
    };
  }

  SignInPage(NavigationController controller) {
    Widget emailText = WidgetConstructor.createText("Email Address");
    BodyWidget emailField =
        WidgetConstructor.createQuestion("", inputValidator: (input) {
      return validateEmail(input, "Email");
    });
    Widget passwordText = WidgetConstructor.createText("Password");
    BodyWidget passwordFields = WidgetConstructor.createQuestion("");
    Widget continueButton = WidgetConstructor.createButton(
      () async {
        final canContinueFn = await canContinue(
          emailField.input, // Replace with actual username value
          passwordFields.input, // Replace with actual password value
          controller,
        );
        return canContinueFn();
      },
      text: "Continue",
    );
    Widget googleButton =
        WidgetConstructor.createButton(() {}, text: "Sign In with Google");

    bodyWidgets = [emailField, passwordFields];
    Map<Widget?, double> spacingConfig = {
      emailText: 30,
      emailField: 0,
      passwordText: 20,
      passwordFields: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.toWelcome, title: "Sign In");
    template =
        TemplatePage(body: finalBody, buttons: [continueButton, googleButton]);
  }
}

class SignUpPage extends Page {
  List<BodyWidget> bodyWidgets = [];
  Future<dynamic Function()> canContinue(String email, String password,
      String name, NavigationController controller) async {
    return () async {
      final parseUser;
      if (bodyWidgets
          .every((bodyWidget) => bodyWidget.validateInput() == null)) {
        parseUser = await ParseServer.createUser(email, password);
        if (parseUser != null) {
          return controller.toHome;
        }
      }
      return () {};
    };
  }

  SignUpPage(NavigationController controller) {
    Widget nameText = WidgetConstructor.createText("Name");
    BodyWidget nameFields = WidgetConstructor.createDoubleQuestion(
        "First Name", "Second Name", firstValidator: (input) {
      return validateText(input, "First Name");
    }, secondValidator: (input) {
      return validateText(input, "Second Name");
    });
    Widget emailText = WidgetConstructor.createText("Email");
    BodyWidget emailField =
        WidgetConstructor.createQuestion("", inputValidator: (input) {
      return validateEmail(input, "Email");
    });
    Widget passwordText = WidgetConstructor.createText("Password");
    BodyWidget passwordField =
        WidgetConstructor.createQuestion("", inputValidator: (input) {
      return input.length < 6 ? "Password must be at least 7 characters" : null;
    });
    Widget confirmText = WidgetConstructor.createText("Confirm Password");
    BodyWidget confirmField = WidgetConstructor.createQuestion("",
        inputValidator: (input) =>
            input != passwordField.input ? "Passwords must match" : null);

    Widget continueButton = WidgetConstructor.createButton(
      () async {
        final canContinueFn = await canContinue(
          emailField.input, // Replace with actual username value
          passwordField.input, // Replace with actual password value
          nameFields.input,
          controller,
        );
        return canContinueFn();
      },
      text: "Continue",
    );
    Widget returningButton = WidgetConstructor.createButton(controller.toSignIn,
        text: "Returning User");

    bodyWidgets = [nameFields, emailField, passwordField, confirmField];

    Map<Widget?, double> spacingConfig = {
      nameText: 30,
      nameFields: 0,
      emailText: 20,
      emailField: 0,
      passwordText: 20,
      passwordField: 0,
      confirmText: 20,
      confirmField: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.toWelcome, title: "Sign Up");
    template = TemplatePage(
        body: finalBody, buttons: [continueButton, returningButton]);
  }
}
