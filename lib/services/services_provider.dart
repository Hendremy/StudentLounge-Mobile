import 'package:studentlounge_mobile/services/authentication_repository.dart';

class ServicesProvider {
  AuthenticationRepository get authRepo => UserRepository();
}
