import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // We have three sections
      child: Scaffold(
        appBar: AppBar(
          title: Text("Health App"),
          backgroundColor: Colors.teal,
          bottom: TabBar(
            tabs: [
              Tab(text: "Vitals"),
              Tab(text: "Exercise"),
              Tab(text: "Diet"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Vitals Section
            VitalsScreen(),

            // Exercise Section
            ExerciseScreen(),

            // Diet Section
            DietScreen(),
          ],
        ),
      ),
    );
  }
}

// Vitals Screen (Static Data)
class VitalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vitals Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildVitalCard('Blood Pressure', '__/__ mmHg', Colors.blue),
                  _buildVitalCard('Stress Level', 'Relaxed', Colors.orange),
                  _buildVitalCard('Heart Rate', '80 bpm', Colors.red),
                  _buildVitalCard('SpO2', '98%', Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalCard(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// Diet Screen with Logging and Category Selection
class DietScreen extends StatefulWidget {
  @override
  _DietScreenState createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  // Default meal categories and the meals for each category
  final Map<String, List<Map<String, dynamic>>> meals = {
    "Breakfast": [],
    "Morning Snack": [],
    "Lunch": [],
    "Evening Snack": [],
    "Dinner": [],
  };

  final TextEditingController mealController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  String selectedCategory = "Breakfast"; // Default category

  void _logMeal() {
    setState(() {
      meals[selectedCategory]?.add({
        "title": mealController.text,
        "calories": caloriesController.text,
      });
      mealController.clear();
      caloriesController.clear();
    });
  }

  // Show a dialog to select a category
  void _selectCategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Meal Category'),
          content: DropdownButton<String>(
            value: selectedCategory,
            items: meals.keys.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (newCategory) {
              setState(() {
                selectedCategory = newCategory!;
              });
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Weight: 59 Kgs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: meals.entries.map((entry) {
                  return MealCategoryCard(
                    category: entry.key,
                    meals: entry.value,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: mealController,
              decoration: InputDecoration(
                labelText: "Meal Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: caloriesController,
              decoration: InputDecoration(
                labelText: "Calories",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _logMeal,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  "Log Your Meal",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectCategory(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  "Select Meal Category",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealCategoryCard extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> meals;

  const MealCategoryCard({required this.category, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(
              children: meals.map((meal) {
                return MealCard(
                  title: meal["title"],
                  calories: meal["calories"],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final String title;
  final String calories;

  const MealCard({required this.title, required this.calories});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              calories,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

// Exercise Screen with Logging and Default Data
class ExerciseScreen extends StatefulWidget {
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final List<Map<String, String>> exercises = [
    {"title": "Skipping", "time": "34 min", "calories": "200 Kcal"},
    {"title": "Cycling", "time": "30 min", "calories": "300 Kcal"},
    {"title": "Meditation", "time": "15 min", "calories": "50 Kcal"},
    {"title": "Running", "time": "15 min", "calories": "150 Kcal"},
  ];

  final TextEditingController exerciseController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController caloriesBurnedController = TextEditingController();

  void _logExercise() {
    setState(() {
      exercises.add({
        "title": exerciseController.text,
        "time": timeController.text,
        "calories": caloriesBurnedController.text,
      });
      exerciseController.clear();
      timeController.clear();
      caloriesBurnedController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Steps: 3,524",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Calories Burned: 952",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  return ExerciseCard(
                    title: exercises[index]["title"]!,
                    time: exercises[index]["time"]!,
                    calories: exercises[index]["calories"]!,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: exerciseController,
              decoration: InputDecoration(
                labelText: "Exercise Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: "Time Spent (e.g., 30 min)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: caloriesBurnedController,
              decoration: InputDecoration(
                labelText: "Calories Burned",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _logExercise,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  "Log Your Exercise",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String title;
  final String time;
  final String calories;

  const ExerciseCard({
    required this.title,
    required this.time,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Text(
              calories,
              style: TextStyle(fontSize: 16, color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
