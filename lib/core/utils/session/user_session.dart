import '../../../features/login/data/models/user_model.dart';

class UserSession {
  UserModel? user;

  void setUser(UserModel? user) {
    this.user = user;
  }
}
