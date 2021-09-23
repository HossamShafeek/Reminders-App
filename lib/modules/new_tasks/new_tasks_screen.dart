import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context,) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){

        var cubit = AppCubit.get(context);

        return  Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 8),
                  child: Text(
                    'Tasks',
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
                  itemCount: cubit.newTasks.length,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.fit(1);
                  },
                  itemBuilder: (context,index){
                    return cubit.newTasks.length==0?Center(child: CircularProgressIndicator(),):buildTaskItem(cubit.newTasks[index], context,index);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
