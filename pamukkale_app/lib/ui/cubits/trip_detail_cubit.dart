


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/seat_model.dart';

abstract class TripDetailState{

}
class TripDetailInitial extends TripDetailState{

}
class TripDetailLoading extends TripDetailState{

}
class TripDetailCompleted extends TripDetailState{
  List<SeatModel> response;
  TripDetailCompleted(this.response);
}

class TripDetailCubit extends Cubit<TripDetailState>{
  TripDetailCubit():super(TripDetailInitial());


  final tripCollection = FirebaseFirestore.instance.collection("trips");
  var totalPrice = 0;

  void seatRemove(SeatModel seat,List<SeatModel> selectedSeats,String seatPrice){
    selectedSeats.remove(seat);
    totalPrice = totalPrice - int.parse(seatPrice);
  }
  Future<void> getSeats(String docId) async {
    final query = tripCollection.doc(docId).collection("seats");
    query.snapshots().listen((event) {
      List<SeatModel> seatList = [];
      var docs = event.docs;
      for(var doc in docs){
        var data = doc.data();
        var key = doc.id;
        var seat = SeatModel.fromJson(data, key);
        seatList.add(seat);
      }
      emit(TripDetailCompleted(seatList));
    });
  }
  void seatAdd(SeatModel seat,List<SeatModel> selectedSeats,String seatPrice){
    selectedSeats.add(seat);
    totalPrice = totalPrice + int.parse(seatPrice);
  }

  bool isSeatSelected(SeatModel seat,List<SeatModel> selectedSeats) {
    return selectedSeats.contains(seat);
  }
}