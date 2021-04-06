
import 'package:fire_chat_v2/app/data/adapters/repository_adapters.dart';
import 'package:fire_chat_v2/app/data/model/models.dart';
import 'package:fire_chat_v2/app/data/provider/providers.dart';

class UserRepository implements IUserRepository {
  UserRepository({this.provider});
  final IUserProvider? provider;

  @override
  Future<UserModel?> getUsers() async {
    final users = await provider!.getUsers("/summary");
    if (users.status.hasError) {
      return Future.error(users.statusText!);
    } else {
      return users.body;
    }
  }

}