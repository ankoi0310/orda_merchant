import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef VoidFuture = ResultFuture<void>;
typedef JsonData = Map<String, dynamic>;
