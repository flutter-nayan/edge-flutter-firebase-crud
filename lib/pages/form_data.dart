import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/all_records.dart';

class FormData extends StatefulWidget {
  const FormData({super.key});

  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {

  TextEditingController collectdata = TextEditingController();

  Future<void> saveData()async{
    await FirebaseFirestore.instance.collection('texts').add({
      'name':collectdata.text,
     
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: collectdata,
              decoration: InputDecoration(border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
              )),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: (){
              saveData();
              collectdata.clear();
            }, child:Text("submit")),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            width: double.infinity,
            child: ElevatedButton(onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllRecords()));
            }, child:Text("View Data",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green
            ),),
          )
        ],
      ),
    );
  }
}