import 'package:advisor_app/0_data/datasources/advice_remote_datasource.dart';
import 'package:advisor_app/0_data/exceptions/exceptions.dart';
import 'package:advisor_app/1_domain/failures/failures.dart';
import 'package:advisor_app/1_domain/entities/advice_entity.dart';
import 'package:advisor_app/1_domain/repository/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceRepoImplemetation extends AdviceRepo {
  AdviceRepoImplemetation({required this.adviceRemoteDataSource});
  final AdviceRemoteDataSource adviceRemoteDataSource ;
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      final result = await adviceRemoteDataSource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
