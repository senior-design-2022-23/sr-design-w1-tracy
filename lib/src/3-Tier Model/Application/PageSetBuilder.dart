import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/DailyLogPage.dart';

import '../Presentation/ProfilePages.dart';
import '../Presentation/TemplatePage.dart';
import 'LogHandler.dart';

class PageSetBuilder {
  static final pageSet = <String, Widget>{};

  static Map<String, Widget> profilingPages() {
    PersonalInfoPage personalInfo = PersonalInfoPage();
    pageSet["Personal Information"] = personalInfo.getWidget();
    // pageSet["Personal Information"].
    // pageSet["Alcohol"] =
    //     TemplatePage(body: body, title: "Alcohol", buttons: buttons);
    // pageSet["Activity"] =
    //     TemplatePage(body: body, title: "Activity", buttons: buttons);
    // pageSet["Daily Log"] =
    //     TemplatePage(body: body, title: "Daily Log", buttons: buttons);
    // pageSet["Diet"] = TemplatePage(body: body, title: "Diet", buttons: buttons);
    // pageSet["Medical"] =
    //     TemplatePage(body: body, title: "Medical", buttons: buttons);
    // pageSet["Migraine Attack"] =
    //     TemplatePage(body: body, title: "Migraine Attack", buttons: buttons);
    // pageSet["Personal Information"] = TemplatePage(
    //     body: body, title: "Personal Information", buttons: buttons);
    // pageSet["Sleep"] =
    //     TemplatePage(body: body, title: "Sleep", buttons: buttons);
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

  // statisticsPages() {}
  // authenticationPages() {}

  homePages() {}
}
