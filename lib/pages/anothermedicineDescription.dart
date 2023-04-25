import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_samaritan/models/post.dart';
import 'package:project_samaritan/pages/dispalay_image_from_gallery.dart';
import 'package:project_samaritan/pages/search.dart';
import 'package:project_samaritan/services/remote_Service.dart' as remote;

import '../models/boxes.dart';
import '../models/transaction.dart';
import '../state/app_state.dart';

// String? medName;
///Expermenting with medicine description
class AnotherMedicineDescription extends StatefulWidget {
  final String? imagePath;
  final Transaction? medicine;
  final String? flag;

  AnotherMedicineDescription({
    Key? key,
    this.imagePath,
    this.medicine,
    this.flag,
  }) : super(key: key);

  @override
  State<AnotherMedicineDescription> createState() =>
      _AnotherMedicineDescriptionState();
}

class _AnotherMedicineDescriptionState extends State<AnotherMedicineDescription>
    with SingleTickerProviderStateMixin {
  Post? posts;
  String? description;
  var isLoading = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  late ImageProvider backgroundImagePrimary;

  ///variables for internet connection
  late StreamSubscription subscription;
  bool isDeviceConnected = true;

  @override
  void initState() {
    super.initState();
    getConnectivity();
    // getData().then(
    //   (value) {
    //     posts = value;
    //   },
    // );

    setBackgroundImage();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          setState(() async {
            isDeviceConnected = await InternetConnectionChecker().hasConnection;
          });
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
    _controller.dispose();
  }

  void setBackgroundImage() async {
    if (widget.imagePath == null) {
      backgroundImagePrimary = const AssetImage('assets/images/logo 1.png');
    } else {
      backgroundImagePrimary = FileImage(File(widget.imagePath!));
    }
  }

  void _saveButtonHandler(BuildContext context) async {
    ///this is where we save medicine instance to data base

    // StateInheritedWidget.of(context)
    //     ?.incrementMedicineCount();

    ///the box we saved medicines on
    ///and all the keys that have been saved before
    final box = Boxes.getTransactions();
    final keys = box.keys.toList();

    ///variables passed to addTransacitons
    final name = widget.flag == 'search' ? SearchedText : scannedText;
    final description = posts?.results[0].description[0] as String;
    final adverseReaction = posts?.results[0].adverseReactions[0] as String;
    final id = posts?.results[0].id[0] as String;
    final overdossage = posts?.results[0].dosageAndAdministration[0] as String;
    if (keys.isNotEmpty) {
      for (int i = 0; i < keys.length; i++) {
        if (keys[i] != scannedText) {
          StateInheritedWidget.of(context)?.addTransaction(
              name, description, adverseReaction, id, overdossage);
        }
      }
    } else {
      StateInheritedWidget.of(context)
          ?.addTransaction(name, description, adverseReaction, id, overdossage);
    }
  }

  ///expermenting with another solution for this
  Future<Post> getData(String scannedText) async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = false;
    });
    return remote.RemoteService().getPosts(scannedText);
    // if (posts != null) {
    //   print(posts?.results);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Overlay(
        initialEntries: [
          ///overlay entry one
          ///a stack of the back ground image and back botton at the top
          OverlayEntry(builder: (context) {
            return Stack(
              children: [
                //background image
                Center(
                  child: Container(
                    child: Column(
                      verticalDirection: VerticalDirection.down,
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: .5,
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: backgroundImagePrimary,
                                        fit: BoxFit.cover)),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 8.0, sigmaY: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.0)),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //back button at the top
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      //   Navigator.pushNamed(context, '/home',
                      //       arguments: {"containerColor": Colors.red});
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: const Color(1).computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }),

          ///overlay entry two
          OverlayEntry(builder: (context) {
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: DraggableScrollableSheet(
                  initialChildSize: .7,
                  minChildSize: 0.6,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    //the dragable container which we use to display medicine discription
                    return ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.white,
                        child: Overlay(
                          ///overlaly entry three
                          initialEntries: [
                            OverlayEntry(builder: (context) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      controller: scrollController,
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Column(
                                          children: [
                                            // (posts?.results.isEmpty ?? true)
                                            //     ? Container()
                                            //     : Container(
                                            //         padding:
                                            //             EdgeInsets.symmetric(
                                            //                 vertical: 8),
                                            //         child: Row(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .center,
                                            //           children: [
                                            //             Text(
                                            //               'the medicine has been identified',
                                            //               style: TextStyle(
                                            //                   color:
                                            //                       Colors.green,
                                            //                   fontWeight:
                                            //                       FontWeight
                                            //                           .bold,
                                            //                   fontSize: 12),
                                            //             ),
                                            //             Icon(
                                            //               Icons.check_circle,
                                            //               color: Colors.green,
                                            //             )
                                            //           ],
                                            //         ),
                                            //       ),
                                            // isLoading == false
                                            //     ? ScaleTransition(
                                            //         scale: _animation,
                                            //         child: const Padding(
                                            //           padding:
                                            //               EdgeInsets.all(8.0),
                                            //           child: Center(
                                            //               child: Icon(
                                            //             Icons.arrow_drop_up,
                                            //             size: 40,
                                            //             color: Colors.red,
                                            //           )),
                                            //         ),
                                            //       )
                                            //     : Container(),

                                            FutureBuilder(
                                                future: widget.flag == 'search'
                                                    ? remote.RemoteService()
                                                        .getPosts(searchedMed)
                                                        .then((value) => value)
                                                    : remote.RemoteService()
                                                        .getPosts(scannedText)
                                                        .then((value) => value),
                                                builder: (context,
                                                    AsyncSnapshot<Post>
                                                        snapshot) {
                                                  return Text(
                                                    scannedText ??
                                                        searchedMed ??
                                                        widget.medicine?.name,
                                                    style: TextStyle(
                                                        color: snapshot
                                                                    .data
                                                                    ?.results[0]
                                                                    .description[
                                                                        0]
                                                                    .isEmpty ??
                                                                true
                                                            ? Colors.black
                                                            : Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  );
                                                }),

                                            ///to check whether server data is ready or not
                                            FutureBuilder(
                                              future: remote.RemoteService()
                                                  .getPosts(scannedText ??
                                                      searchedMed)
                                                  .then((value) => value),
                                              builder: (context,
                                                  AsyncSnapshot<Post>
                                                      snapshot) {
                                                posts = snapshot.data;
                                                if (snapshot.hasData) {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'the medicine has been identified',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      RichText(
                                                          text: TextSpan(
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                              children: [
                                                            const TextSpan(
                                                              text: "\n ID \n",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .deepPurple,
                                                                fontSize: 25,
                                                                // textAlign: TextAlign.right,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: (posts
                                                                      ?.results[
                                                                          index]
                                                                      .id ??
                                                                  widget
                                                                      .medicine
                                                                      ?.medId),
                                                            ),
                                                            const TextSpan(
                                                              text:
                                                                  "\n Description \n",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .deepPurple,
                                                                fontSize: 25,
                                                                // textAlign: TextAlign.right,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: (posts
                                                                          ?.results[
                                                                              index]
                                                                          .description[
                                                                      index] ??
                                                                  widget
                                                                      .medicine
                                                                      ?.description),
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                // textAlign: TextAlign.right,
                                                              ),
                                                            ),
                                                            const TextSpan(
                                                              text:
                                                                  "\n Dosage And Administration \n",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .deepPurple,
                                                                fontSize: 25,
                                                                // textAlign: TextAlign.right,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: (posts
                                                                          ?.results[
                                                                              index]
                                                                          .dosageAndAdministration[
                                                                      index] ??
                                                                  widget
                                                                      .medicine
                                                                      ?.overdossage),
                                                            ),
                                                            const TextSpan(
                                                              text:
                                                                  "\n AdverseReactions \n",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .deepPurple,
                                                                fontSize: 25,
                                                                // textAlign: TextAlign.right,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: (posts
                                                                          ?.results[
                                                                              index]
                                                                          .adverseReactions[
                                                                      index] ??
                                                                  widget
                                                                      .medicine
                                                                      ?.adverseReaction),
                                                            ),
                                                          ])),
                                                    ],
                                                  );
                                                } else {
                                                  return CircularProgressIndicator(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color,
                                                  );
                                                }
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  widget.flag != 'saved'
                                      ? const Divider()
                                      : Container(),
                                  widget.flag != 'saved'
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 18),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                minimumSize:
                                                    const Size.fromHeight(
                                                        50), // NEW
                                              ),
                                              onPressed: () async {
                                                _saveButtonHandler(context);
                                              },
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const <Widget>[
                                                    Icon(Icons.bookmark,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'save',
                                                      style: TextStyle(
                                                          fontSize: 24),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        )
                                      : Container()
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
