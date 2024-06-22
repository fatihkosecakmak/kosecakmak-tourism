// trips_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pamukkale_app/data/model/seat_model.dart';
import 'package:pamukkale_app/data/model/trip_model.dart';

// Modeller

class Seat {
  String id;
  int seatNumber;
  String status; // 'available', 'male', 'female'

  Seat({
    required this.id,
    required this.seatNumber,
    required this.status
  });
}

// Durumlar
abstract class TripState {}

class TripInitial extends TripState {}

class TripLoading extends TripState {}

class TripLoaded extends TripState {
  final List<TripModel> response;
  TripLoaded(this.response);
}

class SeatsLoading extends TripState {}

class SeatsLoaded extends TripState {
  final List<Seat> seats;
  final String selectedTripID;
  SeatsLoaded(this.seats, this.selectedTripID);
}

class SeatSelected extends TripState {
  final List<Seat> seats;
  final String selectedTripID;
  final Seat selectedSeat;
  SeatSelected(this.seats, this.selectedTripID, this.selectedSeat);
}

class TripError extends TripState {
  final String message;
  TripError(this.message);
}

// Cubit
class TripCubit extends Cubit<TripState> {
  TripCubit() : super(TripInitial());

  final tripCollection = FirebaseFirestore.instance.collection("trips");
  List<Seat> selectedSeats = [];

  Future<void> fetchTrips(String departure, String arrival,String date) async {
    try {
      emit(TripLoading());
      final query = await tripCollection.where('departure', isEqualTo: departure).where('arrival', isEqualTo: arrival).where('date',isEqualTo: date);
      query.snapshots().listen((event) {
        List<TripModel> tripList = [];
        var docs = event.docs;
        for(var doc in docs){
          var data = doc.data();
          var key = doc.id;
          var trip = TripModel.fromJson(data, key);
          tripList.add(trip);
        }
        emit(TripLoaded(tripList));
      });
    } catch (e) {
      emit(TripError(e.toString()));
    }
  }
  Future<void> sortByDescPrice(String departure,String arrival,String date) async{
    var query = tripCollection
        .where("departure",isEqualTo: departure)
        .where("arrival",isEqualTo: arrival)
        .where('date',isEqualTo: date)
        .orderBy("price",descending: true);
    query.snapshots().listen((event) {
      var tripList = <TripModel>[];
      var docs = event.docs;
      for(var document in docs){
        var data = document.data();
        var key = document.id;
        var trip = TripModel.fromJson(data,key);
        tripList.add(trip);
      }
      emit(TripLoaded(tripList));
    });
  }
  Future<void> sortByAscPrice(String departure,String arrival,String date) async{
    var tripQuery = tripCollection
        .where("departure",isEqualTo: departure)
        .where("date",isEqualTo: date)
        .where("arrival",isEqualTo: arrival)
        .orderBy("price");
    tripQuery.snapshots().listen((event) {
      var tripList = <TripModel>[];
      var docs = event.docs;
      for(var document in docs){
        var data = document.data();
        var key = document.id;
        var trip = TripModel.fromJson(data,key);
        tripList.add(trip);
      }
      emit(TripLoaded(tripList));
    });
  }
  Future<void> sortByAscDate(String departure,String arrival,String date) async{
    var tripQuery = tripCollection.where("departure",isEqualTo: departure).where("arrival",isEqualTo: arrival).where("date",isEqualTo: date).orderBy("departureTime");
    tripQuery.snapshots().listen((event) {
      var tripList = <TripModel>[];
      var docs = event.docs;
      for(var document in docs){
        var data = document.data();
        var key = document.id;
        var trip = TripModel.fromJson(data,key);
        tripList.add(trip);
      }
      emit(TripLoaded(tripList));
    });
  }
  Future<void> sortByDescDate(String departure,String arrival,String date) async{
    var tripQuery = tripCollection.where("departure",isEqualTo: departure).where("arrival",isEqualTo: arrival).where("date",isEqualTo: date).orderBy("departureTime",descending: true);
    tripQuery.snapshots().listen((event) {
      var tripList = <TripModel>[];
      var docs = event.docs;
      for(var document in docs){
        var data = document.data();
        var key = document.id;
        var trip = TripModel.fromJson(data,key);
        tripList.add(trip);
      }
      emit(TripLoaded(tripList));
    });
  }
}
