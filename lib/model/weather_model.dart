class Weather {
  final String name;
  final double temperature;
  final String mainCondition;

  Weather({required this.name, required this.temperature, required this.mainCondition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw Exception('Failed to parse JSON');
    }
    if (!json.containsKey('name') || !json.containsKey('main') || !json.containsKey('weather')) {
      throw Exception('Invalid JSON structure');
    }
    if (!json['main'].containsKey('temp') || json['weather'].isEmpty) {
      throw Exception('Missing required fields in JSON');
    }
    return Weather(
      name: json['name'],
      temperature: json['main']['temp'],
      mainCondition: json['weather'][0]['description'],
    );
  }
}