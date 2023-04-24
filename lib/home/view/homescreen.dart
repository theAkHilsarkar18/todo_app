import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/model/homemodel.dart';
import 'package:todo_app/home/provider/homeprovider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {

    TextEditingController txtTask = TextEditingController(text: "Project");
    TextEditingController txtCat = TextEditingController(text: "Homework");

    TextEditingController editTask = TextEditingController();
    TextEditingController editCat = TextEditingController();

    Homeprovider homeproviderTrue = Provider.of(context,listen: true);
    Homeprovider homeproviderFalse = Provider.of(context,listen: false);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text("Time of Day",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500,letterSpacing: 1)),
                  Spacer(),
                  InkWell(onTap: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: txtCat,
                            ),
                            SizedBox(height: 5,),
                            TextField(
                              controller: txtTask,
                            ),
                            SizedBox(height: 10,),
                            ElevatedButton(onPressed: () {
                              Homemodel h1  = Homemodel(task: txtTask.text,category: txtCat.text);
                              homeproviderTrue.taskList.add(h1);
                              setState(() {

                              });
                              Navigator.pop(context);
                            }, child: Text("Add"),),
                          ],
                        ),
                      );
                    },);

                  },child: Icon(Icons.add,color: Colors.white,size: 30,)),

                ],
              ),
            ),
            Divider(color: Colors.teal,thickness: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("ToDo (${homeproviderTrue.taskList.length})",style: TextStyle(fontSize: 20)),
            ),
            Divider(color: Colors.teal,thickness: 10),
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.black12,
              child: ListView.builder(itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(top: 5,bottom: 5),
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${homeproviderTrue.taskList[index].category}",style: TextStyle(color: Colors.grey.shade400),),
                          SizedBox(height: 10,),
                          Text("${homeproviderTrue.taskList[index].task}",style: TextStyle(color: Colors.black,fontSize: 22),),
                        ],
                      ),
                      Spacer(),
                      InkWell(onTap: () {
                        homeproviderTrue.doneList.add(Homemodel(category: homeproviderTrue.taskList[index].category,task: homeproviderTrue.taskList[index].task));
                        setState(() {

                        });
                      },child: Icon(Icons.done,color: Colors.green,)),
                      SizedBox(width: 20,),
                      InkWell(onTap: () {
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: editCat,
                                  decoration: InputDecoration(
                                    hintText: "${homeproviderTrue.taskList[index].category}",
                                  ),
                                ),
                                SizedBox(height: 5,),
                                TextField(
                                  controller: editTask,
                                  decoration: InputDecoration(
                                      hintText: "${homeproviderTrue.taskList[index].task}",
                                  ),
                                ),
                                SizedBox(height: 20,),
                                ElevatedButton(onPressed: () {
                                  homeproviderTrue.taskList[index].category = editCat.text;
                                  homeproviderTrue.taskList[index].task = editTask.text;
                                  setState(() {

                                  });
                                  Navigator.pop(context);
                                }, child: Text("Edit"))
                              ],
                            ),
                          );
                        },);
                      },child: Icon(Icons.edit,color: Colors.grey.shade400,)),
                      SizedBox(width: 20,),
                      InkWell(onTap: () {
                        homeproviderTrue.taskList.removeAt(index);
                        setState(() {

                        });
                      },child: Icon(Icons.delete,color: Colors.grey.shade400,)),
                      SizedBox(width: 10,),
                    ],
                  ),
                ),
              ) ,
                itemCount: homeproviderTrue.taskList.length,
              ) ,
            ),
            Divider(color: Colors.teal,thickness: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Done (${homeproviderTrue.doneList.length})",style: TextStyle(fontSize: 20)),
            ),
            Divider(color: Colors.teal,thickness: 10),
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.black12,
              child: ListView.builder(itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(top: 5,bottom: 5),
                padding: EdgeInsets.all(10),
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${homeproviderTrue.doneList[index].category}",style: TextStyle(color: Colors.grey.shade400),),
                    SizedBox(height: 10,),
                    Text("${homeproviderTrue.doneList[index].task}",style: TextStyle(color: Colors.black,fontSize: 22),),
                  ],
                )
              ) ,
                itemCount: homeproviderTrue.doneList.length,
              ) ,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(color: Colors.teal),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled,color: Colors.teal,),label: "Home",),
            BottomNavigationBarItem(icon: Icon(Icons.date_range,color: Colors.teal,),label: "Date"),
          ],
        ),
      ),
    );
  }
}
