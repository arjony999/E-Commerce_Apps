import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  var _inputText = '' ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val){
                  setState(() {
                    _inputText = val;
                    print(_inputText);
                  });
                },
              ),
              Expanded(
                  child: Container(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('products').where('product-name',isEqualTo: _inputText).snapshots(),

                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(snapshot.hasError){
                            return Center(child: Text('Something Wrong'),);
                          }
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Center(child: Text('Loading'),);
                          }
                          return ListView(
                            children: snapshot.data!.docs.map((DocumentSnapshot document){
                              Map<String,dynamic> data = document.data() as Map<String,dynamic>;
                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(data['product-name']),
                                  leading: Image.network(data['product-img'][0]),

                                ),
                              );
                            }).toList(),
                          );
                        }
                    ),
                  ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
