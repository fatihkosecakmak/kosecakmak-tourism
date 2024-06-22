import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_app/ui/cubits/signup_cubit.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController identityIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();

  List<int> days = List<int>.generate(30, (index) => index + 1);
  List<int> years = List<int>.generate(2024 - 1920 + 1, (index) => 1920 + index);
  int _selectedYear = 1920;
  var check1 = false;
  var check2 = false;
  int _selectedDay = 1;
  String _selectedGender = 'Erkek';
  List<String> genders = ['Erkek', 'Kadın'];

  List<String> months = [
    'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
    'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
  ];
  String _selectedMonth = 'Ocak';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("ÜYE FORMU",style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            InputText(labelText: "T.C. Kimlik numaranız", hintText: "T.C. Kimlik", controller: identityIdController,enabled: true, obscureText: false,),
            InputText(labelText: "Adı", hintText: "Adı", controller: nameController,enabled: true, obscureText: false,),
            InputText(labelText: "Soyadı", hintText: "Soyadı", controller: surnameController,enabled: true, obscureText: false,),
            Padding(
              padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Gün Dropdown
                  SizedBox(
                    width: 80,
                    child: DropdownButtonFormField<int>(
                      value: _selectedDay,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                      items: days.map((int day) {
                        return DropdownMenuItem<int>(
                          value: day,
                          child: Text(day.toString()),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedDay = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10), // Araya boşluk eklemek için
                  // Ay Dropdown
                  SizedBox(
                    width: 110,
                    child: DropdownButtonFormField<String>(
                      value: _selectedMonth,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                      items: months.map((String month) {
                        return DropdownMenuItem<String>(
                          value: month,
                          child: Text(month),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedMonth = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10), // Araya boşluk eklemek için
                  // Yıl Dropdown
                  SizedBox(
                    width: 100,
                    child: DropdownButtonFormField<int>(
                      value: _selectedYear,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                      items: years.map((int year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedYear = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 12.0),
              child: DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                items: genders.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
              ),
            ),
            InputText(labelText: "E-posta adresiniz", hintText: "E-posta", controller: emailController,enabled: true,obscureText: false,),
            InputText(labelText: "Cep Telefonu Numaranız", hintText: "Örn: 5xxxxxxxxxx", controller: phoneController,enabled: true,obscureText: false,),
            InputText(labelText: "Şifre", hintText: "Şifre", controller: passwordController,enabled: true,obscureText: true,),
            InputText(labelText: "Şifre Tekrar", hintText: "Şifre tekrar", controller: passwordAgainController,enabled: true,obscureText: true,),
          Row(
            children: [
              Checkbox(value: check1, onChanged: (value) {
                setState(() {
                  check1 = !check1;
                });
                },),
              const Expanded(child: Text("Kişisel verilerinin korunmasına ilişkin aydınlık metnini okudum.")),
            ],
          ),
          Row(
            children: [
              Checkbox(value: check2, onChanged: (value) {
                setState(() {
                  check2 = !check2;
                });
                },),
              const Expanded(child: Text("Önemli kampanyalardan haberdar olmak için KVKK Aydınlatma Metni Rızaya Tabi İşlemleri doğrultusunda Elektronik Ticaretin Düzenlenmesi Kanunu kapsamında elektronik ileti almak istiyorum.",
              maxLines: 2,)),
            ],

                ),
            TextButton(
              onPressed: () {
                dateController.text = "${_selectedDay} / ${_selectedMonth} / ${_selectedYear}";
                context.read<SignUpCubit>().registration(context, emailController.text, passwordController.text, passwordAgainController.text,
                    genderController.text, nameController.text, surnameController.text, dateController.text, phoneController.text, identityIdController.text);
            }, child: const Text("Üye Ol",style: TextStyle(color: Colors.white),),
              style: TextButton.styleFrom(backgroundColor: Color(0xffE30613),minimumSize: const Size(250, 30),shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(2))),),
          ],
    ),
      ),
    );
  }
}

class InputText extends StatelessWidget {
  String labelText;
  String hintText;
  bool enabled;
  bool obscureText;
  TextEditingController controller;
  InputText({required this.labelText,required this.hintText,required this.controller,required this.enabled,required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 12.0),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          obscureText: obscureText,
          enabled: enabled,
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
            label: Text(labelText),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 13),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
      ),
    );
  }

}

