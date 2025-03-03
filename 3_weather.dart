import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = "New York";
  String apiKey = "YOUR_API_KEY"; // Get from openweathermap.org
  Map<String, dynamic>? weatherData;

  Future<void> fetchWeather() async {
    final url = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() => weatherData = json.decode(response.body));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Center(
        child: weatherData == null
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${weatherData!['name']}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("${weatherData!['main']['temp']}°C", style: TextStyle(fontSize: 48)),
            Text("${weatherData!['weather'][0]['description']}", style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: "Enter city name"),
                onSubmitted: (value) {
                  setState(() => city = value);
                  fetchWeather();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
