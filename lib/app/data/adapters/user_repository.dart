
import 'package:fire_chat_v2/app/data/model/models.dart';

abstract class IUserRepository {
  Future<UserModel?> getUsers();
}