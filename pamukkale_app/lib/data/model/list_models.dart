
import 'package:pamukkale_app/data/model/seat_model.dart';
import 'package:pamukkale_app/data/model/trip_model.dart';

class ListModels {
  final List<TripModel> tripModel;
  final List<SeatModel> seatModel;

  ListModels({
    required this.tripModel,
    required this.seatModel,
  });

  ListModels copyWith({
    List<TripModel>? tripModel,
    List<SeatModel>? seatModel,
  }) {
    return ListModels(
      tripModel: tripModel ?? this.tripModel,
      seatModel: seatModel ?? this.seatModel,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ListModels &&
              runtimeType == other.runtimeType &&
              tripModel == other.tripModel &&
              seatModel == other.seatModel;

  @override
  int get hashCode => tripModel.hashCode ^ seatModel.hashCode;
}