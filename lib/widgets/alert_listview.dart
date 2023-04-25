import 'package:project_samaritan/utils/alert_listview_contaier.dart';
import 'package:flutter/material.dart';

class AlertForToday extends StatefulWidget {
  AlertForToday({super.key});

  @override
  State<AlertForToday> createState() => _AlertForTodayState();
}

class _AlertForTodayState extends State<AlertForToday>
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
        child: ListView(
      children: [
        /// THESE ALL HARD CODED TEXTS WILL BE REPLACED BY SOMETHING THAT WILL GET FROM SERVER
        AlertListViewContainer(
            imageName: 'assets/images/paracetamol.jpeg',
            title: 'Vi-Jon, LLC Expands Voluntary Worldwide Recall',
            subTitle:
                'of All Flavors and Lots Within Expiry of Magnesium Citrate Saline Laxative Ora',
            subTitleColor: Color.fromRGBO(89, 129, 149, 1)),
        AlertListViewContainer(
            imageName: 'assets/images/paracetamol.jpeg',
            title: 'FDA alerts to voluntary recall of compounded drugs ',
            subTitle:
                'due to sterility issues by Drug Depot, LLC, dba APS Pharmacy',
            subTitleColor: Color.fromRGBO(89, 129, 149, 1)),
        AlertListViewContainer(
            imageName: 'assets/images/paracetamol.jpeg',
            title: 'Vi-Jon, LLC Expands Voluntary Worldwide Recall',
            subTitle:
                'of All Flavors and Lots Within Expiry of Magnesium Citrate Saline Laxative Ora',
            subTitleColor: Color.fromRGBO(89, 129, 149, 1))
      ],
    ));
  }
}
