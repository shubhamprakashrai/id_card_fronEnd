


//Here R stands for the Response we want to send and P stands for the params that is send as arguments
//in the function.....

// core/base/base_use_case/use_case.dart
abstract class UseCase<Type, Params> {
  const UseCase();
  Future<Type?> call({required Params params});
}