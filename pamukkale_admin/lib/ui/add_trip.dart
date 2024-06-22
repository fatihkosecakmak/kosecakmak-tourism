




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_admin/data/entity/trip_model.dart';
import 'package:pamukkale_admin/ui/cubits/add_trip_cubit.dart';
import 'package:pamukkale_admin/ui/trip_detail.dart';

import '../data/entity/bus_model.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({Key? key}) : super(key: key);

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {

  List<BusTypeModel> companies = [
    BusTypeModel(busTypeName: 'jumbo',busTypeImage: "https://firebasestorage.googleapis.com/v0/b/kosecakmakturizm.appspot.com/o/jumbologo5.png?alt=media&token=12df139a-38f2-4ad0-be9b-99a4b2b62f99"),
    BusTypeModel(busTypeName: 'pamukyol',busTypeImage: "https://firebasestorage.googleapis.com/v0/b/kosecakmakturizm.appspot.com/o/pamukyollogo2020-13.png?alt=media&token=b711c3e4-f1e4-435a-b191-3bf07e85c02b"),
  ];
  BusTypeModel? selectedBusType;
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController arrivalTimeController = TextEditingController();
  TextEditingController departureTimeController = TextEditingController();
  TextEditingController arrivalController = TextEditingController();
  TextEditingController departureController = TextEditingController();
  TextEditingController totalSeatsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Otobüs Ekle",style: TextStyle(color: Color(0xffd23b38)),),
        iconTheme: IconThemeData(color: Color(0xffd23b38)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputText(hintText: "200", labelText: "Fiyat", ObscureText : false, controller: priceController,enabled: true),
            InputText(hintText: "gg/a/yyyy", labelText: "Tarih", ObscureText : false, controller: dateController,enabled: true),
            InputText(hintText: "İzmir", labelText: "Kalkış", ObscureText : false, controller: departureController,enabled: true),
            InputText(hintText: "Hakkari", labelText: "Varış", ObscureText: false, controller: arrivalController,enabled: true),
            Padding(
              padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 12.0),
              child: DropdownButtonFormField<BusTypeModel>(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                hint: Text('Otobüs Tipini Seç'),
                value: selectedBusType,
                onChanged: (BusTypeModel? newValue) {
                  setState(() {
                    selectedBusType = newValue!;
                  });
                },
                items: companies.map((BusTypeModel busType) {
                  return DropdownMenuItem<BusTypeModel>(
                    value: busType,
                    child: Text(busType.busTypeName),
                  );
                }).toList(),
              ),

            ),
            InputText(hintText: "25", labelText: "Koltuk Sayısı", ObscureText: false, controller: totalSeatsController,enabled: true,),
            InputText(hintText: "8:35", labelText: "Varış Saati", ObscureText: false, controller: arrivalTimeController,enabled: true),
            InputText(hintText: "15:00", labelText: "Kalkış saati", ObscureText: false, controller: departureTimeController,enabled: true),
            TextButton(
                style: TextButton.styleFrom(minimumSize: const Size(250, 50),backgroundColor: const Color(0xffE30613),shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(2))),
                onPressed: () {
                  context.read<AddTripCubit>().AddTrip(
                      TripModel(
                          arrival: arrivalController.text,
                          departure: departureController.text,
                          arrivalTime: arrivalTimeController.text,
                          departureTime: departureTimeController.text,
                          price: priceController.text,
                          busTypeImage: selectedBusType!.busTypeImage,
                          totalSeats: totalSeatsController.text,
                          busType: selectedBusType!.busTypeName,
                          doc_id: "",
                          date: dateController.text,
                          trip_id:"")).then((value) => Navigator.pop(context));
                }, child: Text("OTOBÜS EKLE",style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}




