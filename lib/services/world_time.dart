import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  String timeOfDay;

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {

    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);

      // create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      if (now.hour >= 6 && now.hour < 7) {
        timeOfDay = "SUNRISE1";
      }
      else if (now.hour >= 7 && now.hour < 9) {
        timeOfDay = "SUNRISE2";
      }
      else if (now.hour >= 9 && now.hour < 11) {
        timeOfDay = "MIDDLE1";
      }
      else if (now.hour >= 11 && now.hour < 14) {
        timeOfDay = "MIDDLE2";
      }
      else if (now.hour >= 14 && now.hour < 18) {
        timeOfDay = "MIDDLE3";
      }
      else if (now.hour >= 18 && now.hour < 19) {
        timeOfDay = "SUNSET1";
      }
      else if (now.hour >= 19 && now.hour < 20) {
        timeOfDay = "SUNSET2";
      }
      else if (now.hour >= 20 && now.hour < 21) {
        timeOfDay = "SUNSET3";
      }
      else if (now.hour >= 21 && now.hour < 23) {
        timeOfDay = "NIGHT1";
      }
      else if (now.hour >= 23 || now.hour < 3) {
        timeOfDay = "NIGHT2";
      }
      else {
        timeOfDay = "NIGHT3";
      }
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}