import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../1_domain/failures/failures.dart';
import '../../../../1_domain/usecases/advice_usecase.dart';

part 'advicer_state.dart';

const generalFailureMessage='oops something went wrong, please try again later !';
const serverFailureMessage='something went wrong !';
const cacheFailureMessage='an application error occured !';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit({required this.adviceUsecases}) : super(AdvicerInitial());
  final AdviceUsecases adviceUsecases ;

  void adviceRequsted() async {
    emit(AdvicerStateLoading());
    final failureOrAdvice = await adviceUsecases.getAdvice();
    failureOrAdvice.fold(
        (failure) => {emit( AdvicerStateError(message: _mapFailures(failure)))},
        (advice) => {emit(AdvicerStateLoaded(advice: advice.advice))});
    // execute business logic
    // for example get and advice
    // debugPrint('fake get advice triggered');
    // await Future.delayed(const Duration(seconds: 3), () {});
    // debugPrint('got advice');
    // emit(AdvicerStateLoaded(advice: adviceUsecase.advice));
    // emit(AdvicerStateError(message: 'error message'));
  }

  String _mapFailures(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage ;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
