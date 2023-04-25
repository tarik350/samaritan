import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:project_samaritan/theme/styles.dart' as styleClass;
import 'package:project_samaritan/pages/medicine_Description.dart';
import '../models/post.dart';

var searchedMed;

//we have to rethink what this serch widget is going to be in general
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
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

  // serchMedication(String value) {
  //   searchedMed = value;
  //   print(searchedMed);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            // borderSide: BorderSide.none,
            child: SizedBox(
              height: 40,
              child: TextField(
                autofocus: true,

                style: TextStyle(fontSize: 20, height: 30 / 20),
                onSubmitted: (value) async {
                  searchedMed = value;
                  await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return MedicineDescription(
                      medName: searchedMed,
                    );
                  }));
                },
                //textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    contentPadding: const EdgeInsets.all(8),
                    // contentPadding:
                    //     EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                      color: Colors.grey.shade500,
                      height: 40,
                      fontSize: 15,
                    ),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 0),
                      child: Row(children: [
                        Icon(
                          Icons.search,
                          color: Colors.grey.shade500,
                        ),
                        const Text('search'),
                      ]),
                    ),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.shade300),
              ),
            )),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' SEARCH BY TYPING',
                  style: GoogleFonts.raleway(
                      textStyle: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(
                              color:
                                  styleClass.Style.medicineDescriptionColorMain,
                              fontSize: 18,
                              fontWeight: FontWeight.normal)),
                ),
                Text(
                  'MEDICINE NAME',
                  style: GoogleFonts.raleway(
                      textStyle: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(
                              color:
                                  styleClass.Style.medicineDescriptionColorMain,
                              fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RemoteServiceSearch extends _SearchPageState {
  var medication = searchedMed;

  // String setMedication(String med){
  //   return medication = med;
  // }
  Future<Post> getPosts() async {
    // print("=========================================="+medication+"------------------------------------------");
    var client = http.Client();

    var uri = Uri.parse(
        'https://api.fda.gov/drug/label.json?search=description:${medication}&limit=1');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      print("==========================================" +
          medication +
          "-----------*******------******-----------");
      return postFromJson(json);
    } else {
      return postFromJson(response.statusCode.toString());
    }
  }

// RemoteService(this.medication);
}
