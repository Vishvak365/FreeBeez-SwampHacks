import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class Freebee {
  final db = Firestore.instance;

  String title;
  String desc;
  GeoPoint coordinates;
  int itemCode = 3;
  bool meetingRequired = false;
  bool signingRequired = false;
  String imageURL;
  int rating = 0;
  Timestamp postingTime;

  createFromDB(Map<String, dynamic> data) {
    this.title = (data.containsKey("title")) ? data["title"] : null;
    this.desc = (data.containsKey("desc")) ? data["desc"] : null;
    this.coordinates = (data.containsKey("loc")) ? data["loc"] : null;
    this.itemCode = (data.containsKey("itemCode")) ? data["itemCode"] : null;
    this.meetingRequired = (data.containsKey("meetingRequired")) ? data["meetingRequired"] : null;
    this.signingRequired = (data.containsKey("signingRequired")) ? data["signingRequired"] : null;
    this.imageURL = (data.containsKey("imageURL")) ? data["imageURL"] : null;
    this.rating = (data.containsKey("rating")) ? data["rating"] : null;
    this.postingTime =
        (data.containsKey("postingTime")) ? data["postingTime"] : null;
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
