import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
        builder: (context,state){

          var cubit = AppCubit.get(context);

          return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_forward_ios_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          body:  Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 8),
                    child: Text(
                      'Archived',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height*0.022,
                      ),
                    ),
                  ),
                  StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    itemCount: cubit.archivedTasks.length,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    staggeredTileBuilder: (index) {
                      return StaggeredTile.fit(1);
                    },
                    itemBuilder: (context,index){
                      return cubit.archivedTasks.length==0?Center(child: CircularProgressIndicator(),):buildTaskItem(cubit.archivedTasks[index], context,index);
                    },
                  ),
                ],
              ),
            ),
          ),
          );
        },
    );
  }
}
