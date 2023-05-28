class NetworkException implements Exception {
  String message;
  int statusCode;

  NetworkException({this.message, this.statusCode});
}

/// Exception which denotes that the user must be instantly logged out
/// and possesses an invalid token
class AuthException extends NetworkException {
  AuthException({
    String message,
    int statusCode,
  }) : super(
          message: message,
          statusCode: statusCode,
        );
}

/// Exception which denotes that the user must be instantly logged out
/// and possesses an invalid token
class InvalidTokenException extends NetworkException {
  InvalidTokenException({
    String message,
    int statusCode,
  }) : super(
          message: message,
          statusCode: statusCode,
        );
}

/// Exception when the API request fails
class APIResponseException extends NetworkException {
  APIResponseException({
    String message,
    int statusCode,
  }) : super(
          message: message,
          statusCode: statusCode,
        );
}
