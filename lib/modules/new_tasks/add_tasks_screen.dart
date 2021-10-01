import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class AddTasksScreen extends StatefulWidget {

  @override
  _AddTasksScreenState createState() => _AddTasksScreenState();
}

class _AddTasksScreenState extends State<AddTasksScreen> {


  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool showFab2 = MediaQuery
        .of(context)
        .viewInsets
        .bottom == 0;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppInsertDatabaseState){
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            automaticallyImplyLeading: false,
            elevation: 1.0,
            backgroundColor: Colors.white,
            centerTitle: false,
            title: Text('New Task', style: TextStyle(
              color: Colors.deepOrange, fontWeight: FontWeight.bold,
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * 0.032,
            ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Text('×',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.038,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * 0.024,
                      ),
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.deepOrange,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title..',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.022,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Title must not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: taskController,
                      style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * 0.018,
                      ),
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      cursorColor: Colors.deepOrange,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write Your Task...',
                        hintStyle: TextStyle(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.018,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Content must not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[200],
                      ),
                      child: TextFormField(
                        onTap: () {
                          showDatePicker(

                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime
                                .now()
                                .year + 2),
                          ).then((value) {
                            if (value != null) {
                              dateController.text =
                                  DateFormat.yMMMd().format(value);
                            }
                          });
                        },
                        readOnly: true,
                        controller: dateController,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * 0.021,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: Icon(FontAwesomeIcons.calendarAlt,
                            color: Colors.black,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * 0.026,
                          ),
                          contentPadding: EdgeInsets.all(15.0),
                          border: InputBorder.none,
                          hintText: 'Date Task',
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.021,
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Date must not be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.07,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[200],
                      ),
                      child: TextFormField(
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            if (value != null) {
                              timeController.text = value.format(context);
                            }
                          });

                        },
                        readOnly: true,
                        controller: timeController,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * 0.021,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.watch_later_outlined,
                            color: Colors.black,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * 0.026,
                          ),
                          contentPadding: EdgeInsets.all(15.0),
                          border: InputBorder.none,
                          hintText: 'Time Task',
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.021,
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Time must not be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Visibility(
            visible: showFab2,
            child: FloatingActionButton(
              child: Icon(Icons.done, color: Colors.deepOrange,
                size: MediaQuery
                    .of(context)
                    .size
                    .height * 0.036,
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                if (formKey.currentState.validate()) {
                  cubit.insertIntoDatabase(title: titleController.text,
                      task: taskController.text,
                      date: dateController.text,
                      time: timeController.text,
                      colorNumber: cubit.colorNumber,
                  ).then((value) {
                    cubit.colorNumber=0;
                  });
                }
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 9.0,
            elevation: 30.0,
            child: Container(
              height: 110,
              width: double.infinity,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: cubit.colors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 11, right: 11, top: 50, bottom: 15),
                    child: InkWell(
                      onTap: (){
                        cubit.changeColorIndex(index);
                      },
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.12,
                        color: cubit.colors[index],
                        child: cubit.colorNumber==index?Icon(Icons.done):null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

