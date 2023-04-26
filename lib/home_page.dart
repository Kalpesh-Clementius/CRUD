import 'package:crudflutter/base_client.dart';
import 'package:crudflutter/user.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(size: 72),
            SizedBox(
                height: 44,
                width: 350,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () async {
                      var response =
                          await BaseClient().get("/users").catchError((err) {});
                      print(response);

                      if (response == null) return debugPrint("error1");
                      debugPrint("Successfull");

                      Navigator.pushNamed(context, "showdata");
                      var users = userFromJson(response);
                      debugPrint(users.length.toString());
                    },
                    child: Text(
                      "GET",
                      style: TextStyle(fontSize: 25),
                    ))),
            SizedBox(
                height: 44,
                width: 350,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {
                      var user = User(name: "KALPESH MAHALE", qualifications: [
                        Qualification(
                            degree: "B.Tech", completionData: "22-05-2021")
                      ]);
                      var response = await BaseClient()
                          .post("/users", user)
                          .catchError((err) {});

                      if (response == null) return debugPrint("error1");
                      debugPrint("Successfull");
                      Navigator.pushNamed(context, "postdata");
                    },
                    child: Text(
                      "POST",
                      style: TextStyle(fontSize: 25),
                    ))),
          ],
        ),
      )),
    );
  }
}
