

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_admin/ui/panel.dart';
import 'package:pamukkale_admin/ui/trip_detail.dart';

import 'cubits/login_cubit.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var checkbox = false;

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hata'),
          content: Text(errorMessage),
          actions: [
            ElevatedButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffd23b38),
        title: Text(
          "Admin Girişi",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocListener<LoginCubit,LoginState>(
        listener: (context, state) {
          if(state is LoginCompleted){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PanelPage(),));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 80),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: mailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                                hintText: "T.C. KİMLİK NO / E-POSTA",
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                                hintText: "Şifre",
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                  ), ),
                        SizedBox(height: 30),
                        TextButton(style: TextButton.styleFrom(backgroundColor: Color(0xffE30613),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),minimumSize: Size(250, 30)),
                            onPressed: () {
                              context.read<LoginCubit>().login(mailController.text, passwordController.text);
                            }, child: Text("GİRİŞ YAP",style: TextStyle(color: Colors.white),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
