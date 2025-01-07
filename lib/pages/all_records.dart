import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class AllRecords extends StatefulWidget {
  const AllRecords({super.key});

  @override
  State<AllRecords> createState() => _AllRecordsState();
}

class _AllRecordsState extends State<AllRecords> {
  final streamContent = FirebaseFirestore.instance.collection('texts').snapshots();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream:streamContent , builder: (context,snapshot){
        final docs = snapshot.data!.docs;
     
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context,index){
               final doc = docs[index];
               final data = doc.data() as Map;
               final content = data['name'];
            return ListTile(
              title: Text(content),
              trailing: IconButton(onPressed: (){
                print(data);
              }, icon: Icon(Icons.delete)),
            );
          }); 
      })
    );
  }
}