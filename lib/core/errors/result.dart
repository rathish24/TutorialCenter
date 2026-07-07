/// A sealed class representing either a successful value or a failure error.
/// Used in functional-style error handling with Dart 3 switch pattern matching.
sealed class Result<S, F> {
  const Result();
}

/// Represents a successful computation holding a [value] of type [S].
class Success<S, F> extends Result<S, F> {
  final S value;
  const Success(this.value);
}

/// Represents a failed computation holding an [error] of type [F].
class ErrorResult<S, F> extends Result<S, F> {
  final F error;
  const ErrorResult(this.error);
}
