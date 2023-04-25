import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_samaritan/models/transaction.dart';
import 'package:project_samaritan/theme/styles.dart' as styleClass;

import 'package:project_samaritan/pages/medicine_Description.dart';
import '../models/boxes.dart';
import '../state/app_state.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _AnotherSavedState();
}

class _AnotherSavedState extends State<SavedPage>
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Saved medicines',
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
          ),
        ),
      ),
      body: ValueListenableBuilder<Box<Transaction>>(
        valueListenable: Boxes.getTransactions().listenable(),
        builder: (content, box, _) {
          final medicines = box.values.toList().cast<Transaction>();
          return buildContent(medicines);
        },
      ),
    );
  }

  Widget buildContent(List<Transaction> mediciens) {
    if (mediciens.isEmpty) {
      return const Center(
        child: Text(
          'No Medicines yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: mediciens.length,
              itemBuilder: (BuildContext context, int index) {
                final medicine = mediciens[index];

                return buildContainer(context, medicine);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildContainer(BuildContext context, Transaction medicine) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        StateInheritedWidget.of(context)?.deleteTransaction((medicine));
      },
      background: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 8),
        color: Colors.red.shade800,
        child: const Center(
          child: Icon(
            Icons.delete,
            color: Colors.black,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: GestureDetector(
          onTap: () {
            ////this is to navigate to MedicineDescription
            // Navigator.of(context).push(PageTransition(
            //     child: MedicineDescription(
            //       medicine: medicine,
            //       flag: 'saved',
            //     ),
            //     type: PageTransitionType.bottomToTop));
            //// this is to navigate to MedicineDescriptions
            Navigator.of(context).push(PageTransition(
                child: MedicineDescription(
                  medicine: medicine,
                  flag: 'saved',
                  medName: medicine.name,
                ),
                type: PageTransitionType.bottomToTop));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(238, 238, 238, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 1.0,
                ),
              ],
            ),
            padding: EdgeInsets.all(12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(medicine.name.trim().toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: styleClass
                              .Style.medicineDescriptionColorPrimary)),
                  Text(
                    medicine.description.substring(0, 300) + '...',
                    style: TextStyle(
                        color:
                            styleClass.Style.medicineDescriptionColorSecondary),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Widget buildTransaction(BuildContext context, Transaction medicine) {
    return Card(
      color: Theme.of(context).iconTheme.color,
      child: Dismissible(
        onDismissed: (direction) {
          StateInheritedWidget.of(context)?.deleteTransaction(medicine);
        },
        background: Container(
          color: Colors.red.shade800,
          child: const Center(
            child: Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
        ),
        key: UniqueKey(),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          title: Text(
            medicine.name,
            maxLines: 2,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          subtitle: const Text(
            'some desciption',
            style: TextStyle(color: Colors.white),
          ),
          trailing: const Text(
            '😀',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
