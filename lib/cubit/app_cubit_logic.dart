import 'package:crudflutter/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crudflutter/user.dart';

class AppCubitLogic extends StatelessWidget {
  const AppCubitLogic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
      ),
      body: BlocBuilder<PostsCubic, List<User>?>(builder: (context, posts) {
        if (posts!.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(posts[index].name.toString()),
              ),
            );
          },
        );
      }),
    );
  }
}
