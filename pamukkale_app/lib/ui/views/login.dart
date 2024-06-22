import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_app/ui/cubits/login_cubit.dart';
import 'package:pamukkale_app/ui/views/signup.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var checkbox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ÜYE GİRİŞİ",style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  controller: emailController,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.green,
                        value: checkbox, onChanged: (value) {
                          setState(() {
                           checkbox = !checkbox;
                          });
                      },),
                      Text("Beni Hatırla"),
                    ],
                  ),
                  InkWell(onTap: () {

                  },child: Text("Şifremi Unuttum?")),
                ],
              ),
            ),
            SizedBox(height: 30,),
            TextButton(style: TextButton.styleFrom(backgroundColor: Color(0xffE30613),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),minimumSize: Size(250, 30)),
                onPressed: () {
                  context.read<LoginCubit>().login(emailController.text, passwordController.text, context);
                }, child: Text("GİRİŞ YAP",style: TextStyle(color: Colors.white),)),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Üye değil misin?   "),
                InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                },child: Text(" Hemen üye ol! ",style: TextStyle(fontWeight: FontWeight.bold),)),
              ],
            ),
          ],
        ),
      ),
    );

  }
}
