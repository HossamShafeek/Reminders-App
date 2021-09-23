import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bodyScreen = [
    NewTasksScreen(),
    DoneTasksScreen(),
  ];

  List<Color> colors = [
    Colors.lightBlue[100],
    Colors.teal[100],
    Colors.pink[100],
    Colors.amberAccent[100],
    Colors.indigo[100],
    Colors.orange[100],
    Colors.deepPurple[100],
    Colors.lightGreen[200],
  ];

  List<IconData> iconList = [
    Icons.menu,
    Icons.done_all,
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('Database Created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,task TEXT, date TEXT, time TEXT,colorNumber INTEGER, status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('Error When Table Created ${error.toString()}');
      });
    }, onOpen: (database) {
      print('Database Opened');
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  Future insertIntoDatabase({
    @required String title,
    @required String task,
    @required String date,
    @required String time,
    @required int colorNumber,
  }) async {
    return await database.transaction((txn) {
      txn
          .rawInsert(
              'insert into tasks(title,task ,date, time,colorNumber, status) values("$title","$task","$date","$time",$colorNumber,"new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserted New Record ${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('select * from tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateDatabase({
    @required String status,
    @required int id,
  }) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteDatabase({
    @required int id,
  }) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
