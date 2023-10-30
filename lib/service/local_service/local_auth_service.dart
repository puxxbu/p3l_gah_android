import 'package:hive/hive.dart';
import 'package:p3l_gah_android/model/customer.dart';

import '../../model/user.dart';

class LocalAuthService {
  late Box<String> _tokenBox;
  late Box<User> _userBox;
  late Box<Customer> _customerBox;

  Future<void> init() async {
    _tokenBox = await Hive.openBox<String>('token');
    _userBox = await Hive.openBox<User>('user');
    _customerBox = await Hive.openBox<Customer>('customer');
  }

  Future<void> addToken({required String token}) async {
    await _tokenBox.put('token', token);
  }

  Future<void> addUser({required User user}) async {
    await _userBox.put('user', user);
  }

  Future<void> addCustomer({required Customer customer}) async {
    await _customerBox.put('customer', customer);
  }

  Future<void> clear() async {
    await _tokenBox.clear();
    await _userBox.clear();
    await _customerBox.clear();
  }

  String? getToken() => _tokenBox.get('token');
  User? getUser() => _userBox.get('user');
  Customer? getCustomer() => _customerBox.get('customer');
}
