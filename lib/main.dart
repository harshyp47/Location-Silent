import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:volume/volume.dart';


void main() => runApp(MaterialApp(
  title: 'LocationSilent',
  home: App(),


));



class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();



}




class _AppState extends State<App> {

  String _locationMessage = "";
  String _msg = "";

   var _list = ['',''];
   String _dist ="";
   String _saved = "";







   void _exitpro() async {
    SystemNavigator.pop();
  }

  void _getCurrentLocation() async {
    while(true) {
        final position = await Geolocator().getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        double distance = await Geolocator().distanceBetween(position.latitude, position.longitude, double.parse(_list[0]),double.parse(_list[1]));
      _dist = distance.toStringAsFixed(2)+"m";
      if (distance < 300) {
        print("Silent Profile");
        //FlutterVolume.mute();
        await Volume.controlVolume(AudioManager.STREAM_MUSIC);
        await Volume.setVol(0, showVolumeUI: ShowVolumeUI.HIDE);
        setState(() {
          _locationMessage = "${position.latitude}, ${position.longitude}";
          _msg = "Silent Profile";
        });
      }
      else {
        //FlutterVolume.setVolume(1);
        await Volume.setVol(15, showVolumeUI: ShowVolumeUI.HIDE);
        setState(() {
          _locationMessage = "${position.latitude}, ${position.longitude}";
          _msg = "General Profile";
        });
      }
    }

  }





  // This widget is the root of your application.
  @override

  //Input Box
  Widget build(BuildContext context) {

    input(BuildContext context){
      TextEditingController custcontroller = new TextEditingController();

      return showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Enter the point (Lat., Long.)"),
          content: TextField(
            controller: custcontroller ,

          ),


          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Save", style: TextStyle(color: Colors.black),),
              onPressed: (){

                    _list[0] = (custcontroller.text.toString().substring(0,10));
                    _list[1] = (custcontroller.text.toString().substring(11,21));
                    print(_list);
                    _saved = "Lat: ${_list[0]}, Long: ${_list[1]}";
                    Navigator.of(context).pop();





              },

            )
          ],
        );


      });
    }
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(backgroundColor: Colors.black,
            appBar: AppBar(
                title: Text(""),
                backgroundColor: Colors.black,
            ),
            body: Align(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("INSTRUCTIONS!",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    Text("Make sure you enter input in the form",style: TextStyle(color: Colors.red)),
                    Text(" '00.0000000,00.0000000' and then only press scan!",style: TextStyle(color: Colors.red)),
                    Text("Distance is the distance from saved location!",style: TextStyle(color: Colors.red)),
                    Text(" "),
                    Text("Location range: 300 m",style: TextStyle(color: Colors.white),),
                    Text("  "),
                    Text('Saved Location',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                    Text("  "),

                    Text(_saved, style: TextStyle(fontSize: 15, color: Colors.white),),
                    Text("  "),
                    Text("  "),
                    Text("Distance: ${_dist}",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                    Text("  "),
                    Text("  "),
                    Text("  "),
                    Text("  "),
                    Text("  "),

                    Text("     "),

                    Text("Your current location (Lat.,Long.) is:",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                    Text(_locationMessage,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                    Text("  "),
                    Text("  "),
                    Text("  "),

                    Text(_msg,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.red)),
                    Text("  "),
                    Text("  "),
                    Text("  "),
                    Text("  "),
                    Text("  "),



                    FlatButton(
                        onPressed: () {
                          _getCurrentLocation();
                        },
                        color: Colors.green,
                        child: Text("Scan", style: TextStyle(color: Colors.white),)
                    ),
                    FlatButton(
                        onPressed: () {
                          input(context);
                        },
                        color: Colors.blue,
                        child: Text("Add Location",style: TextStyle(color: Colors.white),)
                    ),
                    FlatButton(
                        onPressed: () {
                          _exitpro();
                        },
                        color: Colors.red,
                        child: Text("Exit", style: TextStyle(color: Colors.white),)
                    )


                  ]),
            )
        )
    );
  }
}