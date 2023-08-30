import 'package:flutter/material.dart';

void main() {
  runApp(WaterTracker());
}

class WaterTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Water Reminder App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WaterReminderScreen(),
    );
  }
}

class WaterReminderScreen extends StatefulWidget {
  @override
  _WaterReminderScreenState createState() => _WaterReminderScreenState();
}

class _WaterReminderScreenState extends State<WaterReminderScreen> {
  int glassesDrank = 0;
  int targetGlasses = 8;
  int streakDays = 0;
  bool completedToday = false;

  void _drinkGlass() {
    setState(() {
      glassesDrank++;
      completedToday = glassesDrank >= targetGlasses;

      if (completedToday) {
        streakDays++;
        _showCongratulationsDialog();
      }
    });
  }

  void _nextDay() {
    if (glassesDrank < targetGlasses) {
      _resetStreak();
    } else {
      _resetDay();
    }
  }

  void _resetDay() {
    setState(() {
      glassesDrank = 0;
      completedToday = false;
    });
  }

  void _resetStreak() {
    setState(() {
      streakDays = 0;
    });
    _resetDay();
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You completed today\'s goal. Keep up the good work!'),
          actions: [
            ElevatedButton(
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

  double _calculateWaterPercentage() {
    return glassesDrank / targetGlasses * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Reminder'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Glasses Drank: $glassesDrank / $targetGlasses',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: targetGlasses,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text('Glass ${index + 1}'),
                    value: index < glassesDrank,
                    onChanged: completedToday ? null : (bool? value) => _drinkGlass(),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            if (completedToday)
              Text(
                'Congratulations! You completed today\'s goal!',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
            SizedBox(height: 20),
            Text(
              'Water Drank: ${_calculateWaterPercentage().toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Streak: $streakDays days',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: _nextDay,
              child: Text('Next Day'),
            ),
          ],
        ),
      ),
    );
  }
}
