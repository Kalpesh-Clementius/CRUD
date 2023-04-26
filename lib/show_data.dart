import 'package:crudflutter/base_client.dart';
import 'package:crudflutter/edit_form.dart';
import 'package:crudflutter/remote_server.dart';
import 'package:crudflutter/user.dart';
import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  List<User>? posts;
  List<Qualification>? postss;

  var isLoaded = false;
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await RemoteServer().getPosts();
    setState(() {});
    if (posts != null) isLoaded = true;
    print(posts);
  }

  void ondelete(id) async {
    var response =
        await BaseClient().delete("/users/${id}").catchError((err) => {});
    setState(() {
      getData();
    });
    // ignore: unnecessary_null_comparison
    if (response == null) return debugPrint("error1");
    debugPrint("Successfull");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Data"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
            itemCount: 40,
            itemBuilder: (context, index) {
              return Container(
                child: Row(children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 20,
                          width: 135,
                          child: Text(
                            posts![index].name.toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18),
                          )),
                      Container(
                          height: 35,
                          width: 35,
                          margin: EdgeInsets.only(left: 50),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditForm(
                                        value: posts![index].id.toString(),
                                        values: posts![index].name.toString(),
                                        valuess: posts![index].qualifications,
                                      )));
                            },
                            icon: Icon(Icons.edit),
                            color: Colors.white,
                            iconSize: 18,
                          )),
                      Container(
                          height: 35,
                          width: 35,
                          margin: EdgeInsets.only(left: 70),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: IconButton(
                            onPressed: () {
                              ondelete(posts![index].id);
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.white,
                            iconSize: 18,
                          )),
                    ],
                  )),
                ]),
              );
            }),
      ),
    );
  }
}
