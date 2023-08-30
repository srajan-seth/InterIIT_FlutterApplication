import 'package:flutter/material.dart';

void main() {
  runApp(BoilingTimerApp());
}

class BoilingTimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: BoilingTimerScreen(),
    );
  }
}

class BoilingTimerScreen extends StatefulWidget {
  @override
  _BoilingTimerScreenState createState() => _BoilingTimerScreenState();
}

class _BoilingTimerScreenState extends State<BoilingTimerScreen> {
  List<FoodItem> foodItems = [
    FoodItem(food: 'Rice', time: 300),
    FoodItem(food: 'Egg', time: 300),
    FoodItem(food: 'Chicken', time: 1200),
    FoodItem(food: 'Carrots/Broccoli/Cauliflower/Kernels', time: 300),
    FoodItem(food: 'Potatoes', time: 1200),
    FoodItem(food: 'Shrimp', time: 300),
  ];

  void addFoodItem(String food, int time) {
    setState(() {
      foodItems.add(FoodItem(food: food, time: time));
    });
  }

  void deleteFoodItem(int index) {
    setState(() {
      foodItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boiling Timer App'),
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return FoodItemTile(
            foodItem: foodItems[index],
            onDelete: () {
              deleteFoodItem(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddFoodDialog(
              onFoodAdded: addFoodItem,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class FoodItem {
  final String food;
  final int time;

  FoodItem({required this.food, required this.time});
}

class FoodItemTile extends StatelessWidget {
  final FoodItem foodItem;
  final VoidCallback onDelete;

  FoodItemTile({required this.foodItem, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(foodItem.food),
      subtitle: Text('Boiling Time: ${formatTime(foodItem.time)}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TimerPage(foodItem: foodItem),
          ),
        );
      },
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secondsRemaining = seconds % 60;
    return '$minutes:${secondsRemaining.toString().padLeft(2, '0')}';
  }
}

class AddFoodDialog extends StatefulWidget {
  final Function(String, int) onFoodAdded;

  AddFoodDialog({required this.onFoodAdded});

  @override
  _AddFoodDialogState createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<AddFoodDialog> {
  final TextEditingController foodController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Food Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: foodController,
            decoration: InputDecoration(labelText: 'Food Name'),
          ),
          TextField(
            controller: timeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Boiling Time (minutes)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            final food = foodController.text;
            final time = int.tryParse(timeController.text) ?? 0;
            if (food.isNotEmpty && time > 0) {
              widget.onFoodAdded(food, time * 60);
              foodController.clear();
              timeController.clear();
              Navigator.pop(context);
            }
          },
          child: Text('Add'),
        ),
        TextButton(
          onPressed: () {
            foodController.clear();
            timeController.clear();
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    foodController.dispose();
    timeController.dispose();
    super.dispose();
  }
}

class TimerPage extends StatefulWidget {
  final FoodItem foodItem;

  TimerPage({required this.foodItem});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late ValueNotifier<int> timerNotifier;
  late bool isRunning;
  late int remainingTime;

  @override
  void initState() {
    super.initState();
    timerNotifier = ValueNotifier<int>(widget.foodItem.time);
    isRunning = false;
    remainingTime = widget.foodItem.time;
  }

  void startTimer() {
    if (!isRunning) {
      isRunning = true;
      Future<void> updateTimer() async {
        while (timerNotifier.value > 0) {
          await Future.delayed(Duration(seconds: 1));
          if (isRunning) {
            timerNotifier.value -= 1;
            setState(() {
              remainingTime = timerNotifier.value;
            });
          }
        }
        isRunning = false;
      }
      updateTimer();
    }
  }

  void pauseTimer() {
    isRunning = false;
  }

  void resetTimer() {
    isRunning = false;
    setState(() {
      timerNotifier.value = widget.foodItem.time;
      remainingTime = timerNotifier.value;
    });
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secondsRemaining = seconds % 60;
    return '$minutes:${secondsRemaining.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodItem.food),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Boiling Time: ${formatTime(remainingTime)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: startTimer,
                  child: Text('Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: pauseTimer,
                  child: Text('Pause'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
