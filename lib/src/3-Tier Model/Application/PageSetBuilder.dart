import 'package:flutter/material.dart';

import '../Presentation/ProfilePages.dart';
import '../Presentation/TemplatePage.dart';
import 'NavigationService.dart';

class PageSetBuilder {
  static final pageSet = <String, Widget>{};

  static Map<String, Widget> profilingPages(
      NavigationController navigationController) {
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

  // dailyFormPages() {}
  // statisticsPages() {}
  // authenticationPages() {}

  homePages() {}
}
