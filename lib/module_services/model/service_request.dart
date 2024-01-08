

import 'dart:math';

class ServiceRequest{
  late final int id;
  late   String email;
  late  final String description;
  late final String title;
  late final String img_link;
  ServiceRequest({required this.id,required this.email , required this.description,required this.title,required this.img_link });
  Map<String ,dynamic> toJson(){
    Map<String, dynamic> map = {
      'id':this.id,
      'email' : this.email,
      'img_link':this.img_link,
      'description': this.description,
      'title':this.title
    };

    return map;
  }
  Map<String ,dynamic> toCreateJson(){
    Map<String, dynamic> map = {
      'id':Random().nextInt(100000),
      'email' : this.email,
      'img_link':this.img_link,
      'description': this.description,
      'title':this.title
    };

    return map;
  }


}





