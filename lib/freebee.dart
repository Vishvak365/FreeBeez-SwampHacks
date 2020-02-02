import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class Freebee {
  final db = Firestore.instance;

  String title;
  String desc;
  GeoPoint coordinates;
  int itemCode;
  bool meetingRequired;
  bool signingRequired;
  String imageURL;
  int rating;
  Timestamp postingTime;

  createFromDB(Map<String, dynamic> data) {
    this.title = data["title"];
    this.desc = data["desc"];
    this.coordinates = data["loc"];
    this.itemCode = data["itemCode"];
    this.meetingRequired = data["meetingRequired"];
    this.signingRequired = data["signingRequired"];
    this.imageURL = data["imageURL"];
    this.rating = data["rating"];
    this.postingTime = data["postingTime"];
  }

  Future<void> updateGPS() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    this.coordinates = new GeoPoint(position.latitude, position.longitude);
  }

  Future<void> save() {
    return db.collection("postings").add({
      'title': this.title,
      'desc': this.desc,
      'itemCode': this.itemCode,
      'loc': this.coordinates,
      'imageURL': this.imageURL,
      'rating': this.rating,
      'meetingRequired': this.meetingRequired,
      'signingRequired': this.signingRequired,
      'postingTime': Timestamp.now()
    });
  }
}
