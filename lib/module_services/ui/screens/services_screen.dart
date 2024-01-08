import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_em/module_authorization/authorization_routes.dart';
import 'package:test_em/module_authorization/bloc/login_bloc.dart';
import 'package:test_em/module_authorization/presistance/auth_prefs_helper.dart';
import 'package:test_em/module_services/model/service_model.dart';
import 'package:test_em/module_services/services_routes.dart';
import 'package:test_em/module_services/state_manager/delete_bloc.dart';
import 'package:test_em/module_services/state_manager/services_state_managments.dart';
import 'package:test_em/module_services/widgets/item_widget.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final ServicesListBloc bloc = ServicesListBloc();
  final LoginBloc loginBloc = LoginBloc();
  @override
  void initState() {
    bloc.getServices();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Services'),
      leading: BlocConsumer<LoginBloc,LoginStates>(
          bloc: loginBloc,
        listener: (context,state){
          if(state is LoginSuccessState){
            Navigator.pushNamedAndRemoveUntil(context, AuthorizationRoutes.LOGIN_SCREEN, (route) => false);
          }
        },

        builder: (context,state) {
          if(state is LoginLoadingState){
            return SizedBox(height: 20,width: 20,child: CircularProgressIndicator(),);
          }else{
            return IconButton(onPressed: (){
              loginBloc.logout();
            }, icon: Icon(Icons.logout));
          }

        }
      ),
      actions: [
        IconButton(onPressed: (){
          bloc.getServices();
        }, icon: Icon(Icons.refresh))
      ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, ServiceRoutes.SERVICES_CREATE);
        },
        child: Text('Create'),
      ),
      body: BlocBuilder<ServicesListBloc ,ServicesListStates >(
        bloc: bloc,
        builder: (context, state){
        if(state is ServicesListSuccessState){
          List<ServiceModel> list = state.services;
          return
            BlocProvider(create: (context)=> DeleteServiceListBloc(),
            child:Stack(
              children: [
                RefreshIndicator(
                  onRefresh: ()async{
                    bloc.getServices();
                    return;
                  },
                  child:list.isEmpty? Center(child: Text('No Posts'),): ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index){

                        return ItemWidget(model: list[index],onDeleteTap: (){
                       context.read<DeleteServiceListBloc>().deleteService(list[index].id);
                        }
                          ,);
                      }),
                ),
                BlocConsumer<DeleteServiceListBloc,DeleteServiceListStates>(
                    listener: (context,state){
                      if(state is DeleteServiceListErrorState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                      else if(state is DeleteServiceListSuccessState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!)));

                        bloc.syncronization(state.id);
                      }
                    },
                    builder: (context,state){

                  if(state is DeleteServiceListLoadingState){
                    return Center(child: SizedBox(height: 50,width: 50,child: CircularProgressIndicator(),),);
                  }
                  else return SizedBox.shrink();
                })
              ],
            ) ,
            );

        }else if(state is ServicesListErrorState){
          return Center(child: Text('Error !!!!'),);

        }else{
          return Center(child: SizedBox(height: 40,width: 40,child: CircularProgressIndicator(),),);
        }
      },)
    );
  }
}
