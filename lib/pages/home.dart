import 'dart:math';
import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:project_samaritan/pages/scan_page.dart';
import 'package:project_samaritan/utils/catagories_grid.dart';
import 'package:project_samaritan/utils/popular_medicine_grid.dart';
import 'package:project_samaritan/utils/heading_row.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_samaritan/theme/styles.dart' as styleClass;
import 'package:project_samaritan/storage/med_storage.dart';

late int randomNumber;
late String titles;
late String titles2;
bool hasInternet = false;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, RouteAware {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  Color containerColor = Colors.deepPurple.shade100;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(microseconds: 1000))
      ..repeat();
    _animation = ColorTween(
            begin: Colors.deepPurple.shade100, end: Colors.deepPurple.shade200)
        .animate(_controller);
    _controller.forward();
    getMedName();
    InternetConnectionChecker().onStatusChange.listen((status) {
      var hasInternets = status == InternetConnectionStatus.connected;

      setState(() {
        hasInternet = hasInternets;
        // internetMessage = hasInternet ? '✔' : '⚠';
      });
    });
  }

  getMedName() {
    Random random = Random();
    randomNumber = random.nextInt(popular_medication.length);
    titles = popular_medication[randomNumber];
    titles2 = popular_medication_discription[randomNumber];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => OverlaySupport.global(
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
              color: styleClass.Style.medicineDescriptionColorMain),

          //title of the home page
          //this button will have some kind of animation
          // leading: IconButton(
          //   onPressed: () {
          //     // Navigator.of(context).push(PageTransition(
          //     //     child: AppDrawer(), type: PageTransitionType.leftToRight));
          //   },
          //   icon: Icon(er
          //     Icons.menu,
          //     color: Colors.black,
          //   ),
          // ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // the search button which gone scale up and down on click and open the search page

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  hasInternet
                      ? Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                        )
                      : Row(
                          children: [
                            BlinkText('No Internet',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                                beginColor: Colors.red.shade800,
                                endColor: Colors.transparent,
                                times: 10,
                                duration: Duration(seconds: 1)),
                            Container(
                              child: Icon(Icons.warning_rounded,
                                  color: Colors.red.shade700),
                            ),
                          ],
                        ),
                  SizedBox(
                    width: 9,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 18,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).iconTheme.color,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 48,
                      child: CircleAvatar(
                        radius: 46,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'samaritan',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text('version 1.0.0',
                        style: Theme.of(context).textTheme.headline3),
                  ],
                ),
              ),
              ListTile(
                style: ListTileStyle.drawer,
                title: const Text('popular medicine'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/popularMedicine');
                },
              ),
              ListTile(
                style: ListTileStyle.drawer,
                title: const Text('desclaimer'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/desclaimer');
                },
              ),
              // ListTile(
              //   style: ListTileStyle.drawer,
              //   title: const Text('about'),
              //   onTap: () {
              //     Navigator.popAndPushNamed(context, '/about');
              //   },
              // ),
              // ListTile(
              //   title: const Text('user manual'),
              //   onTap: () {
              //     Navigator.popAndPushNamed(context, '/userNamual');
              //   },
              // ),
              ListTile(
                title: const Text('Privacy Policy'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/privacyPolicy');
                },
              ),
              ListTile(
                title: const Text('Contact Us'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/contactUs');
                },
              ),
            ],
          ),
        ),

        //the whole content of the homepage
        body: Container(
          margin: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // the button we use to navigate to scan page
              GestureDetector(
                onTap: () {
                  setState(() {
                    containerColor = Colors.deepPurple.shade200;
                  });
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CameraScan(
                      exitButton: true,
                    );
                  }));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AnimatedContainer(
                    onEnd: () {},
                    padding: const EdgeInsets.all(17),
                    color: containerColor,
                    duration: const Duration(milliseconds: 100),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            color: Color.fromARGB(255, 42, 11, 107),
                          ),
                          // ignore: prefer_const_constructors
                          SizedBox(
                            width: 18,
                          ),
                          Text('Scan and Identify The Medicine',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 15))
                        ]),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 25,
              // ),
              //Popular medicine section
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeadingRow(
                        heading: 'Popular Medicines',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/popularMedicine');
                        },
                        child: Column(
                          children: [
                            Text(
                              'view all',
                              style: TextStyle(
                                  color: styleClass
                                      .Style.medicineDescriptionColorSecondary),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  FittedBox(
                    child: SizedBox(
                        height: 290,
                        width: MediaQuery.of(context).size.width,
                        // child: GridBuilder()
                        child: Row(
                          children: [
                            Expanded(
                              child: Material(
                                elevation: 12,
                                child: GridContainer(
                                  containerWidth: 80,
                                  //the med name
                                  title: titles,
                                  //the description
                                  subtitle: titles2,
                                  imageTitle: 'assets/images/medicine.png',
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: GridContainer(
                            //     containerWidth: 80,
                            //     title: titles2,
                            //     subtitle: 'Fits well',
                            //     imageTitle: 'assets/images/medicine.png',
                            //   ),
                            // )
                          ],
                        )),
                  )
                ],
              ),
              Divider(),
              //catagories section
              Column(
                children: [
                  Row(
                    children: [
                      HeadingRow(
                        heading: 'Catagories',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          //individual catagories 2 in a single row
                          CatagoriesGrid(
                            name: 'Depresents',
                            numberOfMainGroup: 4,
                            medicineType: 'Major',
                            //we might use some kind of animation on these buttons
                            medicineIcon:
                                Image.asset('assets/images/Backyard.png'),
                            containerColorForCatagories: Colors.green.shade100,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .05,
                          ),
                          CatagoriesGrid(
                            name: 'Hallucinogens',
                            medicineType: 'Major',
                            numberOfMainGroup: 6,
                            medicineIcon:
                                Image.asset('assets/images/Drawing room.png'),
                            containerColorForCatagories: Colors.red.shade50,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          CatagoriesGrid(
                            name: 'Stimulants',
                            medicineType: 'Main',
                            numberOfMainGroup: 3,
                            medicineIcon:
                                Image.asset('assets/images/Stimulants.png'),
                            containerColorForCatagories: Colors.red.shade100,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .05,
                          ),
                          CatagoriesGrid(
                            name: 'Opioids',
                            medicineType: 'Major',
                            numberOfMainGroup: 7,
                            medicineIcon:
                                Image.asset('assets/images/Living room.png'),
                            containerColorForCatagories: Colors.blue.shade100,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 12.0),
              //   child: Divider(),
              // ),
              // HeadingRow(
              //   heading: 'Alearts for Today',
              //   ref: '/popularMedicine',
              // ),
              // AlertForToday()
            ],
          ),
        ),
      ));
}
