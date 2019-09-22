import 'package:fl_desafio_marvel/screens/home.page.dart';
import 'dart:math';
import 'package:flutter/material.dart';


class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 2.0;
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class MyPageView extends StatefulWidget {
  @override
  State createState() => new MyPageViewState();
}

class MyPageViewState extends State<MyPageView> {
  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  final List<Widget> _pages = <Widget>[
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: WidgetHeroi('thor'),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: WidgetHeroi('deadpool'),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: WidgetHeroi('rocket%20raccoon'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox (
      constraints: const BoxConstraints.expand(),
          child: new Scaffold(
        body: new IconTheme(
          data: new IconThemeData(color: _kArrowColor),
          child: new Stack(
            children: <Widget>[
              new PageView.builder(
                physics: new AlwaysScrollableScrollPhysics(),
                controller: _controller,
                itemBuilder: (BuildContext context, int index) {
                  return _pages[index % _pages.length];
                },
              ),
              new Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: new Container(
                  color: Colors.grey[800].withOpacity(0.5),
                  padding: const EdgeInsets.all(20.0),
                  child: new Center(
                    child: new DotsIndicator(
                      controller: _controller,
                      itemCount: _pages.length,
                      onPageSelected: (int page) {
                        _controller.animateToPage(
                          page,
                          duration: _kDuration,
                          curve: _kCurve,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
