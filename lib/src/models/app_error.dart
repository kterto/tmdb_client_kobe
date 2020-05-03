const GENERIC_FETCH_ERROR =
    "Falha ao requisitar algumas informações. Sentimos muito. Tente novamente mais tarde.";
const MEASUREMENT_CREATION_ERROR =
    "Falha ao registrar a medição. Sentimos muito! Tente novamente mais tarde.";

abstract class AppError {
  final String message;

  AppError({
    this.message,
  });

  @override
  String toString() {
    return '''AppError {
              message: $message,
            }''';
  }

  static AppError fromStatusCode(int code, {String message}) {
    switch (code) {
      case 400:
        return BadRequestError(message: message);
        break;
      case 401:
        return UnauthorizedError(message: message);
        break;
      case 403:
        return ForbiddenError(message: message);
        break;
      case 404:
        return NotFoundError(message: message);
        break;
      case 406:
        return UnacceptableError(message: message);
        break;
      case 500:
        return ServerError(message: message);
        break;
      default:
        return UnknownError(message: message);
        break;
    }
  }
}

class BadRequestError implements AppError {
  final String message;

  BadRequestError({
    this.message,
  });
}

class UnauthorizedError implements AppError {
  final String message;

  UnauthorizedError({
    this.message,
  });
}

class ForbiddenError implements AppError {
  final String message;

  ForbiddenError({
    this.message,
  });
}

class NotFoundError implements AppError {
  final String message;

  NotFoundError({
    this.message,
  });
}

class UnacceptableError implements AppError {
  final String message;

  UnacceptableError({
    this.message,
  });
}

class ServerError implements AppError {
  final String message;

  ServerError({
    this.message,
  });
}

class UnknownError implements AppError {
  final String message;

  UnknownError({
    this.message,
  });
}

class ParseError implements AppError {
  final String message;

  ParseError({this.message});
}

class StorageError implements AppError {
  final String message;

  StorageError({this.message});
}
