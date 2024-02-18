import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health App',
      home: HealthInfoScreen(),
    );
  }
}

class HealthInfoScreen extends StatefulWidget {
  @override
  _HealthInfoScreenState createState() => _HealthInfoScreenState();
}

class _HealthInfoScreenState extends State<HealthInfoScreen> {
  int age = 0;
  int weight = 0;
  int height = 0;

  bool isSubmitted = false;

  void updateAge(int newAge) {
    setState(() {
      age = newAge;
      isSubmitted = false;
      if (isSubmitted) {
        verifyInfo();
      }
    });
  }

  void updateWeight(int newWeight) {
    setState(() {
      weight = newWeight;
      isSubmitted = false;
      if (isSubmitted) {
        verifyInfo();
      }
    });
  }

  void updateHeight(int newHeight) {
    setState(() {
      height = newHeight;
      isSubmitted = false;
      if (isSubmitted) {
        verifyInfo();
      }
    });
  }

  void verifyInfo() {
    if (!(weight < 800 || height > 108 || age > 130)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You are a medical miracle'),
            content: Text('The weight must be under 800, the height must be under 108, or the age must be under 130.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void submitInfo() {
    setState(() {
      isSubmitted = true;
      verifyInfo();
    });
  }

  void resetSubmit() {
    setState(() {
      isSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Health'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Please enter your information:', style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 16.0),
              HealthInfoForm(updateAge, updateWeight, updateHeight),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: isSubmitted ? resetSubmit : submitInfo,
                child: Text('Submit'),
              ),
              SizedBox(height: 32.0),
              Text('List of prescription medication:', style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 16.0),
              MedicationList(age: age, weight: weight, height: height, isSubmitted: isSubmitted),
            ],
          ),
        ),
      ),
    );
  }
}

class HealthInfoForm extends StatelessWidget {
  final Function(int) onAgeChanged;
  final Function(int) onWeightChanged;
  final Function(int) onHeightChanged;

  HealthInfoForm(this.onAgeChanged, this.onWeightChanged, this.onHeightChanged);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          textAlign: TextAlign.center,
          onChanged: (value) => onAgeChanged(int.tryParse(value) ?? 0),
          decoration: InputDecoration(hintText: 'Age'),
        ),
        TextFormField(
          onChanged: (value) => onWeightChanged(int.tryParse(value) ?? 0),
          textAlign: TextAlign.center,
          decoration: InputDecoration(hintText: 'Weight (lbs)'),
        ),
        TextFormField(
          onChanged: (value) => onHeightChanged(int.tryParse(value) ?? 0),
          textAlign: TextAlign.center,
          decoration: InputDecoration(hintText: 'Height (inches)'),
        ),
      ],
    );
  }
}

class MedicationList extends StatelessWidget {
  final List<String> medications = [
    'Aspirin',
    'Ibuprofen',
    'Acetaminophen',
    'Lisinopril',
    'Metformin',
    'Atorvastatin',
    'Simvastatin',
    'Levothyroxine',
    'Amlodipine',
    'Omeprazole'
  ];

  final int age;
  final int weight;
  final int height;
  final bool isSubmitted;

  MedicationList({required this.age, required this.weight, required this.height, required this.isSubmitted});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: medications.length,
      itemBuilder: (context, index) {
        String medication = medications[index];
        TextStyle style = TextStyle(color: Colors.black);

        if (isSubmitted) {
          if(((weight > 150 && medication == 'Aspirin') ||
            (height > 40 && medication == 'Levothyroxine') ||
            (age > 80 && medication == 'Lisinopril'))) {
              style = TextStyle(color: Colors.red);
            }
        }

        return ListTile(
          title: Text(
            medication,
            style: style,
          ),
        );
      },
    );
  }
}
