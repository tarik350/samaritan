import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstStartPage extends StatefulWidget {
  const FirstStartPage({super.key});

  @override
  State<FirstStartPage> createState() => _FirstStartPageState();
}

class _FirstStartPageState extends State<FirstStartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Overlay(
        initialEntries: [
          ///first overlay entry for  the background image
          OverlayEntry(builder: (context) {
            return Column(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/logo1.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .05,
                )
              ],
            );
          }),

          ///second overlay for the bottom container
          OverlayEntry(builder: (context) {
            return Column(
              verticalDirection: VerticalDirection.up,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .08,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).iconTheme.color,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(children: [
                        Text(
                          'Samaritan',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Version 1.0.0',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white),
                        )
                      ]),
                    ),
                  ),
                )
              ],
            );
          }),

          ///third overlay to create the swipe button animation
          OverlayEntry(builder: (context) {
            return Container();
          })
        ],
      ),
    );
  }
}
