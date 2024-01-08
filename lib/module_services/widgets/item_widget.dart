import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_em/module_services/model/service_model.dart';
import 'package:test_em/module_services/services_routes.dart';

class ItemWidget extends StatelessWidget {
  final ServiceModel model;
  final Function onDeleteTap;
  const ItemWidget({Key? key,required this.model,required this.onDeleteTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ServiceRoutes.SERVICES_DETAIL,arguments: model);
      },
      child: Container(height: 100,width: double.infinity,
        decoration: BoxDecoration(border: Border.all(),            color: Colors.white,
        ),
        margin: EdgeInsets.only(bottom:8),
        child:  Row(
          children: [
            Container(height: double.infinity,width: 120,
              color: Colors.black38,
              child: Image.network(model.imageUrl,errorBuilder: (context, error, stackTrace) =>Icon(Icons.error),),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(model.title),
                Text(model.email),
                Flexible(child: Text(model.description)),
              ],
            ),
            Spacer(),
            IconButton(onPressed: (){
              onDeleteTap();
            }, icon: Icon(Icons.delete,color: Colors.red,))
          ],
        ),

      ),
    );
  }
}
