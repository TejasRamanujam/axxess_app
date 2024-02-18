import 'package:flutter/material.dart';


class User {
  String name;
  int age;
  String disability;


  User(this.name, this.age, this.disability);
}


class HouseRenovationRecommendation {
  String getRecommendation(String disability) {
    switch (disability.toLowerCase()) {
      case 'wheelchair':
        return 'Consider widening doorways and hallways, installing ramps, and adding grab bars in bathrooms.';
      case 'visual impairment':
        return 'Install handrails along staircases and ensure adequate lighting with motion sensors.';
      case 'mobility impairment':
        return 'Remove any tripping hazards, install non-slip flooring, and consider a stair lift if needed.';
      case 'cannot walk':
        return 'Install an elevator or a stair lift to facilitate movement between floors.';
      // Add more cases for specific disabilities here
      default:
        return 'Please consult with a professional to assess your specific needs.';
    }
  }
}


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Renovation App',
      home: HealthRenovationScreen(),
    );
  }
}


class HealthRenovationScreen extends StatefulWidget {
  @override
  _HealthRenovationScreenState createState() => _HealthRenovationScreenState();
}


class _HealthRenovationScreenState extends State<HealthRenovationScreen> {
  String _selectedName = ''; // Set default value
  int _selectedAge = 20; // Set default value
  String _selectedDisability = 'Wheelchair'; // Set default value
  String _recommendation = '';


  List<String> disabilities = [
    'Wheelchair',
    'Visual Impairment',
    'Mobility Impairment',
    'Cannot Walk'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Renovation App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              onChanged: (value) {
                _selectedName = value;
              },
              decoration: InputDecoration(labelText: 'Name'),
            ),
            DropdownButtonFormField<int>(
              value: _selectedAge,
              items: <int>[20, 30, 40, 50, 60, 70, 80, 90].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (int? value) {
                setState(() {
                  _selectedAge = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Age'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedDisability,
              items: disabilities.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedDisability = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Physical Disability'),
            ),
            ElevatedButton(
              onPressed: _getRecommendation,
              child: Text('Get Recommendation'),
            ),
            SizedBox(height: 16),
            Text(_recommendation),
          ],
        ),
      ),
    );
  }


  void _getRecommendation() {
    if (_selectedName.isEmpty || _selectedAge == 0 || _selectedDisability.isEmpty) {
      setState(() {
        _recommendation = 'Please fill in all fields.';
      });
      return;
    }


    User user = User(_selectedName, _selectedAge, _selectedDisability);


    HouseRenovationRecommendation recommendation = HouseRenovationRecommendation();
    String userRecommendation = recommendation.getRecommendation(user.disability);


    setState(() {
      _recommendation = '\nDear ${user.name}, based on your physical disability (${user.disability}), we recommend the following house renovation:\n$userRecommendation';
    });
  }
}
