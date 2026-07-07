import 'package:tutorial_management/core/network/network_exceptions.dart';

/// Base domain exception model for Clean Architecture.
sealed class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

class ValidationFailure extends Failure {
  final Map<String, dynamic> errors;
  const ValidationFailure(super.message, this.errors);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

/// Mapper that maps lower-layer exceptions into domain [Failure] structures.
class ExceptionMapper {
  static Failure mapToFailure(dynamic exception) {
    if (exception is NetworkException) {
      if (exception.statusCode == 401) {
        return UnauthorizedFailure(exception.message);
      }
      if (exception.statusCode == 422) {
        return ValidationFailure(exception.message, const {});
      }
      if (exception.statusCode != null && exception.statusCode! >= 500) {
        return ServerFailure(exception.message, statusCode: exception.statusCode);
      }
      return NetworkFailure(exception.message);
    }
    return UnknownFailure(exception.toString());
  }
}
