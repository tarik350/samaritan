import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_samaritan/pages/home.dart';
import 'dart:io';
import 'dart:ui';
import 'package:project_samaritan/styles.dart' as styleClass;
import 'package:project_samaritan/services/remote_Service.dart' as remote;
import 'package:project_samaritan/models/post.dart';
import '../models/boxes.dart';
import '../models/transaction.dart';
import '../state/app_state.dart';

String errorMessage = 'Medication \n';

class MedicineDescription extends StatefulWidget {
  final String? imagePath;
  final String medName;
  final String? flag;
  final Transaction? medicine;
  MedicineDescription(
      {Key? key,
      this.imagePath,
      this.medicine,
      required this.medName,
      this.flag})
      : super(key: key);
  // const MedicineDescription({super.key});

  @override
  State<MedicineDescription> createState() => _MedicineDescriptionState();
}

class _MedicineDescriptionState extends State<MedicineDescription>
    with SingleTickerProviderStateMixin {
  Post? posts;
  bool isLoading = false;

  late ImageProvider backgroundImagePrimary;

  ///variables for internet connection
  // late StreamSubscription subscription;
  bool isDeviceConnected = true;
  @override
  void initState() {
    super.initState();
    if (widget.flag != 'saved') {
      // final box = Boxes.getTransactions();
      // final keys = box.keys.toList();
      ////i will use this variable to check if the medicine we are searching is already save or not
      ///and if it is already saved display that information dont call get data
      // bool found = keys.contains(widget.medName);

      //the algorthtm
      // if (found) {
      //dont call getData
      //query the medicine from the local storage
      //and assign it to some global varible like we did with the post
      // } else {
      //just call getData
      // }

      getData();
    }
    setBackgroundImage();
  }

  Future<bool> _setInterval() async {
    await Future.delayed(Duration(seconds: 15));
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setBackgroundImage() async {
    if (widget.imagePath == null) {
      backgroundImagePrimary = const AssetImage('assets/images/logo1.png');
    } else {
      backgroundImagePrimary = FileImage(File(widget.imagePath!));
    }
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    posts = await remote.RemoteService().getPosts(widget.medName);
    setState(() {
      isLoading = false;
    });
    if (posts != null) {
      print(posts?.results);
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
    final name = widget.medName;
    final description = posts?.results[0].description[0] as String;
    final adverseReaction = posts?.results[0].adverseReactions[0] as String;
    final id = posts?.results[0].id[0] as String;
    final overdossage = posts?.results[0].dosageAndAdministration[0] as String;
    keys.forEach((element) => print(element));
    if (keys.isNotEmpty) {
      for (int i = 0; i < keys.length; i++) {
        if (keys[i] != widget.medName) {
          StateInheritedWidget.of(context)?.addTransaction(
              name, description, adverseReaction, id, overdossage);
        }
      }
    } else {
      StateInheritedWidget.of(context)
          ?.addTransaction(name, description, adverseReaction, id, overdossage);
    }
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
                                            (posts?.results.isEmpty ?? true)
                                                ? Container()
                                                : Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'The medicine has been identified',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12),
                                                        ),
                                                        Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                            Text(
                                              widget.medName
                                                  .trim()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: (posts?.results
                                                              .isEmpty ??
                                                          true)
                                                      ? styleClass.Style
                                                          .medicineDescriptionColorPrimary
                                                      : Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            ),
                                            widget.flag != 'saved' &&
                                                    isLoading == true
                                                ? SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .1,
                                                  )
                                                : SizedBox(),
                                            isLoading == false
                                                ? Column(
                                                    children: [
                                                      RichText(
                                                          text: TextSpan(
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                              children: [
                                                            widget.flag !=
                                                                    'saved'
                                                                ? TextSpan(
                                                                    text:
                                                                        "\nID \n",
                                                                    style: GoogleFonts
                                                                        .raleway(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: styleClass
                                                                          .Style
                                                                          .medicineDescriptionColorPrimary,
                                                                      fontSize:
                                                                          25,
                                                                    ),
                                                                  )
                                                                : TextSpan(),
                                                            widget.flag !=
                                                                    'saved'
                                                                ? TextSpan(
                                                                    text: (posts
                                                                            ?.results[
                                                                                index]
                                                                            .id ??
                                                                        widget
                                                                            .medicine
                                                                            ?.medId),
                                                                    style: GoogleFonts
                                                                        .raleway(
                                                                      color: styleClass
                                                                          .Style
                                                                          .medicineDescriptionColorSecondary,
                                                                      fontSize:
                                                                          18,
                                                                    ))
                                                                : TextSpan(),
                                                            TextSpan(
                                                              text:
                                                                  "\nDescription:\n",
                                                              style: GoogleFonts
                                                                  .raleway(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: styleClass
                                                                    .Style
                                                                    .medicineDescriptionColorPrimary,
                                                                fontSize: 25,
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
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  color: styleClass
                                                                      .Style
                                                                      .medicineDescriptionColorSecondary,
                                                                  fontSize: 18,
                                                                )),
                                                            TextSpan(
                                                              text:
                                                                  "\nDosage And Administration \n",
                                                              style: GoogleFonts
                                                                  .raleway(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: styleClass
                                                                    .Style
                                                                    .medicineDescriptionColorPrimary,
                                                                fontSize: 25,
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
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  color: styleClass
                                                                      .Style
                                                                      .medicineDescriptionColorSecondary,
                                                                  fontSize: 18,
                                                                )),
                                                            TextSpan(
                                                              text:
                                                                  "\nAdverseReactions \n",
                                                              style: GoogleFonts
                                                                  .raleway(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: styleClass
                                                                    .Style
                                                                    .medicineDescriptionColorPrimary,
                                                                fontSize: 25,
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
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  color: styleClass
                                                                      .Style
                                                                      .medicineDescriptionColorSecondary,
                                                                  fontSize: 18,
                                                                )),
                                                          ])),
                                                    ],
                                                  )
                                                : hasInternet == false
                                                    ? FutureBuilder(
                                                        future: _setInterval(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Theme.of(
                                                                        context)
                                                                    .iconTheme
                                                                    .color,
                                                              ),
                                                            );
                                                          }

                                                          return Column(
                                                            children: [
                                                              Text(
                                                                  'make sure you spelled the name correctly',
                                                                  style: GoogleFonts.raleway(
                                                                      textStyle: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color: Colors
                                                                              .red
                                                                              .shade700))),
                                                              Text(
                                                                'And connected to the internet',
                                                                style: GoogleFonts.raleway(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    textStyle: TextStyle(
                                                                        color: Colors
                                                                            .red
                                                                            .shade700)),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .warning_rounded,
                                                                color:
                                                                    Colors.red,
                                                              )
                                                            ],
                                                          );
                                                        })
                                                    : FutureBuilder(
                                                        future: _setInterval(),
                                                        builder: (context,
                                                            intervalSnapshot) {
                                                          if (intervalSnapshot
                                                              .hasData) {
                                                            if (posts?.results
                                                                    .isEmpty ??
                                                                true) {
                                                              return Column(
                                                                children: [
                                                                  Text(
                                                                      'make sure you spelled the name correctly',
                                                                      style: GoogleFonts.raleway(
                                                                          textStyle: TextStyle(
                                                                              fontSize: 10,
                                                                              color: Colors.red.shade700))),
                                                                  Text(
                                                                    'And connected to the internet',
                                                                    style: GoogleFonts.raleway(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        textStyle:
                                                                            TextStyle(color: Colors.red.shade700)),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .warning_rounded,
                                                                    color: Colors
                                                                        .red,
                                                                  )
                                                                ],
                                                              );
                                                            }
                                                          }
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color,
                                                            ),
                                                          );
                                                        })

                                            ///here after a few second we have to check if posts.result is empty or nto
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  widget.flag != 'saved' && isLoading == false
                                      ? const Divider()
                                      : Container(),
                                  widget.flag != 'saved' && isLoading == false
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
