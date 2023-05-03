import 'package:flutter/material.dart';

import '../Presentation/EmptyStatisticsPage.dart';
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

  dailyLogPages(NavigationController navigationController) {
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
  
  static statisticsPage(NavigationController navigationController) {
    EmptyStatisticsPage statsPage = EmptyStatisticsPage(navigationController);
    pageSet["Empty Statistics Page"] = statsPage.getWidget();
    return pageSet;
  }
  // authenticationPages() {}

  homePages() {}
}
