


import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/trip_model.dart';

class AddTripCubit extends Cubit<void>{
  AddTripCubit():super(0);
  final collectionTrip = FirebaseFirestore.instance.collection("trips");

  Future<void> AddTrip(TripModel model) async {
    if (model.price == 0 ||
        model.departureTime.isEmpty ||
        model.arrivalTime.isEmpty ||
        model.departure.isEmpty ||
        model.arrival.isEmpty ||
        model.busType.isEmpty ||
        model.totalSeats == 0 ||
        model.date.isEmpty) {
      print('Boş alan!');
    }

    var add = HashMap<String, dynamic>();
    add["price"] = model.price;
    add["departureTime"] = model.departureTime;
    add["arrivalTime"] = model.arrivalTime;
    add["departure"] = model.departure;
    add["arrival"] = model.arrival;
    add["busType"] = model.busType;
    add["busTypeImage"] = model.busTypeImage;
    add["totalSeats"] = model.totalSeats;
    add["date"] = model.date;
    add["doc_id"] = "";

    DocumentReference docRef = await collectionTrip.add(add);

    String docId = docRef.id;

    await docRef.update({"docId": docId});

    CollectionReference seatsCollection = docRef.collection('seats');

    var seats = int.parse(model.totalSeats);
    for (int i = 1; i <= seats; i++) {
      await seatsCollection.add({
        "seatNumber": i,
        "status": "available",
      });
    }
  }
}