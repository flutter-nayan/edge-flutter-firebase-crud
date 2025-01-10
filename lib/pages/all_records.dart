import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


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
               final id =doc.id;
               
            return ListTile(
              title: Text(content),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){
                  FirebaseFirestore.instance.collection('texts').doc(id).delete();
                  }, icon: Icon(Icons.delete)),
                  IconButton(onPressed: (){
                      editData(context,index,id,content);
                  }, icon: Icon(Icons.edit))
                ],
              ),

            );
          }); 
      })
    );
  }

 void editData(context,index,id,Prevcontent){
  
  TextEditingController editData = TextEditingController(text: Prevcontent);

  showDialog(context: context, 
  builder: (context){
    return AlertDialog(
      title: Text("Edit Data"),
      content: TextField(
        controller: editData,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
          )
        ),
        
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("cancel")),
        ElevatedButton(onPressed: (){
          FirebaseFirestore.instance.collection('texts').doc(id).update({"name":editData.text});
          Navigator.pop(context);
        }, child: Text("Save"))
      ],
    );
  });
 }

}