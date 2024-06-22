


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_app/ui/cubits/trip_detail_cubit.dart';
import 'package:pamukkale_app/ui/cubits/trips_cubit.dart';

import '../../data/model/seat_model.dart';
import '../../data/model/trip_model.dart';

class TripsDetail extends StatefulWidget {
  TripModel model;

  TripsDetail(this.model, {super.key});

  @override
  State<TripsDetail> createState() => _TripsDetailState();
}

class _TripsDetailState extends State<TripsDetail> {
  List<SeatModel> selectedList = [];

  @override
  void initState() {
    context.read<TripDetailCubit>().getSeats(widget.model.doc_id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Koltuk Seç",style: TextStyle(color: Colors.red),),

      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SeatType(Colors.pink, "KADIN \n DOLU KOLTUK"),
              SeatType(Colors.blue, "ERKEK \n DOLU KOLTUK"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SeatType(Colors.black, "BOŞ KOLTUK \n ALINABİLİR"),
              SeatType(Colors.green, "SEÇİLİ KOLTUK \n SEÇTİKLERİNİZ"),
            ],
          ),

          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Color(0xFFCCCCCC)),
            child: Padding(
              padding: const EdgeInsets.only(right: 32.0,left: 32.0),
              child: Column(
                children: [
                  Image.asset("assets/steering.png",color: Colors.black54 ,width: 80),
                  SizedBox(
                    width: 180,
                    height: 300,
                    child: BlocBuilder<TripDetailCubit,TripDetailState>(builder: (context, state) {
                      if(state is TripDetailInitial){
                        return Text("Loading");
                      }else if(state is TripDetailLoading){
                        return Center(child: CircularProgressIndicator(),);
                      }else if(state is TripDetailCompleted){
                        return GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: state.response.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            var seat = state.response[index];
                            var a = context.read<TripDetailCubit>().isSeatSelected(seat, selectedList);
                            switch(seat.seatStatus){
                              case "empty" :  if(index % 3 == 1){
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0,top: 16.0,right: 3.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if(a){
                                          context.read<TripDetailCubit>().seatRemove(seat, selectedList,widget.model.price);
                                        }else{
                                          context.read<TripDetailCubit>().seatAdd(seat, selectedList,widget.model.price);
                                        }
                                        print(selectedList.toString());
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: a ? Colors.green : Colors.white,borderRadius: BorderRadius.circular(7),border: Border.all(color: Colors.black)),
                                      child: Text((index + 1).toString()),
                                    ),
                                  ),
                                );
                              }
                              else{
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0,top: 16.0,left: 3.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if(a){
                                          context.read<TripDetailCubit>().seatRemove(seat, selectedList,widget.model.price);
                                        }else{
                                          context.read<TripDetailCubit>().seatAdd(seat, selectedList,widget.model.price);
                                        }
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: a ? Colors.green : Colors.white,borderRadius: BorderRadius.circular(7),border: Border.all(color: Colors.black)),
                                      child: Text((index + 1).toString()),
                                    ),
                                  ),
                                );
                              }
                              case "male" :  if(index % 3 == 1){
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0,bottom: 16.0,right: 3.0),
                                  child: Container(

                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7),border: Border.all(color: Colors.black)),
                                    child: Text((index + 1).toString()),
                                  ),
                                );
                              }
                              else{
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0,top: 16.0,left: 3.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7),border: Border.all(color: Colors.black)),

                                    child: Text((index + 1).toString()),
                                  ),
                                );
                              }
                              case "female":  if(index % 3 == 1){
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0,top: 16.0,right: 3.0),
                                  child: Container(

                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.pink,borderRadius: BorderRadius.circular(7),border: Border.all(color: Colors.black)),
                                    child: Text((index + 1).toString()),
                                  ),
                                );
                              }
                              else{
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0,top: 16.0,left: 3.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.pink,borderRadius: BorderRadius.circular(7),border: Border.all(color: Colors.black)),

                                    child: Text((index + 1).toString()),
                                  ),
                                );
                              }
                            }
                          },);
                      }else{
                        return Text("No data");
                      }
                    },
                   ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Toplam:",style: TextStyle(fontSize: 15),),
                    Text("${context.watch<TripDetailCubit>().totalPrice} TL",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 15),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size(double.infinity, 30),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2),),
                        backgroundColor: Color(0xFF5CB85C)) ,

                    onPressed:() {
                    } , child: Text("Bilet Al",style: TextStyle(color: Colors.white),)),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SeatType extends StatelessWidget {
  Color color;
  String text;

  SeatType(this.color, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.chair_outlined,color: color,),
        Text(text,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
      ],
    );
  }
}
