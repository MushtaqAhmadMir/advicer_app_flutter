


import 'package:advisor_app/0_data/datasources/advice_remote_datasource.dart';
import 'package:advisor_app/0_data/repositories/advice_repo_impl.dart';
import 'package:advisor_app/1_domain/repository/advice_repo.dart';
import 'package:advisor_app/1_domain/usecases/advice_usecase.dart';
import 'package:advisor_app/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
final sl=GetIt.asNewInstance(); //service locator

 Future<void> init()async{


  //!application layer
  //factory = everytime a new/fresh instance of that class
  sl.registerFactory(() => AdvicerCubit(adviceUsecases: sl()));


  //!domain layer
  sl.registerFactory(() => AdviceUsecases(adviceRepo: sl()));
  

  //!data layer
  sl.registerFactory<AdviceRepo>(() => AdviceRepoImplemetation(adviceRemoteDataSource: sl()));
  sl.registerFactory<AdviceRemoteDataSource>(() => AdviceRemoteDataSourceImpl(client: sl()));


  //! externs

  sl.registerFactory(() => http.Client());

}