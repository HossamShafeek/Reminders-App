import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo/modules/new_tasks/add_tasks_screen.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class HomeLayoutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context,AppStates state){},
      builder: (BuildContext context,AppStates state){

        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            titleSpacing: 15.0,
            backgroundColor: Colors.white,
            centerTitle: false,
            elevation: 1.0,
            title: Text('Reminders',style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height*0.032,),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: IconButton(
                  icon: Icon(Icons.archive_outlined),
                  iconSize: MediaQuery.of(context).size.height*0.036,
                  color: Colors.black,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                    return  ArchivedTasksScreen();
                    }));
                  },
                ),
              ),
            ],
          ),
          body: cubit.bodyScreen[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            autofocus: false,
            child: Icon(Icons.add,color: Colors.deepOrange,
              size: MediaQuery.of(context).size.height*0.036,
            ),
            backgroundColor: Colors.white,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return AddTasksScreen();
              }));
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: cubit.iconList,
            activeIndex: cubit.currentIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.sharpEdge,
            backgroundColor: Colors.white,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            //other params
          ),
        );
      },
    );
  }

}

