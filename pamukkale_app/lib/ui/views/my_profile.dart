import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_app/data/model/user_model.dart';
import 'package:pamukkale_app/ui/cubits/my_profile_cubit.dart';
import 'package:pamukkale_app/ui/views/home.dart';
import 'package:pamukkale_app/ui/views/signup.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  int _selectedDay = 1;
  List<int> days = List<int>.generate(30, (index) => index + 1);
  List<int> years = List<int>.generate(2024 - 1920 + 1, (index) => 1920 + index);
  String _selectedGender = 'Erkek';
  List<String> genders = ['Erkek', 'Kadın'];
  int _selectedYear = 2000;

  List<String> months = [
    'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
    'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
  ];
  String _selectedMonth = 'Ocak';
  TextEditingController identityIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();



  @override
  void initState() {
    context.read<MyProfileCubit>().getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE30613),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Üye Bilgilerim",style: TextStyle(color: Colors.white),),
      ),
      body: BlocBuilder<MyProfileCubit,UserState>(
        builder: (context, state) {
          if(state is UserInitial){
            return Container();
          } else if(state is UserCompleted){
            var user = state.user;
            nameController.text = user.user_name;
            surnameController.text = user.user_surname;
            phoneController.text = user.user_phone;
            return Column(
              children: [
                SizedBox(height: 20,),
                InputText(labelText: "T.C. Kimlik Numaranız", hintText: user.user_id, controller: identityIdController,enabled: false, obscureText: false,),
                InputText(labelText: "Cep Telefonu Numaranız", hintText: user.user_phone, controller: phoneController,enabled:true, obscureText: false,),
                InputText(labelText: "Ad", hintText: user.user_name, controller: nameController,enabled: true, obscureText: false,),
                InputText(labelText: "Soyad", hintText: user.user_surname, controller: surnameController,enabled: true, obscureText: false,),
                InputText(labelText: "E-Posta Adresiniz", hintText: user.email, controller: identityIdController,enabled: false, obscureText: false,),
                InputText(labelText: "Doğum Tarihi", hintText: user.user_date, controller: identityIdController,enabled: false, obscureText: false,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(backgroundColor: Color(0xffE30613),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
                        onPressed: () {

                        }, child: Text("Şifre Değiştir",style: TextStyle(color: Colors.white))),
                    TextButton(
                        style: TextButton.styleFrom(backgroundColor: Color(0xffE30613),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Üyeliğinizi silmek istiyor musunuz?"),action: SnackBarAction(label: "Evet", onPressed: () {
                            context.read<MyProfileCubit>().deleteAccount(context);
                          },),));
                        }, child: Text("Üyeliğimi Sil",style: TextStyle(color: Colors.white),)),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextButton(
                      style: TextButton.styleFrom(minimumSize: Size(350, 50),backgroundColor: Color(0xffE30613),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
                      onPressed: () {
                        context.read<MyProfileCubit>().updateUserInfo(nameController.text, surnameController.text, phoneController.text).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),)));
                      }, child: Text("Kaydet",style: TextStyle(color: Colors.white),)),
                ),

              ],
            );
          }else{
            return Container();
          }
        },

      ),
    );
  }
}
