import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/AuthenticationPages.dart';

import '../Presentation/DailyLogPages.dart';
import '../Presentation/ProfilePages.dart';
import 'NavigationService.dart';

class PageSetBuilder {
  static Map<String, Widget> profilingPages(
      NavigationController navigationController) {
    Map<String, Widget> pageSet = {};
    PersonalInfoPage personalInfo = PersonalInfoPage(navigationController);
    pageSet["Personal Information"] = personalInfo.getWidget();
    pageSet["Activity Transition"] = TransitionPageFactory.createTransitionPage(
        "Let's get a better idea about your daily diet", navigationController);
    ActivityPage activity = ActivityPage(navigationController);
    pageSet["Activity"] = activity.getWidget();
    DietPage diet = DietPage(navigationController);
    pageSet["Diet"] = diet.getWidget();
    MedicalPage medical = MedicalPage(navigationController);
    pageSet["Medical"] = medical.getWidget();
    SleepPage sleep = SleepPage(navigationController);
    pageSet["Sleep"] = sleep.getWidget();
    MigraineLocationPage location = MigraineLocationPage(navigationController);
    pageSet["Migraine Attack"] = location;
    return pageSet;
  }

  dailyLogPages(NavigationController navigationController) {
    Map<String, Widget> pageSet = {};
    DailyLogFactory dailyLogFactory = DailyLogFactory();
    List<DailyLogPage> pages =
        dailyLogFactory.createDailyLogPages(navigationController);
    int index = 1;
    for (var page in pages) {
      pageSet["Daily Log Page $index"] = page.getWidget();
      index++;
    }
    return pageSet;
  }

  static Map<String, Widget> authenticationPages(
      NavigationController navigationController) {
    Map<String, Widget> pageSet = {};
    WelcomePage welcome = WelcomePage(navigationController);
    pageSet["Welcome"] = welcome.getWidget();
    SignInPage signIn = SignInPage(navigationController);
    pageSet["Sign In"] = signIn.getWidget();
    SignUpPage signUp = SignUpPage(navigationController);
    pageSet["Sign Up"] = signUp.getWidget();
    return pageSet;
  }

  static Map<String, Widget> homePages(
      NavigationController navigationController) {
    Map<String, Widget> pageSet = {};
    return pageSet;
  }
}
