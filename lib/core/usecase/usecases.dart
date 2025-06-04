
abstract interface class BaseUseCase<SucessType,Params>{
 Future<SucessType> call(Params params);
}
