import 'package:advisor_app/2_application/core/services/theme_service.dart';

import 'package:advisor_app/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:advisor_app/2_application/pages/advice/widgets/advice_field.dart';
import 'package:advisor_app/2_application/pages/advice/widgets/custom_button.dart';
import 'package:advisor_app/2_application/pages/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../injection.dart';

class AdvicerPageWrapperProvider extends StatelessWidget {
  const AdvicerPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // create: (context) => AdvicerBloc(), //bloc
        create: (context) =>sl<AdvicerCubit>(), //cubit
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Advicer',
          style: themeData.textTheme.displayLarge,
        ),
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (value) {
              Provider.of<ThemeService>(context, listen: false).toggleTheme();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          children: [
            Expanded(
              child: Center(child: BlocBuilder<AdvicerCubit, AdvicerCubitState>( //cubit
                // child: Center(child: BlocBuilder<AdvicerBloc, AdvicerState>(  //bloc
              builder: (context, state) {
                if (state is AdvicerInitial) {
                  return const AdviceFeild(
                      advice: 'Your advice is waiting for you');
                } else if (state is AdvicerStateLoading) {
                  return CircularProgressIndicator(
                    color: themeData.colorScheme.secondary,
                  );
                } else if (state is AdvicerStateLoaded) {
                  return AdviceFeild(advice: state.advice);
                } else if (state is AdvicerStateError) {
                  return ErrorMessage(message: state.message);
                } else {
                  return const ErrorMessage(
                      message: 'Oops! Something went wrong !');
                }
              },
            ))),
            const SizedBox(
              height: 200,
              child: Center(child: CustomButton()),
            )
          ],
        ),
      ),
    );
  }
}
