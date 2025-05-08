import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typdefs.dart';
import 'package:education_app/src/auth/domain/repositories/auth_reposiroty.dart';

class ForgotPassword extends UsecaseWithParams<void, String> {
  const ForgotPassword(this._reposiroty);

  final AuthReposiroty _reposiroty;

  @override
  ResultFuture<void> call(String params) => _reposiroty.forgotPassword(params);
}
