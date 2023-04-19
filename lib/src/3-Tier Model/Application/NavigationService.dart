import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/PageSetBuilder.dart';

class NavigationService extends StatefulWidget {
  final Widget initialPage;
  const NavigationService(this.initialPage);

  @override
  _NavigationServiceState createState() => _NavigationServiceState();
}

class _NavigationServiceState extends State<NavigationService> {
  late Widget _currentPage;
  late List<Widget> _currentPageSet;
  int _currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
  }

  Widget get currentPage => _currentPage;

  void pressContinue() {
    setState(() {
      _currentPage = _currentPageSet[_currentPageIndex++];
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageSetBuilder.profilingPages()['Personal Information']!;
  }
}
