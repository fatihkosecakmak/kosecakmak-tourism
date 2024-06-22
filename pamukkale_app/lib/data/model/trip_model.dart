
class TripModel{
  String arrival;
  String arrivalTime;
  String busType;
  String busTypeImage;
  String departure;
  String departureTime;
  String price;
  String totalSeats;
  String trip_id;
  String doc_id;

  TripModel(
      {required this.arrival,
      required this.arrivalTime,
      required this.busType,
      required this.busTypeImage,
      required this.departure,
      required this.departureTime,
      required this.price,
      required this.totalSeats,
      required this.trip_id,
      required this.doc_id});

  factory TripModel.fromJson(Map<dynamic,dynamic> json,String key){
    return TripModel(
        arrival: json["arrival"],
        arrivalTime: json["arrivalTime"],
        busType: json["busType"],
        busTypeImage: json["busTypeImage"],
        departure: json["departure"],
        departureTime: json["departureTime"],
        price: json["price"],
        totalSeats: json["totalSeats"],
        trip_id: key,
        doc_id: json["doc_id"]);
  }
}