
class SeatModel {
  String seatNumber;
  String seatStatus;

  SeatModel({required this.seatNumber, required this.seatStatus});

  factory SeatModel.fromJson(Map<dynamic, dynamic> json, String key){
    return SeatModel(
        seatNumber: json["seat_no"], seatStatus: json["seat_status"]);
  }
}