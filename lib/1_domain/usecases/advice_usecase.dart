import 'package:advisor_app/1_domain/entities/advice_entity.dart';
import 'package:advisor_app/1_domain/failures/failures.dart';
import 'package:advisor_app/1_domain/repository/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceUsecases {
  AdviceUsecases({required this.adviceRepo});

  final AdviceRepo adviceRepo;
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
//space for business logic
    return adviceRepo.getAdviceFromDataSource();

    //call repo to get data (failure or data)
    //proceed with business logic (data manipulation)
    // await  Future.delayed(const Duration(seconds: 3));
    // return  right (const AdviceEntity(advice: 'hey this is advice from entoty', id: 2));// incase of succes
    // return left(GeneralFailure()); //incase of failure
  }
}
