import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/const/AppColors.dart';
import 'package:project/ui/bottom-nav-controller.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  List<String> gender = ['Male','Female','Custom'];

  Future<void> _selectedDateFromPicker(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year),
        firstDate: DateTime(DateTime.now().month - 30),
        lastDate: DateTime(DateTime.now().year + 7),
    );
    if(picked != null)
      setState(() {
        _dobController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
  }

  sendUserDataToDB()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;


    CollectionReference _collectionref = await FirebaseFirestore.instance.collection('users-form-data');
    return _collectionref.doc(currentUser!.email).set({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'dob': _dobController.text,
      'gender': _genderController.text,
      'age': _ageController.text,
    }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavController()
    ))).catchError((error)=>print('Please Check again'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h,),
                Text(
                  "Submit the form to continue.",
                  style:
                  TextStyle(fontSize: 22.sp, color: AppColors.deep_orange),
                ),
                Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                // myTextField("enter your name",TextInputType.text,_nameController),
                // myTextField("enter your phone number",TextInputType.number,_phoneController),

                TextField(
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: 'Enter your name',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.deep_orange,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
                SizedBox(height: 10.h,),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _phoneController,
                  decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.deep_orange,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
                SizedBox(height: 10.h,),
                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'Date of birth',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        iconSize: 30,
                          onPressed: () => _selectedDateFromPicker(context),
                          icon: Icon(Icons.calendar_today_outlined),
                      ),
                    ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.deep_orange,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
                SizedBox(height: 10.h,),
                TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'Choose your gender',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: DropdownButton<String>(
                        iconSize: 40,
                          items: gender.map((String value){
                            return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                            onTap: (){
                                  setState(() {
                                    _genderController.text = value;
                                  });
                            },
                            );
                          }).toList(),
                          onChanged: (_){},
                      ),
                    ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.deep_orange,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
                SizedBox(height: 10.h,),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  decoration: InputDecoration(
                      hintText: 'Enter your age',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.deep_orange,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
                SizedBox(height: 50.h,),
                SizedBox(
                  width: 1.sw,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      sendUserDataToDB();
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white, fontSize: 18.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.deep_orange,
                      elevation: 3,
                    ),
                  ),
                ),
                // elevated button
                // customButton("Continue",()=>sendUserDataToDB()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}