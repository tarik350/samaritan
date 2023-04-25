import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:project_samaritan/theme/styles.dart' as styleClass;

final nameController = TextEditingController();
final subjectController = TextEditingController();
final emailController = TextEditingController();
final messageController = TextEditingController();

Future sendEmail() async {
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const serviceId = "service_f4de5us";
  const templateId = "template_1xe3jto";
  const userId = "user_1ovCE8JKEGiClzfWW7e6G";
  const accessToken = "b90f95e96710ca7d4b37b60c2c3fc710";

  final response = await http.post(url,
      headers: {
        'Content-type': 'application/json',
      },
      body: json.encode({
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "accessToken": accessToken,
        "template_params": {
          "name": nameController.text,
          "subject": subjectController.text,
          "message": messageController.text,
          "user_email": emailController.text,
        }
      }));
  print(nameController.text +
      subjectController.text +
      messageController.text +
      emailController.text +
      response.body);
  return response.statusCode;
}

Color lowerColor = Colors.grey.shade600;
Color higherColor = styleClass.Style.medicineDescriptionColorMain;

Color nameColor = lowerColor;
Color subjectColor = lowerColor;
Color emailColor = lowerColor;
Color messageColor = lowerColor;

class ContactPage extends StatefulWidget {
  State<ContactPage> createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode _focusNode;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                _controller.clear();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: styleClass.Style.medicineDescriptionColorMain,
            ),
            title: Container(
                margin: EdgeInsets.only(left: 55),
                child: Text(
                  "Contact us",
                  style: TextStyle(
                      color: styleClass.Style.medicineDescriptionColorMain),
                )),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10, 25, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Focus(
                    onFocusChange: (value) {
                      setState(() {
                        nameColor = value ? higherColor : lowerColor;
                      });
                    },
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*name can not be empty';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameController,
                      decoration: InputDecoration(
                          focusColor:
                              styleClass.Style.medicineDescriptionColorMain,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: styleClass
                                      .Style.medicineDescriptionColorMain)),
                          icon: Icon(
                            Icons.person,
                            color: nameColor,
                          ),
                          labelText: "Name",
                          labelStyle:
                              TextStyle(color: nameColor)), // InputDecoration
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Focus(
                    onFocusChange: (value) {
                      setState(() {
                        subjectColor = value ? higherColor : lowerColor;
                      });
                    },
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*subject can not be empty';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: subjectController,
                      decoration: InputDecoration(
                          focusColor:
                              styleClass.Style.medicineDescriptionColorMain,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: styleClass
                                      .Style.medicineDescriptionColorMain)),
                          icon: Icon(
                            Icons.subject,
                            color: subjectColor,
                          ),
                          labelText: "subject",
                          labelStyle: TextStyle(
                              color: subjectColor)), // InputDecoration
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Focus(
                    onFocusChange: (value) {
                      setState(() {
                        emailColor = value ? higherColor : lowerColor;
                      });
                    },
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*email can not be empty';
                        } else if (!value.contains('@')) {
                          return 'please enter a valid email address';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      decoration: InputDecoration(
                          focusColor:
                              styleClass.Style.medicineDescriptionColorMain,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: styleClass
                                      .Style.medicineDescriptionColorMain)),
                          icon: Icon(
                            Icons.email,
                            color: emailColor,
                          ),
                          labelText: "Email",
                          labelStyle:
                              TextStyle(color: emailColor)), // InputDecoration
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Focus(
                    onFocusChange: (value) {
                      setState(() {
                        messageColor = value ? higherColor : lowerColor;
                      });
                    },
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*message can not be empty';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: messageController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          focusColor:
                              styleClass.Style.medicineDescriptionColorMain,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: styleClass
                                      .Style.medicineDescriptionColorMain)),
                          icon: Icon(
                            Icons.message,
                            color: messageColor,
                          ),
                          labelText: "message",
                          labelStyle: TextStyle(
                              color: messageColor)), // InputDecoration
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    // backgroundColor:
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            styleClass.Style.medicineDescriptionColorMain),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.of(context).pop(true);
                              });
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Center(
                                        child: Text('sending',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });

                        sendEmail().then((value) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(Duration(seconds: 5), () {
                                  Navigator.of(context).pop(true);
                                });
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Center(
                                          child: Text('message sent',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green)),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }).onError((error, stackTrace) => showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 5), () {
                                Navigator.of(context).pop(true);
                              });
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AlertDialog(
                                    backgroundColor: Colors.grey.shade400,
                                    title: Center(
                                      child: Text(
                                        'error sending a message',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }));
                      }
                    },
                    child: Text(
                      "Send Message",
                      style: TextStyle(fontSize: 12),
                    ),
                  ), // TextFormField
                ],
              ),
            ),
          ),
        ));
  }
}
