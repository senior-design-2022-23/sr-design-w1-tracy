import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/PageSetBuilder.dart';

class NavigationService extends StatefulWidget {
  final Widget initialPage;
  const NavigationService(this.initialPage);

  @override
  _NavigationServiceState createState() => _NavigationServiceState();
}

class NavigationController {
  final Function() nextPage;
  final Function() previousPage;
  NavigationController(this.nextPage, this.previousPage);
}

class _NavigationServiceState extends State<NavigationService> {
  List<Widget> _pages = []; // Replace this with your list of pages
  int _currentPageIndex = 0;
  late NavigationController controller;
  @override
  void initState() {
    super.initState();
    controller = NavigationController(_nextPage, _previousPage);
    // TODO: Only create if hasn't been complete
    _pages = _sortProfilingPages();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          child: _pages[_currentPageIndex],
          key: ValueKey(_currentPageIndex),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        setState(() {
          _currentPageIndex--;
        });

        return true;
      },
    );
  }

  List<Widget> _sortProfilingPages() {
    return PageSetBuilder.profilingPages(controller).values.toList();
  }

  void _nextPage() {
    if (_currentPageIndex < _pages.length - 1) {
      setState(() {
        _currentPageIndex++;
      });
    }
  }

  void _previousPage() {
    if (_currentPageIndex > 0) {
      setState(() {
        _currentPageIndex--;
      });
    }
  }
}
