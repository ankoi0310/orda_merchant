class Failure {
  const Failure(this.message);

  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class DuplicateFailure extends Failure {
  const DuplicateFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
