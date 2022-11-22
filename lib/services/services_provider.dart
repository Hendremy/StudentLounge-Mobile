import 'package:studentlounge_mobile/services/authentication_repository.dart';
import 'package:studentlounge_mobile/services/authentication_storage.dart';

class ServicesProvider {
  AuthenticationRepository get authRepo => UserRepository();
  AuthenticationStorage get authStorage => UserStorage();
}
