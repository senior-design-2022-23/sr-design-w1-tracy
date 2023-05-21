import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/Pages/AttackPages.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/Pages/AuthenticationPages.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/Pages/DailyLogFlow.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/Pages/HomePages.dart';

import '../Presentation/Pages/ProfilePages.dart';
import '../Presentation/Pages/TemplatePage.dart';
import 'NavigationService.dart';

class Page {
  late TemplatePage? template;

  @required
  Widget getRootWidget() {
    if (template != null) {
      return template!;
    }
    return ErrorWidget.withDetails(
      error: FlutterError("Template page uninitialized"),
    );
  }
}

class PageSet {
  NavigationController navigationController;
  List<Page> pages = [];
  PageSet(this.navigationController);
  void setPages(List<Page> pageSet) {
    pageSet.forEach((page) {
      pages.add(page);
    });
  }

  List<Widget> get widgets {
    return pages.map((page) => page.getRootWidget()).toList();
  }

  List<String> compileResponses() {
    List<String> filledResponses = [];
    pages.forEach((page) {
      if (page is LogHandler) {
        (page as LogHandler).questions.forEach((question) {
          filledResponses
              .add("${question.referenceName}: ${question.responseValue}");
        });
      }
    });
    return filledResponses;
  }

  void logResponses(String className) {
    pages.forEach((page) {
      if (page is LogHandler) {
        (page as LogHandler).storeUserInfo(className);
      }
    });
  }
}

class PageSetController {
  late PageSet authentication;
  late PageSet profiling;
  late PageSet home;
  late PageSet dailyLog;
  late PageSet attack;

  PageSet createProfilingSet(NavigationController navigationController) {
    profiling = PageSet(navigationController);
    List<Page> pages = [];
    pages.add(PersonalInfoPage(navigationController));
    pages.add(TransitionPageFactory.createTransitionPage(
        "Let's get a better idea about your daily diet", navigationController));
    pages.add(ActivityPage(navigationController));
    pages.add(DietPage(navigationController));
    pages.add(SecondDietPage(navigationController));
    pages.add(MedicationPage(navigationController));
    pages.add(SleepPage(navigationController));
    pages.add(TransitionPageFactory.createTransitionPage(
        "Now you will select your typical pain area", navigationController));
    pages.add(MigraineSelectionPage(navigationController));
    pages.add(ConfirmationPage(navigationController));
    pages.add(TransitionPageFactory.createTransitionPage(
        "Profile Setup Complete! \n\n Continue To Return Home",
        navigationController,
        continueLocation: navigationController.toHome));
    profiling.setPages(pages);
    return profiling;
  }

  createDailySet(NavigationController navigationController) {
    dailyLog = PageSet(navigationController);
    List<Page> pages = [];
    var factoryPages = DailyLogFactory(navigationController, {}).pages;
    for (var page in factoryPages) pages.add(page);
    pages.add(TransitionPageFactory.createTransitionPage(
        "Daily Log Complete! \n\n Continue to Return Home",
        navigationController,
        continueLocation: navigationController.toHome));
    dailyLog.setPages(pages);

    return dailyLog;
  }

  PageSet createAuthenticationSet(NavigationController navigationController) {
    authentication = PageSet(navigationController);
    List<Page> pages = [];
    pages.add(WelcomePage(navigationController));
    pages.add(SignInPage(navigationController));
    pages.add(SignUpPage(navigationController));
    authentication.setPages(pages);
    return authentication;
  }

  PageSet createHomeSet(NavigationController navigationController) {
    home = PageSet(navigationController);
    List<Page> pages = [];
    pages.add(HomePage(navigationController));
    pages.add(SettingsPage(navigationController));
    pages.add(Statistics(navigationController));
    home.setPages(pages);
    return home;
  }

  PageSet createAttackSet(NavigationController navigationController) {
    attack = PageSet(navigationController);
    List<Page> pages = [];
    pages.add(AttackQuestion(navigationController));
    pages.add(TransitionPageFactory.createTransitionPage(
        "Successfully Logged Migraine Attack! \n\n Continue to Log Details",
        navigationController,
        backLocation: navigationController.toHome));
    pages.add(MigrainePain(navigationController));
    pages.add(MigraineSymptoms(navigationController));
    pages.add(MigraineSelectionPage(navigationController));
    pages.add(TransitionPageFactory.createTransitionPage(
        "Successfully Logged Migraine Details! \n\n Continue to Return Home",
        navigationController,
        backLocation: navigationController.previousPage,
        continueLocation: navigationController.toHome));
    attack.setPages(pages);
    return home;
  }
}
