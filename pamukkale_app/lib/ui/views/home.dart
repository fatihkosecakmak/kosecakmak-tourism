

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_app/ui/cubits/home_cubit.dart';
import 'package:pamukkale_app/ui/views/login.dart';
import 'package:pamukkale_app/ui/views/my_profile.dart';
import 'package:pamukkale_app/ui/views/trips.dart';


class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> cities = [
    'Adana', 'Adıyaman', 'Afyonkarahisar', 'Ağrı', 'Amasya', 'Ankara', 'Antalya', 'Artvin', 'Aydın', 'Balıkesir',
    'Bilecik', 'Bingöl', 'Bitlis', 'Bolu', 'Burdur', 'Bursa', 'Çanakkale', 'Çankırı', 'Çorum', 'Denizli',
    'Diyarbakır', 'Edirne', 'Elazığ', 'Erzincan', 'Erzurum', 'Eskişehir', 'Gaziantep', 'Giresun', 'Gümüşhane',
    'Hakkari', 'Hatay', 'Isparta', 'Mersin', 'İstanbul', 'İzmir', 'Kars', 'Kastamonu', 'Kayseri', 'Kırklareli',
    'Kırşehir', 'Kocaeli', 'Konya', 'Kütahya', 'Malatya', 'Manisa', 'Kahramanmaraş', 'Mardin', 'Muğla', 'Muş',
    'Nevşehir', 'Niğde', 'Ordu', 'Rize', 'Sakarya', 'Samsun', 'Siirt', 'Sinop', 'Sivas', 'Tekirdağ', 'Tokat',
    'Trabzon', 'Tunceli', 'Şanlıurfa', 'Uşak', 'Van', 'Yozgat', 'Zonguldak', 'Aksaray', 'Bayburt', 'Karaman',
    'Kırıkkale', 'Batman', 'Şırnak', 'Bartın', 'Ardahan', 'Iğdır', 'Yalova', 'Karabük', 'Kilis', 'Osmaniye',
    'Düzce'
  ];
  List<String> cities2 = [
    'Adana', 'Adıyaman', 'Afyonkarahisar', 'Ağrı', 'Amasya', 'Ankara', 'Antalya', 'Artvin', 'Aydın', 'Balıkesir',
    'Bilecik', 'Bingöl', 'Bitlis', 'Bolu', 'Burdur', 'Bursa', 'Çanakkale', 'Çankırı', 'Çorum', 'Denizli',
    'Diyarbakır', 'Edirne', 'Elazığ', 'Erzincan', 'Erzurum', 'Eskişehir', 'Gaziantep', 'Giresun', 'Gümüşhane',
    'Hakkari', 'Hatay', 'Isparta', 'Mersin', 'İstanbul', 'İzmir', 'Kars', 'Kastamonu', 'Kayseri', 'Kırklareli',
    'Kırşehir', 'Kocaeli', 'Konya', 'Kütahya', 'Malatya', 'Manisa', 'Kahramanmaraş', 'Mardin', 'Muğla', 'Muş',
    'Nevşehir', 'Niğde', 'Ordu', 'Rize', 'Sakarya', 'Samsun', 'Siirt', 'Sinop', 'Sivas', 'Tekirdağ', 'Tokat',
    'Trabzon', 'Tunceli', 'Şanlıurfa', 'Uşak', 'Van', 'Yozgat', 'Zonguldak', 'Aksaray', 'Bayburt', 'Karaman',
    'Kırıkkale', 'Batman', 'Şırnak', 'Bartın', 'Ardahan', 'Iğdır', 'Yalova', 'Karabük', 'Kilis', 'Osmaniye',
    'Düzce'
  ];
  var oneway = true;
  var roundTrip = false;
  var today = true;
  var tomorrow = true;
  var departureCity = "";
  var arrivalCity = "";
  var selectedDate = "";
  DateTime ? date;
  @override
  void initState() {
    context.read<HomeCubit>().userCheckStatus(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeCubit,bool>(
      builder: (context, isLogin){
        return Scaffold(
          appBar: AppBar(
            title: Image.asset("assets/logo.png",height: 35),
            backgroundColor: Colors.white,
            actions:  [
              isLogin ? _profile(isLogin) : IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
              }, icon: Icon(Icons.person)),
              _menu(),
            ],
          ),
          backgroundColor: const Color(0xffE30613),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(backgroundColor: oneway ? const Color(0xffE30613) : Colors.grey,shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(7)),minimumSize: const Size(150, 30)),
                              onPressed: () {
                                setState(() {
                                  roundTrip = !roundTrip;
                                  oneway = !oneway;
                                });

                              }, child: const Text("Tek Yön",style: TextStyle(color: Colors.white),)),

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Kalkış',
                            hintText: 'KALKIŞ NOKTASI SEÇİNİZ',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          ),
                          items: cities.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            departureCity = newValue.toString();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Varış',
                            hintText: 'VARIŞ NOKTASI SEÇİNİZ',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          ),
                          items: cities2.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              arrivalCity = newValue.toString();
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 250,
                              child: Column(
                                children: [
                                  const Row(

                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text("Gidiş Tarihi"),
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0,left: 16.0),
                                    child: Container(
                                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
                                      child: Row(
                                        children: [
                                          InkWell(onTap: () {
                                            showDatePicker(context: context, initialDate: DateTime.now() , firstDate: DateTime.now(), lastDate: DateTime(2025)).then(((value) {
                                              selectedDate = "${value!.day}/${value!.month}/${value!.year}";
                                              setState(() {
                                              });
                                            }));
                                          },child:  Text(selectedDate == "" ? "TARİHİ SEÇİNİZ" : selectedDate)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                TextButton(
                                    style: TextButton.styleFrom(backgroundColor: today ? const Color(0xffE30613) : Colors.grey,shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(5))),
                                    onPressed: () {
                                      setState(() {
                                        today = !today;
                                        tomorrow = !tomorrow;
                                        date = DateTime.now();
                                        selectedDate = "${date!.day}/${date!.month}/${date!.year}";
                                      });
                                    }, child: const Text("Bugün",style: TextStyle(color: Colors.white),)),
                                TextButton(
                                    style: TextButton.styleFrom(backgroundColor: tomorrow ? Colors.grey : const Color(0xffE30613),shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(5))),
                                    onPressed: () {
                                      setState(() {
                                        today = !today;
                                        tomorrow = !tomorrow;
                                        date = DateTime.now().add(Duration(days: 1));
                                        selectedDate = "${date!.day}/${date!.month}/${date!.year}";
                                      });
                                    }, child: const Text("Yarın",style: TextStyle(color: Colors.white),)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(minimumSize: const Size(250, 50),backgroundColor: const Color(0xffE30613),shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(2))),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TripListWidget(departure :departureCity,arrival: arrivalCity,date: selectedDate),));
                          }, child: const Text("SEFER SORGULA",style: TextStyle(color: Colors.white),)),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
              )
            ],
          ),

        );

      },

    );
  }
}


class _profile extends StatelessWidget {
  bool isLogin;
  _profile(this.isLogin);

  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton(
      offset: const Offset(0, 50),
      constraints: const BoxConstraints(minWidth: double.infinity),
      icon: const Icon(Icons.person),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
         PopupMenuItem(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile(),));
          },
          child: Row(
        children: [
          Icon(Icons.person,color: Colors.red,),
          SizedBox(width: 5,),

          Text("Üye Bilgilerim",style: TextStyle(color: Colors.red),),
            ],
          ),
       ),
        const PopupMenuItem(child: Row(
          children: [
            Icon(Icons.save),
            SizedBox(width: 5,),
            Text("Kayıtlı Yolcularım",),
           ],
          ),
        ),
        const PopupMenuItem(child: Row(
          children: [
            Icon(Icons.airplane_ticket),
            SizedBox(width: 5,),
            Text("Biletlerim",),
          ],
        ),
        ),
         PopupMenuItem(
           onTap: () {
             context.read<HomeCubit>().signOut(context);
           },
           child: Row(
            children: [
              Icon(Icons.power_settings_new),
              SizedBox(width: 5,),
              Text("Çıkış"),
            ],
        ),
        ),

      ],);
  }
}


class _menu extends StatelessWidget {
  const _menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 50),
      constraints: const BoxConstraints(minWidth: double.infinity),
      icon: const Icon(Icons.menu),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
      PopupMenuItem(
          onTap: () {
          },child: const Text("OTOBÜS BİLETİ")),
      PopupMenuItem(
          onTap: () {

          },child: const Text("BİLET İŞLEMLERİ")),
      PopupMenuItem(
          onTap: () {

          },child: const Text("SEYEHAT KILAVUZU")),
      PopupMenuItem(
          onTap: () {

          },child: const Text("AÇIK BİLET SATIN AL")),
      PopupMenuItem(
          onTap: () {

          },child: const Text("YOLCUM NEREDE")),
      PopupMenuItem(
          onTap: () {

          },child: const Text("KURUMSAL")),
      PopupMenuItem(
          onTap: () {

          },child: const Text("BLOG")),
      PopupMenuItem(
          onTap: () {

          },child: const Text("İLETİŞİM")),
    ],);
  }
}
