


import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class TripDetailState{

}
class TripInitial extends TripDetailState{

}
class TripLoading extends TripDetailState{

}
class TripCompleted extends TripDetailState{
}
class TripDetailCubit extends Cubit<TripDetailState>{
  TripDetailCubit():super(TripInitial());

  final tripsCol = FirebaseFirestore.instance.collection("trips");

  Future<void> updateTravel(String price,String arrivalTime,String departureTime,String doc_id,String date) async{
    var update = HashMap<String,dynamic>();
    update["price"] = price;
    update["arrivalTime"] = arrivalTime;
    update["departureTime"] = departureTime;
    update["date"] = date;
    tripsCol.doc(doc_id).update(update);
  }

}