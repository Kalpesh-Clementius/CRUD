import 'package:crudflutter/base_client.dart';
import 'package:crudflutter/user.dart';
import 'package:flutter/material.dart';

class EditForm extends StatefulWidget {
  final String value;
  final String values;
  final List<Qualification>? valuess;

  const EditForm({
    Key? key,
    required this.value,
    required this.values,
    required this.valuess,
  }) : super(key: key);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  String value = "Edits";
  String values = "Edits";
  TextEditingController nameController = TextEditingController();
  TextEditingController nameControllers = TextEditingController();
  TextEditingController nameControllerss = TextEditingController();
  List<Qualification> valuess = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit_Form"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0, right: 30, top: 150),
              child: Text(
                "ID: ${widget.value}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 40, left: 10),
                child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: widget.values,
                            labelText: widget.values,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your name";
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
                            hintText: widget.values,
                            labelText:
                                widget.valuess!.map((e) => e.degree).join(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your updated degree";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameControllerss,
                        decoration: InputDecoration(
                            hintText: widget.values,
                            labelText: widget.valuess!
                                .map((e) => e.completionData)
                                .join(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter updated Completion Date";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 140),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () async {
                                var id = widget.value;
                                var user = User(
                                    name: nameController.text == ""
                                        ? widget.values
                                        : nameController.text,
                                    qualifications: [
                                      Qualification(
                                          degree: nameControllers.text == ""
                                              ? widget.valuess!
                                                  .map((e) => e.degree)
                                                  .toString()
                                              : nameControllers.text,
                                          completionData: nameControllerss
                                                      .text ==
                                                  ""
                                              ? widget.valuess!
                                                  .map((e) => e.completionData)
                                                  .toString()
                                              : nameControllerss.text)
                                    ]);
                                var response = await BaseClient()
                                    .put("/users/${id}", user)
                                    .catchError((err) {});
                                if (response == null)
                                  return debugPrint("error1");
                                debugPrint("Successfull");

                                nameController.text = "";
                                nameControllers.text = "";
                                nameControllerss.text = "";

                                setState(() {
                                  
                                });
                              },
                              child: Text(
                                "Edit",
                                style: TextStyle(fontSize: 25),
                              ))),
                    ])))
          ]),
        ),
      ),
    );
  }
}
