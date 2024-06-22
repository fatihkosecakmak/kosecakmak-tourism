

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_admin/ui/add_trip.dart';
import 'package:pamukkale_admin/ui/cubits/panel_cubit.dart';
import 'package:pamukkale_admin/ui/trip_detail.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({Key? key}) : super(key: key);

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  @override
  void initState() {
    context.read<PanelCubit>().fetchTrip();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Panel",style: TextStyle(color: Color(0xffd23b38)),),
      ),
      floatingActionButton: IconButton(
          style: IconButton.styleFrom(backgroundColor: Color(0xffd23b38),minimumSize: Size(60,60)),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddTrip(),));
          }, icon: Icon(Icons.add,color: Colors.white,)),
      body: BlocBuilder<PanelCubit,PanelState>(
        builder: (context, state) {
          if(state is PanelInitial){
            return Text("Starting");
          }else if(state is PanelLoading){
            return Center(child: CircularProgressIndicator(),);
          }else if(state is PanelCompleted){
            var trips = state.response;
            return ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TripDetail(trip),));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(trip.departureTime,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold),),
                                  Row(children: [Icon(Icons.access_time_outlined,color: Colors.red,size: 15,),Text(trip.arrivalTime,style: TextStyle(fontSize: 10,color: Colors.red),)],),
                                ],
                              ),
                              Image.network(trip.busTypeImage,height: 30,),
                              Text("${trip.price} TL",style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.bold),),
                              Row(
                                children: [
                                  IconButton(onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => TripDetail(trip)));
                                    print(trip.doc_id);
                                  }, icon: Icon(Icons.edit,color: Colors.black54,size: 20,)),
                                  IconButton(onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Seferi silmek istediğinizden emin misiniz?"),
                                          action: SnackBarAction(label: "Evet", onPressed: () {
                                            context.read<PanelCubit>().deleteTravel(trip.doc_id);
                                          },),));
                                  }, icon: Icon(Icons.delete,color: Colors.black54,size: 20,)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                            color: Colors.grey,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10,),
                              Icon(Icons.double_arrow_outlined,size: 18,color: Colors.white,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
