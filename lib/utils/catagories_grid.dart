import 'package:flutter/material.dart';
import 'package:project_samaritan/theme/styles.dart' as styleClass;

class CatagoriesGrid extends StatefulWidget {
  final String name;
  final Image medicineIcon;
  final int numberOfMainGroup;
  final String medicineType;
  final Color containerColorForCatagories;
  CatagoriesGrid(
      {super.key,
      required this.medicineIcon,
      required this.name,
      required this.medicineType,
      required this.numberOfMainGroup,
      required this.containerColorForCatagories});

  @override
  State<CatagoriesGrid> createState() => _CatagoriesGridState();
}

class _CatagoriesGridState extends State<CatagoriesGrid>
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
    return Expanded(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(BorderSide()),
                  color: widget.containerColorForCatagories,
                ),
                child: widget.medicineIcon,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //text for number fo main groups
                RichText(
                    text: TextSpan(
                  style: TextStyle(
                      color:
                          styleClass.Style.medicineDescriptionColorSecondary),
                  text:
                      '${widget.numberOfMainGroup} ${widget.medicineType} Group',
                )),
                // Text(
                //     '${widget.numberOfMainGroup} ${widget.medicineType} Group',
                //     style: TextStyle(color: Color.fromRGBO(89, 129, 149, 1))),
                const SizedBox(
                  height: 7,
                ),
                //text for the catagories of the medicines

                SizedBox(
                  width: 90,
                  child: RichText(
                    text: TextSpan(
                      text: widget.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              styleClass.Style.medicineDescriptionColorPrimary,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
