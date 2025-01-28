import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'Details_Screen.dart';

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
                  image: AssetImage('assets/images/food.jpg'),
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
                'Popular Food',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 8.0),

            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: FutureBuilder(
                future: loadFoodData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final foodData = snapshot.data;
                    final popularFoods = foodData?.expand((category) => category['foods']).toList() ?? [];

                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: popularFoods.map<Widget>((food) {
                        return _buildPopularFoodItem(context, food['image_url'], food['name'], ''); // Передаем context
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

  Widget _buildPopularFoodItem(BuildContext context, String imagePath, String title, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(foodData: {
              'image': imagePath,
              'title': title,
              'description': description,
            }),
          ),
        );
      },
      child: Container(
        width: 350.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                    image: DecorationImage(
                      image: AssetImage('assets/$imagePath'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.star, color: Colors.yellow, size: 20.0), // Иконка с оценкой
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8.0,
              top: 8.0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.favorite, color: Colors.red, size: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
