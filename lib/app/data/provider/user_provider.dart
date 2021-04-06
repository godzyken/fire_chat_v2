import 'package:fire_chat_v2/app/data/model/models.dart';
import 'package:get_server/get_server.dart';

abstract class IUserProvider {
  Future<Response<UserModel>> getUsers(String path);
}

class UserProvider extends GetConnect implements IUserProvider {
  @override
  void onInit() {
    httpClient.defaultDecoder =
        (val) => UserModel.fromJson(val as Map<String, dynamic>);
    httpClient.baseUrl = 'https://api.fire_chat_v2.com';
    super.onInit();
  }

  @override
  Future<Response<UserModel>> getUsers(String path) => get(path);
}
