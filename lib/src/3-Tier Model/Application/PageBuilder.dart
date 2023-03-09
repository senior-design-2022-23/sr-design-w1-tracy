import '../Presentation/TemplatePage.dart';

class PageBuilder {
  final pageSet = <String, TemplatePage>{};

  Map<String, TemplatePage> profilingPages() {
    pageSet["Alcohol"] =
        TemplatePage(body: body, title: "Alcohol", buttons: buttons);
    pageSet["Activity"] =
        TemplatePage(body: body, title: "Activity", buttons: buttons);
    pageSet["Daily Log"] =
        TemplatePage(body: body, title: "Daily Log", buttons: buttons);
    pageSet["Diet"] = TemplatePage(body: body, title: "Diet", buttons: buttons);
    pageSet["Medical"] =
        TemplatePage(body: body, title: "Medical", buttons: buttons);
    pageSet["Migraine Attack"] =
        TemplatePage(body: body, title: "Migraine Attack", buttons: buttons);
    pageSet["Personal Information"] = TemplatePage(
        body: body, title: "Personal Information", buttons: buttons);
    pageSet["Sleep"] =
        TemplatePage(body: body, title: "Sleep", buttons: buttons);
    return pageSet;
  }

  dailyFormPages() {}
  statisticsPages() {}
  authenticationPages() {}

  homePages() {}
}
