import 'package:flutter/material.dart';

class NavigationService extends StatefulWidget {
  final Widget initialPage;

  const NavigationService(this.initialPage);

  @override
  _NavigationServiceState createState() => _NavigationServiceState();
}

class _NavigationServiceState extends State<NavigationService> {
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
  }

  Widget get currentPage => _currentPage;

  void navigateToPage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.initialPage,
    );
  }
}
