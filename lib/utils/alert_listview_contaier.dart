import 'package:flutter/material.dart';

class AlertListViewContainer extends StatefulWidget {
  final String title;
  final String subTitle;
  final Color subTitleColor;
  final String imageName;
  AlertListViewContainer(
      {super.key,
      required this.imageName,
      required this.title,
      required this.subTitle,
      required this.subTitleColor});

  @override
  State<AlertListViewContainer> createState() => _AlertListViewContainerState();
}

class _AlertListViewContainerState extends State<AlertListViewContainer>
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
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 50, child: Image(image: AssetImage(
                        //this image will be passed from a server if the image is not passed or there is an error we will provide a default one
                        widget.imageName))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
                          child: RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  //this text will be fetched from the server
                                  text: widget.title)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
                          child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    color: widget.subTitleColor,
                                  ),
                                  // this text will be fetced from a server
                                  text: widget.subTitle)),
                        )
                      ],
                    ),
                  ]);
            }),
            OverlayEntry(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        animationDuration: const Duration(microseconds: 100),
                        foregroundColor: Colors.deepPurple.shade100,
                        padding: const EdgeInsets.all(0)),
                    //there will be a logic here which will open description lpage on click
                    onPressed: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.arrow_circle_right,
                        color: Colors.deepPurple.shade300,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
