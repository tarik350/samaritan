import 'package:flutter/material.dart';
import 'package:project_samaritan/start/page1.dart';
import 'package:project_samaritan/start/page2.dart';
import 'package:project_samaritan/start/page3.dart';
import 'package:project_samaritan/start/page4.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FirstStartPage(),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SecondStartPage(),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ThirdStartPage(),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ForthStartPage(),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        height: 80,
        color: Theme.of(context).iconTheme.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  _controller.animateToPage(3,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                child: Text(
                  'Skip',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                )),
            Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 4,
                onDotClicked: (index) {
                  _controller.animateToPage(index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn);
                },
                effect: WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.grey.shade400,
                    spacing: 16,
                    dotColor: Colors.black),
              ),
            ),
            TextButton(
                onPressed: () {
                  _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                child: Text(
                  'Next',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
