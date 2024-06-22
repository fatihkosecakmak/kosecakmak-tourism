
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamukkale_admin/data/entity/trip_model.dart';

abstract class PanelState{

}
class PanelInitial extends PanelState{

}
class PanelLoading extends PanelState{

}
class PanelCompleted extends PanelState{
  final List<TripModel> response;
   PanelCompleted({required this.response});
}
class PanelCubit extends Cubit<PanelState>{
  PanelCubit():super(PanelInitial());

  final tripCollection = FirebaseFirestore.instance.collection("trips");
  Future<void> fetchTrip() async{
    var query = tripCollection;
    emit(PanelLoading());
    Future.delayed(Duration(milliseconds: 1000));
    query.snapshots().listen((event) {
      var tripList = <TripModel>[];
      var docs = event.docs;
      for(var document in docs){
        var data = document.data();
        var key = document.id;
        var travel = TripModel.fromJson(data, key);
        tripList.add(travel);
      }
      emit(PanelCompleted(response: tripList));
    });
  }
  Future<void> deleteTravel(String docId)async {
    print(docId);
   tripCollection.doc(docId).delete();
  }
}