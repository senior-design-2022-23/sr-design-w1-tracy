import 'dart:math';

import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/PageSetBuilder.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Data/ParseServerProxy.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/Pages/ProfilePages.dart';

class NavigationService extends StatefulWidget {
  const NavigationService({super.key});

  @override
  _NavigationServiceState createState() => _NavigationServiceState();
}

class NavigationController {
  Function() nextPage;
  Function() previousPage;
  Function() toProfling;
  Function() toWelcome;
  Function() toSignUp;
  Function() toSignIn;
  Function() toHome;
  Function() toDailyLog;
  Function() toAttack;
  Function() toStatistics;
  Function() refresh;
  NavigationController({
    required this.nextPage,
    required this.previousPage,
    required this.toProfling,
    required this.toWelcome,
    required this.toSignUp,
    required this.toSignIn,
    required this.toHome,
    required this.toDailyLog,
    required this.toAttack,
    required this.toStatistics,
    required this.refresh,
  });
}

class CustomLinearProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double whiteBarPosition;

  CustomLinearProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    required this.whiteBarPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintBackground = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final paintProgress = Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill;

    final paintWhiteBar = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final progressRect = Rect.fromLTWH(
      0.0,
      0.0,
      size.width * progress,
      size.height,
    );
    final whiteBarRect = Rect.fromLTWH(
      size.width * whiteBarPosition,
      0.0,
      6.0 + size.width * (progress - whiteBarPosition),
      size.height,
    );

    canvas.drawRect(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height), paintBackground);
    canvas.drawRect(progressRect, paintProgress);
    canvas.drawRect(whiteBarRect, paintWhiteBar);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ProgressBar extends StatelessWidget {
  final AnimationController progressController;
  final Animation<double> whiteBarAnimation;

  const ProgressBar({
    required this.progressController,
    required this.whiteBarAnimation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([progressController, whiteBarAnimation]),
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          size: const Size(double.infinity, 5.0),
          painter: CustomLinearProgressPainter(
            progress: progressController.value,
            backgroundColor: Colors.black,
            progressColor: Colors.blue,
            whiteBarPosition: whiteBarAnimation.value,
          ),
        );
      },
    );
  }
}

class _NavigationServiceState extends State<NavigationService>
    with TickerProviderStateMixin {
  late final AnimationController _progressController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final AnimationController _whiteBarController = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );
  late final Animation<double> _whiteBarAnimation;
  late NavigationController controller;
  late PageSet _currentPageSet; // Current page specificed by nav controller
  PageSetController pageSetController = PageSetController();
  bool showProgressBar = false; // Progress switch controlled by page sets
  double maxProgress = 0; // Furthest progress reached by user
  int _currentPageIndex = 0; // Index controlled by nav contoller

  void initPageSets() {
    pageSetController.createAuthenticationSet(controller);
    pageSetController.createHomeSet(controller);
    pageSetController.createProfilingSet(controller);
    pageSetController.createDailySet(controller);
    pageSetController.createAttackSet(controller);
  }

  @override
  void initState() {
    super.initState();
    _whiteBarAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_whiteBarController);
    controller = NavigationController(
        nextPage: _nextPage,
        previousPage: _previousPage,
        toWelcome: _toWelcome,
        toHome: _toHome,
        toProfling: _toProfiling,
        toSignUp: _toSignUp,
        toSignIn: _toSignIn,
        toDailyLog: _toDailyLog,
        toAttack: _toAttack,
        toStatistics: _toStatistics,
        refresh: () {
          setState(() {});
        });
    initPageSets();
    _currentPageSet = pageSetController.authentication;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Navigator(
        pages: [
          MaterialPage(
            child: _currentPageSet.widgets[_currentPageIndex],
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
      ),
      if (showProgressBar)
        Align(
          alignment: const Alignment(0, 1),
          child: ProgressBar(
            progressController: _progressController,
            whiteBarAnimation: _whiteBarAnimation,
          ),
        ),
    ]);
  }

  double _progressValue() {
    double current = _currentPageIndex / (_currentPageSet.widgets.length - 1);
    maxProgress = max(maxProgress, current);
    return maxProgress;
  }

  void _toProfiling() {
    ParseServer.createIfNotExists("ProfilingInformation");
    setState(() {
      showProgressBar = true;
      _currentPageIndex = 0;
      _currentPageSet = pageSetController.profiling;
      updatePage();
    });
  }

  void _toWelcome() {
    setState(() {
      showProgressBar = false;
      _currentPageIndex = 0;
      _currentPageSet = pageSetController.authentication;
      updatePage();
    });
  }

  void _toHome() {
    setState(() {
      showProgressBar = false;
      _currentPageIndex = 0;
      _currentPageSet = pageSetController.home;
      updatePage();
    });
  }

  void _toSignUp() {
    setState(() {
      showProgressBar = false;
      _currentPageIndex = 2;
      _currentPageSet = pageSetController.authentication;
      updatePage();
    });
  }

  void _toSignIn() {
    setState(() {
      showProgressBar = false;
      _currentPageIndex = 1;
      _currentPageSet = pageSetController.authentication;
      updatePage();
    });
  }

  void _toDailyLog() {
    setState(() {
      showProgressBar = true;
      _currentPageIndex = 0;
      _currentPageSet = pageSetController.dailyLog;
      updatePage();
      _progressController.reset();
      _whiteBarController.reset();
    });
  }

  void _toAttack() {
    setState(() {
      showProgressBar = true;
      _currentPageIndex = 0;
      _currentPageSet = pageSetController.attack;
      updatePage();
    });
  }

  void _toStatistics() {
    setState(() {
      showProgressBar = true;
      _currentPageIndex = 2;
      _currentPageSet = pageSetController.home;
      updatePage();
    });
  }

  void _nextPage() {
    if (_currentPageIndex < _currentPageSet.widgets.length - 1) {
      setState(() {
        _currentPageIndex++;
        updatePage();
      });
    }
    _progressController.animateTo(_progressValue(),
        duration: const Duration(milliseconds: 1000));
    _whiteBarController.animateTo(
        _currentPageIndex / (_currentPageSet.widgets.length - 1),
        duration: const Duration(milliseconds: 1000));
  }

  void _previousPage() {
    if (_currentPageIndex > 0) {
      setState(() {
        _currentPageIndex--;
        updatePage();
      });
    }
    _progressController.animateTo(_progressValue(),
        duration: const Duration(milliseconds: 1000));
    _whiteBarController.animateTo(
        _currentPageIndex / (_currentPageSet.widgets.length - 1),
        duration: const Duration(milliseconds: 1000));
  }

  // Controls individual page logic after any navigation call
  Future<void> updatePage() async {
    var currentPage = _currentPageSet.pages[_currentPageIndex];
    if (_currentPageIndex != 0) {
      var previousPage = _currentPageSet.pages[_currentPageIndex - 1];
      if (currentPage is MenstruationInformation) {
        var response = await ParseServer.request("ProfileInformation", "Sex");
        if (response != null) {
          if (response == "Female") print("object");
        }
      }
      if (currentPage is ConfirmationPage) {
        var map = pageSetController.profiling.compileResponses();
        _currentPageSet.pages[_currentPageIndex] =
            ConfirmationPage(controller, stats: map.toList());
        ParseServer.store("ProfilingInformation", "profilingComplete", true);
      }
      if (previousPage is ConfirmationPage) {
        pageSetController.profiling.logResponses("ProfilingInformation");
      }
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }
}
