import 'package:fpdart/fpdart.dart';
import 'package:id_card_front_end/core/network/failure.dart';

abstract interface class CommonUseCase<SucessType,Params>{
 Future<Either<Failure,SucessType>> call(Params params);
}
