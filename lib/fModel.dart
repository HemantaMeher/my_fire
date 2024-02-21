//Model Class
import 'package:cloud_firestore/cloud_firestore.dart';

class DataTypes {
  String? name;
  int? number;
  List? lists;
  Map? maps;
  Timestamp? dateTime;

  DataTypes( {this.name, this.number, this.lists, this.maps,this.dateTime});
  factory DataTypes.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    if (data == null) throw Exception("No data found in document");
    return DataTypes(
      name: data['name'],
      number: data['number'],
      lists: data['lists'],
      maps: data['maps'],
      dateTime: data['dateTime'],
    );


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Number'] = this.number;
    data['Lists'] = this.lists;
    data['Maps'] = this.maps;
    data['DateTime'] = this.dateTime;
    return data;
  }
}

class SendData {
  String? name;
  int? number;
  List<dynamic>? lists;
  DateTime? dateTime;
  Map<String, dynamic>? maps;

  SendData({
    required this.name,
    required this.number,
    required this.lists,
    required this.maps,
    required this.dateTime,
  });
  Map<String, dynamic> toJson() =>
      {"Name": name, "Number": number, "Lists": lists, "Maps": maps,"DateTime":dateTime};
}
