import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_em/module_services/model/service_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_em/module_services/model/service_request.dart';
import 'package:test_em/module_services/state_manager/create_service_bloc.dart';
class CreateService extends StatefulWidget {
  const CreateService({Key? key}) : super(key: key);

  @override
  State<CreateService> createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
   final CreateServiceListBloc _bloc = CreateServiceListBloc();
  late final TextEditingController title;
   late final TextEditingController des;
   late final TextEditingController email;
    String? imagePath;
  @override
  void initState() {

      title = TextEditingController();
      des = TextEditingController();
      email = TextEditingController();

    super.initState();
  }


  ///`IMPORTANT FOR UPLOAD IMAGE`
   ///This is the logic for uploading media,
   /// but I do not have an endpoint that receives data of this format
   Future uploadImage() async {
     Dio dio =  Dio(BaseOptions(
       baseUrl:'https://emergingideas.ae/test_apis/',
     ));

     String fileName = imagePath!.split('/').last;
     FormData formData = FormData.fromMap({
       "img_link": await MultipartFile.fromFile(imagePath!, filename: fileName),
       "title":title.text,
       "description":des.text,

     });

     try {
      // Response response = await dio.post('edit.php?email=?mike.hsch@gmail.com', queryParameters: formData);

     } catch (e) {
       print('Error uploading image: $e');

     }
   }
  final GlobalKey<FormState> form = GlobalKey<FormState>()  ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),

      ),
      body:
    Form(
      key: form,
      child: ListView(

      children: [
        GestureDetector(

          onTap:  () async{
            final ImagePicker _picker = ImagePicker();

               _picker.pickImage(source: ImageSource.camera).then((value) {
                 imagePath = value!.path;
                 setState(() {
                 });
               }).catchError((e){
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error')));
               });
          },
          child: Container(height: 100,width: 120,
            color: Colors.black38,
            child:imagePath == null ? Container(child: Center(child: Text('Select Image')),):Image.file(File(imagePath!)),
          ),
        ),
      Text(imagePath==null? 'image is required':'',),
      SizedBox(height: 30,),
      TextFormField(
        controller: title,
        validator: (v){
          if(v!.isEmpty){
            return 'title is required';
          }
          else{
            return null;
          }
        },
        decoration: InputDecoration(
            label: Text('Title'),
            contentPadding: EdgeInsets.symmetric(horizontal:
        8)),
      ),
        TextFormField(
          controller: email,
          validator: (v){
            if(v!.isEmpty){
              return 'email is required';
            }
            else{
              return null;
            }
          },
          decoration: InputDecoration(
              label: Text('Email'),
              contentPadding: EdgeInsets.symmetric(horizontal:
          8)),
        ),
        TextFormField(
          controller: des,
          validator: (v){
            if(v!.isEmpty){
              return 'title is required';
            }
            else{
              return null;
            }
          },
          decoration: InputDecoration(
              label: Text('Des'),
              contentPadding: EdgeInsets.symmetric(horizontal:
          8)),

        ),
        const SizedBox(height: 50,),
        BlocConsumer<CreateServiceListBloc ,CreateServiceListStates>(
          bloc: _bloc,
          listener: (context,state){
            if(state is CreateServiceListErrorState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message.toString())));

            }
            else if(state is CreateServiceListSuccessState){

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message.toString())));


            }
          },
          builder: (context,state) {
            return GestureDetector(
              onTap: (){
                if(form.currentState!.validate() ){
                  if(imagePath != null) {
                    _bloc.createService(ServiceRequest(id: 0,
                        email: email.text.trim(),
                        description: des.text.trim(),
                        title: title.text.trim(),
                        img_link: imagePath!));
                  }
                }
              },
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 40,width: 100,
                color: Colors.red,
                 child: state is CreateServiceListLoadingState ?
                  SizedBox(width: 20,height: 20,child: CircularProgressIndicator(),) :
                  Text('Create'),
                ),
              )
            );
          }
        )
      ],

      ),
    ));
  }
}
