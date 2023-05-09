import 'package:flutter/material.dart';

import '../Application/NavigationService.dart';
import 'BodyWidgets.dart';
import 'TemplatePage.dart';

class WelcomePage {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  WelcomePage(NavigationController controller) {
    Widget subheaderText =
        WidgetConstructor.createText("To begin tracking migraines login below");

    Widget imageWidget =
        WidgetConstructor.createImage("assets/images/logo.png");
    Widget signInButton =
        WidgetConstructor.createButton(controller.toSignIn, text: "Sign In");
    Widget signUpButton =
        WidgetConstructor.createButton(controller.toSignUp, text: "Sign Up");

    Map<Widget?, double> spacingConfig = {subheaderText: 30, imageWidget: 50};
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody =
        WidgetConstructor.addUXWrap(spacedList, title: "Welcome!");
    template = TemplatePage(
        body: finalBody, title: "Na", buttons: [signInButton, signUpButton]);
  }

  TemplatePage getWidget() {
    return template;
  }
}

class SignInPage {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  SignInPage(NavigationController controller) {
    Widget usernameText = WidgetConstructor.createText("Username");
    BodyWidget usernameField =
        WidgetConstructor.createQuestion(" ", "username");
    Widget passwordText = WidgetConstructor.createText("Password");
    BodyWidget passwordFields =
        WidgetConstructor.createQuestion(" ", "password");

    Widget continueButton =
        WidgetConstructor.createButton(controller.toProfling, text: "Continue");
    Widget googleButton =
        WidgetConstructor.createButton(() {}, text: "Sign In with Google");

    bodyWidgets = [usernameField, passwordFields];
    Map<Widget?, double> spacingConfig = {
      usernameText: 30,
      usernameField: 0,
      passwordText: 20,
      passwordFields: 0,
    };
    List<Widget> spacedList = WidgetConstructor.addSpacing(spacingConfig);
    Widget finalBody = WidgetConstructor.addUXWrap(spacedList,
        backLogic: controller.previousPage, title: "Sign In");
    template = TemplatePage(
        body: finalBody, title: "Na", buttons: [continueButton, googleButton]);
  }

  TemplatePage getWidget() {
    return template;
  }
}

class SignUpPage {
  late TemplatePage template;
  List<BodyWidget> bodyWidgets = [];
  SignUpPage(NavigationController controller) {
    Widget nameText = WidgetConstructor.createText("Name");
    BodyWidget nameFields = WidgetConstructor.createDoubleQuestion(
        "First Name", "Second Name", "name");
    Widget emailText = WidgetConstructor.createText("Email");
    BodyWidget emailField = WidgetConstructor.createQuestion(" ", "email");
    Widget passwordText = WidgetConstructor.createText("Password");
    BodyWidget passwordField =
        WidgetConstructor.createQuestion(" ", "password");
    Widget confirmText = WidgetConstructor.createText("Confirm Password");
    BodyWidget confirmField = WidgetConstructor.createQuestion(" ", "password");

    Widget continueButton = WidgetConstructor.createText("Continue");
    Widget returningButton = WidgetConstructor.createText("Returning User");

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
        backLogic: controller.previousPage, title: "Sign Up");
    template = TemplatePage(
        body: finalBody,
        title: "Na",
        buttons: [continueButton, returningButton]);
  }

  TemplatePage getWidget() {
    return template;
  }
}
