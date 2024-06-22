import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_admin/data/entity/trip_model.dart';

import 'cubits/trip_detail_cubit.dart';

class TripDetail extends StatefulWidget {
  TripModel response;

  TripDetail(this.response, {super.key});
  @override
  State<TripDetail> createState() => _TripDetailState();
}

class _TripDetailState extends State<TripDetail> {
  TextEditingController priceController = TextEditingController();
  TextEditingController departureTimeController = TextEditingController();
  TextEditingController arrivalTimeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Sefer Düzenle",style: TextStyle(color: Color(0xffd23b38)),),iconTheme: IconThemeData(color: Color(0xffd23b38)),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("${widget.response.departure} -> ${widget.response.arrival}"),
              ),
              SizedBox(height: 30,),
              InputText(hintText: widget.response.price, labelText: "fiyat",controller: priceController,enabled: true,ObscureText: false),
              InputText(hintText: widget.response.departureTime, labelText: "kalkış saati",controller: departureTimeController,enabled: true,ObscureText: false),
              InputText(hintText: widget.response.arrivalTime, labelText: "tahmini varış",controller: arrivalTimeController,enabled: true,ObscureText: false),
              InputText(hintText: widget.response.date, labelText: "tarih",controller: dateController,enabled: true,ObscureText: false),

              TextButton(
                  style: TextButton.styleFrom(minimumSize: const Size(250, 50),backgroundColor: const Color(0xffE30613),shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(2))),
                  onPressed:() {
                    context.read<TripDetailCubit>().updateTravel(priceController.text, arrivalTimeController.text, departureTimeController.text, widget.response.doc_id, dateController.text).then((value) => Navigator.pop(context));
                  }, child: Text("KAYDET",style: TextStyle(color: Colors.white),))
            ],
          ),
        ),
      ),
    );
  }
}

class InputText extends StatelessWidget {
  bool ObscureText;
  String labelText;
  String hintText;
  bool enabled;
  TextEditingController controller;
  InputText({required this.labelText,required this.hintText,required this.controller,required this.enabled,required this.ObscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 12.0),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          obscureText: ObscureText,
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
