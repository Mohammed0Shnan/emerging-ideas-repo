
class ServiceModel{
  late final int id ;
  late final String email;
  late final String title;
  late final String description;
  late final String imageUrl;
  ServiceModel({required this.id, required this.title ,required this.description,
  required this.imageUrl,required this.email
  });

 factory ServiceModel.fromMap(Map<String, dynamic> element){
    return ServiceModel(id: element['id'], title:  element['title']??'',
        description: element['description']??'', imageUrl:  element['img_link']??'',
        email:  element['email']??'');
  }



}



