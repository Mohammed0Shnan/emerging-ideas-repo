import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_em/module_services/model/service_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_em/module_services/model/service_request.dart';
import 'package:test_em/module_services/state_manager/create_service_bloc.dart';
class ServiceDetails extends StatefulWidget {
  const ServiceDetails({Key? key}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
   ServiceModel? modle ;
   final CreateServiceListBloc _bloc = CreateServiceListBloc();
  late final TextEditingController title;
   late final TextEditingController des;
   late final TextEditingController email;
   late String? imagePath;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      modle=  ModalRoute.of(context)!.settings.arguments as ServiceModel;

      title = TextEditingController(text: modle!.title);
      des = TextEditingController(text: modle!.description);
      email = TextEditingController(text: modle!.email);
      imagePath = modle!.imageUrl;
      setState(() {

      });
    });
    super.initState();
  }

   bool iSEditing = false;
   String?  imageGalaryPath;



   initValuses(){
    title.text = modle!.title;
    des.text= modle!.description;
    email.text= modle!.email;
    imagePath = modle!.imageUrl;
    setState(() {
    });
  }




  ///`IMPORTANT FOR UPLOAD IMAGE`
   ///This is the logic for uploading media,
   /// but I do not have an endpoint that receives data of this format
   Future uploadImage() async {
     Dio dio =  Dio(BaseOptions(
       baseUrl:'https://emergingideas.ae/test_apis/',
     ));

     String fileName = imageGalaryPath!.split('/').last;
     FormData formData = FormData.fromMap({
       "img_link": await MultipartFile.fromFile(imageGalaryPath!, filename: fileName),
       "title":title.text,
       "description":des.text,
       "id":modle!.id
     });

     try {
      // Response response = await dio.post('edit.php?email=?mike.hsch@gmail.com', queryParameters: formData);

     } catch (e) {
       print('Error uploading image: $e');

     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions:[
          IconButton(onPressed: (){
            setState(() {
              iSEditing = !iSEditing;
              imageGalaryPath = null;
            });
          },icon:  Icon(iSEditing ? Icons.close: Icons.edit),),
        ]
      ),
      body:modle ==null?
    Center(child: CircularProgressIndicator(),):

    ListView(

    children: [
      GestureDetector(

        onTap:!iSEditing? null:  () async{
          final ImagePicker _picker = ImagePicker();

             _picker.pickImage(source: ImageSource.camera).then((value) {
               imageGalaryPath = value!.path;
               setState(() {
               });
             }).catchError((e){
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error')));
             });
        },
        child: Container(height: 100,width: 120,
          color: Colors.black38,
          child:iSEditing && imageGalaryPath != null? Image.file(File(imageGalaryPath!)): Image.network(modle!.imageUrl,errorBuilder: (context, error, stackTrace) =>Icon(Icons.error),),
        ),
      ),
    TextFormField(
      controller: title,
      enabled: iSEditing,
      decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal:
      8)),
    ),
      TextFormField(
        controller: email,
        enabled: iSEditing,
        decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal:
        8)),
      ),
      TextFormField(
        controller: des,
        enabled: iSEditing,
        decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal:
        8)),

      ),
      const SizedBox(height: 50,),
      if(iSEditing)
      BlocConsumer<CreateServiceListBloc ,CreateServiceListStates>(
        bloc: _bloc,
        listener: (context,state){
          if(state is CreateServiceListErrorState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message.toString())));

            initValuses();
          }
          else if(state is CreateServiceListSuccessState){

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message.toString())));


          }
        },
        builder: (context,state) {
          return GestureDetector(
            onTap: (){
              _bloc.updateService(ServiceRequest( id: modle!.id ,email: email.text.trim(), description: des.text.trim(), title: title.text.trim(), img_link: imagePath!));
            },
            child: Center(
              child: Container(
                alignment: Alignment.center,
                height: 40,width: 100,
              color: Colors.red,
               child: state is CreateServiceListLoadingState ?
                SizedBox(width: 20,height: 20,child: CircularProgressIndicator(),) :
                Text('Save'),
              ),
            )
          );
        }
      )
    ],

    ));
  }
}
