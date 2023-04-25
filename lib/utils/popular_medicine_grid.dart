import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_samaritan/pages/medicine_Description.dart';
import 'package:project_samaritan/styles.dart' as styleClass;

// List<String> popular_medication = ["ampicillin","ciprofloxacin","Atorvastatin","Metoprolol","Escitalopram"];
// int randomNumber = 0;
String randomeMedTitle = "";
String medication = '';

class GridContainer extends StatefulWidget {
  // List<String> popular_medication = ["ampicillin","ciprofloxacin","vancomycin"];

  final String title;
  final String subtitle;
  final String imageTitle;
  final double containerWidth;

  GridContainer(
      {Key? key,
      required this.containerWidth,
      required this.title,
      required this.subtitle,
      required this.imageTitle})
      : super(key: key);

  @override
  State<GridContainer> createState() => _GridContainerState();
}

class _GridContainerState extends State<GridContainer> {
  @override
  void initState() {
    super.initState();

    randomeMedTitle = widget.title;

    // print(widget.title);

    // getMedName();
  }
  // String getMedName(){
  //   return widget.title;
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        // getMedName();
        Navigator.of(context).push(PageTransition(
            child: MedicineDescription(
              medName: widget.title,
            ),
            type: PageTransitionType.bottomToTop));
      },
      child: Container(
        color: const Color.fromRGBO(238, 238, 238, 1),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: [
              //same discriptive words and medicine image

              //the name of the medicine
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 20),
                  child: Row(
                    children: [
                      RichText(
                          text: TextSpan(
                        text: widget.title,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 22,
                            color: styleClass
                                .Style.medicineDescriptionColorPrimary),
                      )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //this is a dummy text which will be replaced letter
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .65,
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: styleClass.Style
                                        .medicineDescriptionColorSecondary,
                                    fontSize: 20),
                                children: [
                              //we will put here some minor discription of the medicine
                              TextSpan(text: widget.subtitle),
                            ])),
                      ),
                    ),
                    // SizedBox(
                    //     height: MediaQuery.of(context).size.height * .09,
                    //     child: Image(
                    //         //this is a dummy text which will be replaced letter

                    //         image: AssetImage(widget.imageTitle)))
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
