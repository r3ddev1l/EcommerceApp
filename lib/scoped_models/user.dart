import 'package:max_flutter_project/models/user.dart';
import 'package:max_flutter_project/scoped_models/connected_products.dart';

class UserModel extends ConnectedProductsModel {
  void login(String email, String password) {
    authenticatedUser = User(id: '1', email: email, password: password);
  }
}
