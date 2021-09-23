import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/shared/bloc_observer.dart';
import 'package:todo/shared/cubit/cubit.dart';
void main(){
  Bloc.observer = MyBlocObserver();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: MaterialApp(
        title: 'Reminders',
        debugShowCheckedModeBanner: false,
        home: HomeLayoutScreen(),
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
            ),
          )
        ),
      ),
    );
  }
}
