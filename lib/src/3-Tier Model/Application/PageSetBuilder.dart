import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/AuthenticationPages.dart';

import '../Presentation/DailyLogPages.dart';
import '../Presentation/ProfilePages.dart';
import '../Presentation/TemplatePage.dart';
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
    List<String> setResponses = [];
    pages.forEach((page) {
      if (page is LogHandler) {
        (page as LogHandler).questions.forEach((question) {
          var displayResponse =
              "${question.referenceName}: ${question.responseValue} ${question.units}";
          question.units != null
              ? setResponses.add(displayResponse + question.units!)
              : setResponses.add(displayResponse);
        });
      }
    });
    return setResponses;
  }
}

class PageSetController {
  late PageSet authentication;
  late PageSet profiling;
  late PageSet home;
  PageSet createProfilingSet(NavigationController navigationController) {
    profiling = PageSet(navigationController);
    List<Page> pages = [];
    pages.add(PersonalInfoPage(navigationController));
    pages.add(TransitionPageFactory.createTransitionPage(
        "Let's get a better idea about your daily diet", navigationController));
    pages.add(ActivityPage(navigationController));
    pages.add(DietPage(navigationController));
    pages.add(MedicalPage(navigationController));
    pages.add(SleepPage(navigationController));
    pages.add(TransitionPageFactory.createTransitionPage(
        "Now you will select your typical pain area", navigationController));
    pages.add(MigraineSelectionPage(navigationController));
    pages.add(ConfirmationPage(navigationController));

    profiling.setPages(pages);
    return profiling;
  }

  // createDailySet(NavigationController navigationController) {
  //   Map<String, Widget> pageSet = {};
  //   DailyLogFactory dailyLogFactory = DailyLogFactory();
  //   List<DailyLogPage> pages =
  //       dailyLogFactory.createDailyLogPages(navigationController);
  //   int index = 1;
  //   for (var page in pages) {
  //     pageSet["Daily Log Page $index"] = page.getWidget();
  //     index++;
  //   }
  //   return pageSet;
  // }

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
    return home;
  }

  printUserLogs(PageSet pageSet) {
    pageSet.pages.forEach((page) {
      if (page is ActivityPage) {
        (page as LogHandler).questions.forEach((question) {
          print(
              "${question.referenceName}: ${question.responseValue} ${question.units}");
        });
      }
    });
  }
}
