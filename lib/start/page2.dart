import 'package:flutter/material.dart';

class SecondStartPage extends StatefulWidget {
  const SecondStartPage({super.key});

  @override
  State<SecondStartPage> createState() => _SecondStartPageState();
}

class _SecondStartPageState extends State<SecondStartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).iconTheme.color,

      ///the entire widget starts here
      body: Center(
        ///sized box to give the page consistant width
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ///the logo
                Container(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/image1.png',
                    width: MediaQuery.of(context).size.width * .7,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '👋',
                          style: TextStyle(fontSize: 40),
                        )
                      ],
                    ),

                    ///everthing under the logo
                    FittedBox(
                      child: Column(
                        children: [
                          /// the text beneth the logo

                          Text(
                            'Say good bye',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'to Confusion About',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                          Text(
                            'Medication',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //the three dots to indicate page navigation

                    SizedBox(
                      height: 40,
                    ),
                    // the button  at the bottom of the page to navigate to home page
                  ],
                ),
                Container(
                  height: 60,
                )
              ]),
        ),
      ),
    );
  }
}

Widget dotContainer() {
  return Container(
    height: 10,
    width: 10,
    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
  );
}
