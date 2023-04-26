import 'package:bloc/bloc.dart';
import 'package:crudflutter/remote_server.dart';
import 'package:crudflutter/user.dart';

class PostsCubic extends Cubit<List<User>?> {
  final _dataService = RemoteServer();

  PostsCubic() : super([]);

  void getPosts() async => emit(await _dataService.getPosts());
}
