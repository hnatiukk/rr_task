import 'package:injectable/injectable.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class AuthCheckUseCase {
  final AuthRepository repository;

  AuthCheckUseCase(this.repository);

  Future<User> execute() async {
    return await repository.getUser();
  }
}
