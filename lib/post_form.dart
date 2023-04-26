import 'package:crudflutter/base_client.dart';
import 'package:crudflutter/user.dart';
import 'package:flutter/material.dart';


class PosrData extends StatefulWidget {
  const PosrData({super.key});

  @override
  State<PosrData> createState() => _PosrDataState();
}

class _PosrDataState extends State<PosrData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nameControllers = TextEditingController();
  TextEditingController nameControllerss = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) => {
              setState(() => {_dateTime = value!})
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ADD DATA"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 0, right: 30, top: 150),
                  child: Text(
                    'POST DATA',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.blue),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 40, left: 10),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  hintText: "Enter your name",
                                  labelText: "Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your Name";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                                controller: nameControllers,
                                decoration: InputDecoration(
                                    hintText: "Enter your Qualificaion",
                                    labelText: "Qualification",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter your qualification";
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                                controller: nameControllerss
                                  ..text =
                                      "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}",
                                onTap: () {
                                  _showDatePicker();
                                },
                                decoration: InputDecoration(
                                    hintText: "Enter the completion Date",
                                    labelText: "Completion date",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter the date";
                                  }
                                  return null;
                                }),
                            Container(
                              padding: EdgeInsets.only(left: 140.0, top: 50.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.blueAccent)),
                                child: Text(
                                  'ADD-DATA',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    final Snackbar = SnackBar(
                                        content: Text("Submitting Form"));

                                    var user = User(
                                        name: nameController.text,
                                        qualifications: [
                                          Qualification(
                                              degree: nameControllers.text,
                                              completionData:
                                                  nameControllerss.text)
                                        ]);
                                    var response = await BaseClient()
                                        .post("/users", user)
                                        .catchError((err) {});

                                    if (response == null)
                                      return debugPrint("error1");
                                    debugPrint("Successfull");

                                    nameController.text = "";
                                    nameControllers.text = "";
                                    nameControllerss.text = "";
                                  }
                                },
                              ),
                            ),
                          ],
                        ))),
              ],
            ),
          ),
        ));
  }
}
