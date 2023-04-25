import 'package:flutter/material.dart';
import 'package:project_samaritan/styles.dart' as styleClass;

// ignore: must_be_immutable
class HeadingRow extends StatelessWidget {
  final String heading;
  String? ref;
  HeadingRow({super.key, required this.heading, this.ref});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline2!.copyWith(
          fontSize: 20, color: styleClass.Style.medicineDescriptionColorMain),
    );
  }
}
