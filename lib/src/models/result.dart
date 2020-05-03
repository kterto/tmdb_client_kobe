import 'package:tmdb_client_kobe/src/models/app_error.dart';

abstract class Result<ResultType> {
  final ResultType data;
  final AppError error;

  Result({
    this.data,
    this.error,
  });

  @override
  String toString() {
    return '''Result {
      data: $data,
      error: $error,
    }''';
  }
}

class Success<Resulttype> implements Result<Resulttype> {
  final Resulttype data;
  final AppError error = null;

  Success({
    this.data,
  });
}

class Failure<Resulttype> implements Result<Resulttype> {
  final Resulttype data = null;
  final AppError error;

  Failure({
    this.error,
  });
}
