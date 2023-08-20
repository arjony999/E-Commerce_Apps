import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  TextEditingController ?_nameController;
  TextEditingController ?_phoneController;
  TextEditingController ?_ageController;


  setDataToTextFeild(dat){
    return Column(
      children: [
        TextFormField(
          controller: _nameController = TextEditingController(text: dat['name']),
        ),
        TextFormField(
          controller: _phoneController = TextEditingController(text: dat['phone']),
        ),
        TextFormField(
          controller: _ageController = TextEditingController(text: dat['age']),
        ),

        ElevatedButton(onPressed: ()=>updateData(), child: Text('Update'))
      ],
    );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('users-form-data');
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({

      'name':_nameController!.text,
      'phone':_phoneController!.text,
      'age':_ageController!.text,

    }).then((value) => Fluttertoast.showToast(msg: 'Update Successfully'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users-form-data').doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              var d = snapshot.data;

              if(d == null){
                return Center(child: CircularProgressIndicator(),);
              }

              return setDataToTextFeild(d);
            },
          ),
        ),
      ),
    );
  }
}