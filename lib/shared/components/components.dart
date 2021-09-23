
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

Widget buildTaskItem(Map model,context,index){
  return BlocConsumer<AppCubit,AppStates>(
  listener: (context,state){},
  builder: (context,state) {
    AppCubit cubit = AppCubit.get(context);
    return index%2==0?Slidable(
      key: Key(model['id'].toString()),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconSlideAction(
                caption: 'Done',
                foregroundColor: Colors.deepOrange,
                icon: Icons.check_box_outlined,
                onTap: () {
                  cubit.updateDatabase(status: 'done', id: model['id']);
                },
              ),
              SizedBox(height: 8,),
              IconSlideAction(
                  caption: 'Archive',
                  foregroundColor: Colors.deepOrange,
                  icon: Icons.archive_outlined,
                  onTap: () {
                    cubit.updateDatabase(status: 'archived', id: model['id']);
                  }
              ),
            ],
          ),
        )
      ],

      child: InkWell(
        highlightColor: Colors.transparent,
        onLongPress: (){
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text('Delete Task?'),
                content: Text('Are you sure you want to delete this task?'),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: (){
                      cubit.deleteDatabase(id: model['id']);
                      Navigator.pop(context);
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.018,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0,bottom: 11.0),
                  child: Text(
                    '${model['task']}',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.018,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.03,
                    decoration: BoxDecoration(
                      border:Border.all(
                          color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${model['date']}'+',',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height*0.014,
                            ),
                          ),Text(
                            '${model['time']}',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height*0.014,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: cubit.colors[model['colorNumber']],
          ),
        ),
      ),
    ):
    Slidable(
      key: Key(model['id'].toString()),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconSlideAction(
                caption: 'Done',
                foregroundColor: Colors.deepOrange,
                icon: Icons.check_box_outlined,
                onTap: () {
                  cubit.updateDatabase(status: 'done', id: model['id']);
                },
              ),
SizedBox(height: 8,),
              IconSlideAction(
                  caption: 'Archive',
                  foregroundColor: Colors.deepOrange,
                  icon: Icons.archive_outlined,
                  onTap: () {
                    cubit.updateDatabase(status: 'archived', id: model['id']);
                  }
              ),
            ],
          ),
        )
      ],

      child: InkWell(
        highlightColor: Colors.transparent,
        onLongPress: (){
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text('Delete Task?'),
                content: Text('Are you sure you want to delete this task?'),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: (){
                      cubit.deleteDatabase(id: model['id']);
                      Navigator.pop(context);
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.018,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0,bottom: 11.0),
                  child: Text(
                    '${model['task']}',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.018,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.03,
                    decoration: BoxDecoration(
                      border:Border.all(
                          color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${model['date']}'+',',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height*0.014,
                            ),
                          ),Text(
                            '${model['time']}',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height*0.014,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: cubit.colors[model['colorNumber']],
          ),
        ),
      ),
    );
  }
  );
}