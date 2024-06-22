
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_app/ui/views/trips_detail.dart';
import '../cubits/trips_cubit.dart';

class TripListWidget extends StatefulWidget {
  final String departure;
  final String arrival;
  final String date;

  TripListWidget({required this.departure, required this.arrival,required this.date});

  @override
  _TripListWidgetState createState() => _TripListWidgetState();
}

class _TripListWidgetState extends State<TripListWidget> {
  String? selectedTripID;
  var isSelected = false;
  TextEditingController tf = TextEditingController();
  @override
  void initState() {
    context.read<TripCubit>().fetchTrips(widget.departure, widget.arrival, widget.date);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.departure} -> ${widget.arrival}',style: TextStyle(fontSize: 15),),
        actions: [
          PopupMenuButton(
            offset: const Offset(0, 50),
            constraints: const BoxConstraints(minWidth: double.infinity),
            icon: Icon(Icons.menu),
            itemBuilder: (context) => <PopupMenuEntry<String>>[
               PopupMenuItem(
                 onTap: () {
                   context.read<TripCubit>().sortByAscPrice(widget.departure, widget.arrival,widget.date );
                 },
                 child: Row(
                children: [
                  Icon(Icons.attach_money),
                  SizedBox(width: 5,),
                  Text("Fiyata göre artan",),
                ],
              ),

              ),
               PopupMenuItem(
                 onTap: () {
                   context.read<TripCubit>().sortByDescPrice(widget.departure, widget.arrival,widget.date);

                 },
                 child: Row(
                children: [
                  Icon(Icons.attach_money),
                  SizedBox(width: 5,),
                  Text("Fiyata göre azalan",),
                ],
              ),
              ),
              PopupMenuItem(
                onTap: () {
                  context.read<TripCubit>().sortByAscDate(widget.departure, widget.arrival, widget.date);
                },
                child: Row(
                  children: [
                    Icon(Icons.access_time_outlined),
                    SizedBox(width: 5,),
                    Text("Saate göre artan"),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  context.read<TripCubit>().sortByDescDate(widget.departure, widget.arrival,widget.date);
                },
                child: Row(
                  children: [
                    Icon(Icons.access_time_outlined),
                    SizedBox(width: 5,),
                    Text("Saate göre azalan"),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: BlocBuilder<TripCubit, TripState>(
              builder: (context, state) {
                  if (state is TripLoaded) {
                  var trips = state.response;
                  return ListView.builder(
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TripsDetail(trip),));
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                    Text("${trip.price} TL",style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.bold),)
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
                }else if (state is TripError) {
                  return Center(child: Text(state.message));
                }else{
                    return Container();
                  }
              },
            ),
          ),
        ],
      ),
    );
  }
}
