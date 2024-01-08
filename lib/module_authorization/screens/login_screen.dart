import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_em/module_authorization/bloc/login_bloc.dart';
import 'package:test_em/module_services/services_routes.dart';

class LoginScreen extends StatefulWidget {
  final LoginBloc _loginBloc = LoginBloc();
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _LoginFormKey = GlobalKey<FormState>();
late final TextEditingController _LoginEmailController ;
  final TextEditingController _LoginPasswordController =
      TextEditingController();
  String staticEmail = 'mike.hsch@gmail.com';

  @override
  void initState() {
    _LoginEmailController = TextEditingController(text: staticEmail);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _LoginFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
SizedBox(height: 100,),
              Text('Login',
                style: TextStyle(fontSize: 20),
             ),

              SizedBox(height:50,),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(

                    subtitle: SizedBox(
                      child: TextFormField(
                        style: TextStyle(fontSize: 18,
                        height: 1
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: _LoginEmailController,
                        decoration: InputDecoration(
                          isDense: true,
                            contentPadding: EdgeInsets.all(16),
                            border: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2,
                                    style: BorderStyle.solid,
                                    color: Colors.black87)),
                            label: Text('Email',),


                            //S.of(context).name,
                            ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        validator: (result) {
                          if (result!.isEmpty ) {
                            return 'Email Address is Required '; //S.of(context).nameIsRequired;
                          }


                          return null;
                        },
                      ),
                    )),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  subtitle: SizedBox(
                    child: TextFormField(
                      controller: _LoginPasswordController,
                      style: TextStyle(fontSize: 20,
                      height: 1
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                          contentPadding: EdgeInsets.all(16.0),

                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon:
                                 isVisible
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.black87)),
                          label: Text('Password',),

// S.of(context).email,
                          ),
                      obscureText:
                      isVisible
                              ? false
                              : true,

                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (v) => node.unfocus(),
                      // Move focus to next
                      validator: (result) {
                        if (result!.isEmpty) {
                          return '* Password is Required'; //S.of(context).emailAddressIsRequired;
                        }
                        if (result.length < 3) {
                          return '* The password is short, it must be 8 characters long'; //S.of(context).emailAddressIsRequired;
                        }

                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),

              SizedBox(
                height: 50,
              ),
              BlocConsumer<LoginBloc, LoginStates>(
                  bloc: widget._loginBloc,
                  listener: (context, LoginStates state) async {
                    if (state is LoginSuccessState) {

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successflly Login !!!')));
                      Navigator.of(context).pushNamedAndRemoveUntil(ServiceRoutes.SERVICES_SCREEN,(route) => false,);
                    } else if (state is LoginErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error In Login !!!')));

                    }
                  },
                  builder: (context, LoginStates state) {
                    if (state is LoginLoadingState)
                      return Container(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: CircularProgressIndicator(
                            ),
                          ));
                    else
                      return ListTile(
                        title: Container(
                          height: 55,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              ),
                              onPressed: () {
                                if (_LoginFormKey.currentState!.validate()) {
                                  String email =staticEmail;
                                  String password =
                                      _LoginPasswordController.text.trim();
                                  widget._loginBloc.login(email, password);
                                }
                              },
                              child: Text('LOGIN',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700))),
                        ),
                      );
                  }),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateEmailStructure(String value) {
    //     String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-]).{8,}$';
    String pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
