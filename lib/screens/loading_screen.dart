import 'package:tempo_template/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert' ;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';
const apiKey = '//api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}' ;





class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);


  @override
  State<LoadingScreen> createState() => _LoadingScreenState();


}

class _LoadingScreenState extends State<LoadingScreen> {

  late double latitude;
  late double longitude;

  void pushToLocationScreen(dynamic weatherData) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }



  void getData() async {

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/'
        'data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
  }



    var url = Uri.parse
      ('https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) { // se a requisição foi feita com sucesso
      var data = response.body;
      var jsonData = jsonDecode(data);
      var cityName = jsonData['name'];
      var temperature = jsonData['main']['temp'];
      var weatherCondition = jsonData['weather'][0]['id'];

    print('cidade: $cityName, temperatura: $temperature, condição: $weatherCondition)`

      print(data);  // imprima o resultado
    } else {
      print(response.statusCode);  // senão, imprima o código de erro
    }
  }

  Future<void> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // serviço de localização desabilitado. Não será possível continuar
      return Future.error('O serviço de localização está desabilitado.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Sem permissão para acessar a localização
        return Future.error('Sem permissão para acesso à localização');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // permissões negadas para sempre
      return Future.error('A permissão para acesso a localização foi negada para sempre. Não é possível pedir permissão.');
    }
  }

  Future<void> getLocation() async{

    var location = Location();
    await location.getCurrentPosition();

    latitude = location.latitude!;
    longitude = location.longitude!;

    getData();
  }

    var location = Location();
    await location.getCurrentPosition();

    latitude = location.latitude!;
    longitude = location.longitude!;

    getData();
    await checkLocationPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position);
}
@override
void initState() {
  super.initState();
  updateUI(widget.locationWeather);
}



  @override
  Widget build(BuildContext context) {
    setState(() {
      void initState() {
        // é disparado quando o Widget for criado
      }

      Widget? build(BuildContext context) {
        // disparado quando o objeto for construído e o widget aparecerá na tela
        return null;
      }

      void deactivate() {
        // é disparado quando o widget foi destruído
      }
    });
    return Scaffold(

    );
  }
}
