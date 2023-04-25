import 'package:flutter/material.dart';
import 'package:project_samaritan/utils/popular_medicine_grid.dart';
import 'package:project_samaritan/theme/styles.dart' as styleClass;
import 'package:project_samaritan/storage/med_storage.dart';

class PopularMedicinePage extends StatefulWidget {
  const PopularMedicinePage({super.key});

  @override
  State<PopularMedicinePage> createState() => _PopularMedicinePageState();
}

class _PopularMedicinePageState extends State<PopularMedicinePage>
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: styleClass.Style.medicineDescriptionColorMain,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: EdgeInsets.only(left: 35),
          child: Text(
            'Popular medicines',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: styleClass.Style.medicineDescriptionColorMain,
                fontSize: 20),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: popular_medication.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 1.0,
                        ),
                      ]),
                      child: GridContainer(
                        containerWidth: 200,
                        title: popular_medication[index],
                        subtitle: popular_medication_discription[index],
                        imageTitle: 'assets/images/medicine.png',
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
