import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<dynamic>> loadJsonData() async {
  final String response = await rootBundle.loadString('assets/text.json');
  return json.decode(response);
}

Future<List<dynamic>> loadFoodData() async {
  final String response = await rootBundle.loadString('assets/food.json');
  return json.decode(response);
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food image at the top
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/food.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 16.0),

            // Main Categories menu buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Main categories',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 8.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('Main dishes', Icons.restaurant),
                _buildCategoryButton('Pastries', Icons.bakery_dining),
                _buildCategoryButton('Soups', Icons.soup_kitchen),
              ],
            ),

            SizedBox(height: 16.0),

            // Popular foods
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Popular food',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 8.0),

            Container(
              height: 180.0,
              child: FutureBuilder(
                future: loadFoodData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final foodData = snapshot.data;
                    final popularFoods = foodData?.last['popular'] ?? [];

                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: popularFoods.map<Widget>((food) {
                        return _buildFoodItem(food['image'], food['name'], food['description']);
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, size: 30.0, color: Colors.black),
        ),
        SizedBox(height: 8.0),
        Text(title, style: TextStyle(fontSize: 14.0)),
      ],
    );
  }

  Widget _buildFoodItem(String imagePath, String title, String description) {
    return GestureDetector(
      onTap: () {
        // Navigate to details page
      },
      child: Container(
        width: 150.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage('assets/$imagePath'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.0),
            Text(
              description,
              style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
