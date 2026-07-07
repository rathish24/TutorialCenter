import 'package:firebase_core/firebase_core.dart';
import 'package:tutorial_management/core/network/network_exceptions.dart';

/// Maps FirebaseException codes into custom NetworkException classes.
class FirebaseExceptionMapper {
  static Exception mapToException(FirebaseException exception) {
    String message = 'A database error occurred.';
    int statusCode = 500;

    switch (exception.code) {
      case 'permission-denied':
        message = 'Access Denied: You do not have permission to access this resource.';
        statusCode = 403;
        break;
      case 'unauthenticated':
        message = 'Authentication required. Please log in.';
        statusCode = 401;
        break;
      case 'not-found':
        message = 'The requested document was not found.';
        statusCode = 404;
        break;
      case 'already-exists':
        message = 'The document already exists.';
        statusCode = 409;
        break;
      case 'unavailable':
        message = 'The database service is temporarily unavailable. Retrying...';
        statusCode = 503;
        break;
      default:
        message = exception.message ?? 'Unknown Firebase exception: ${exception.code}';
    }

    return NetworkException(message, statusCode: statusCode, originalError: exception);
  }
}
