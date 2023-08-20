import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/const/AppColors.dart';

class ProductDetails extends StatefulWidget {

  var _product;
  ProductDetails(this._product);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  Future addToCart()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('users-cart-items');
    return _collectionRef.doc(currentUser!.email).collection('items').doc().set({
      'name':widget._product['product-name'],
      'price':widget._product['product-price'],
      'img':widget._product['product-img'],
    }).then((value) => Fluttertoast.showToast(msg: 'Added to Cart'));
  }

  Future addToFavourite()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('users-favourite-items');
    return _collectionRef.doc(currentUser!.email).collection('items').doc().set({
      'name':widget._product['product-name'],
      'price':widget._product['product-price'],
      'img':widget._product['product-img'],
    }).then((value) => Fluttertoast.showToast(msg: 'Added to favourite'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.deep_orange,
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back,color: Colors.white,))
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users-favourite-items').doc(FirebaseAuth.instance.currentUser!.email)
                .collection('items').where('name',isEqualTo: widget._product['product-name']).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data==null){
                return Text('');
              }
              return CircleAvatar(
                  backgroundColor: AppColors.deep_orange,
                  child: IconButton(
                      onPressed: ()=> snapshot.data.docs.length==0? addToFavourite():Fluttertoast.showToast(msg: 'Already Added'),
                      icon: snapshot.data.docs.length==0? Icon(Icons.favorite_outline,color: Colors.white,):Icon(Icons.favorite,color: Colors.white,)
                  ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: CarouselSlider(
                  items: widget._product['product-img']
                      .map<Widget>((item) => Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(image: NetworkImage(item),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      )).toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,

                      onPageChanged: (val, carouselPageChangedReason){
                        setState(() {

                        });
                      }
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              // DotsIndicator(
              //   dotsCount: widget._product['product-img'].length == 0 ? 1 :widget._product['product-img'].length,
              //   position: ,
              //   decorator: DotsDecorator(
              //     activeColor: AppColors.deep_orange,
              //     color: AppColors.deep_orange.withOpacity(0.5),
              //     spacing: EdgeInsets.all(2),
              //     activeSize: Size(8, 8),
              //     size: Size(6, 6),
              //   ),
              // ),

              Text(widget._product['product-name'].toString()),
              SizedBox(height: 20.h,),
              Text(widget._product['product-price'].toString()),
              SizedBox(height: 20.h,),
              Text(widget._product['product-description'].toString()),
              SizedBox(
                width: 1.sw,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: ()=> addToCart(),
                  child: Text(
                    'Add to Cart',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.deep_orange,
                      elevation: 3
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
