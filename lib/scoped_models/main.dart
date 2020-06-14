import 'package:max_flutter_project/scoped_models/connected_products.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model
    with ConnectedProductsModel, UserModel, ProductsModel {}
