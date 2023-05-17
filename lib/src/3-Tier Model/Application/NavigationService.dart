import 'dart:math';

import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/LogHandler.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Application/PageSetBuilder.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/ProfilePages.dart';

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
  NavigationController({
    required this.nextPage,
    required this.previousPage,
    required this.toProfling,
    required this.toWelcome,
    required this.toSignUp,
    required this.toSignIn,
    required this.toHome,
    required this.toDailyLog,
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
    pageSetController.createDailyLogSet(controller);
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
    );
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
    setState(() {
      showProgressBar = true;
      _currentPageIndex = 0;
      _currentPageSet = pageSetController.profiling;
    });
  }

  void _toWelcome() {
    setState(() {
      showProgressBar = false;
      _currentPageIndex = 0;
      _currentPageSet = pageSetController.authentication;
    });
  }

  void _toHome() {
    setState(() {
      showProgressBar = false;
      _currentPageIndex = 0;
      _currentPageSet = pageSetController.authentication;
    });
  }

  void _toSignUp() {
    setState(() {
      showProgressBar = false;
      _currentPageIndex = 2;
      _currentPageSet = pageSetController.authentication;
    });
  }

  void _toSignIn() {
    setState(() {
      showProgressBar = false;
      _currentPageIndex = 1;
      _currentPageSet = pageSetController.authentication;
    });
  }

  void  _toDailyLog() {
    setState(() {
      showProgressBar = false;
      _currentPageIndex = 0;
      _currentPageSet = pageSetController.dailyLog;
    });
    
  }

  void _nextPage() {
    if (_currentPageIndex < _currentPageSet.widgets.length - 1) {
      setState(() {
        var currentPage = _currentPageSet.pages[_currentPageIndex];
        if (currentPage is LogHandler) {
          (currentPage as LogHandler).setResponses();
        }
        _currentPageIndex++;
        if (currentPage is ConfirmationPage) {
          pageSetController.profiling.compileResponses();
          print(currentPage.responses);
        }
        if (_currentPageIndex == _currentPageSet.widgets.length - 2) {
          List<String> res = pageSetController.dailyLog.compileResponses();
          print(res);
        }
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
      });
    }
    _progressController.animateTo(_progressValue(),
        duration: const Duration(milliseconds: 1000));
    _whiteBarController.animateTo(
        _currentPageIndex / (_currentPageSet.widgets.length - 1),
        duration: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }


}
