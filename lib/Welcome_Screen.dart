import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<dynamic>> loadJsonData() async {
  final String response = await rootBundle.loadString('assets/text.json');
  return json.decode(response);
}

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> foodData;

  DetailsScreen({required this.foodData});

  @override
  Widget build(BuildContext context) {
    if (foodData['image'] == null) {
      return Center(child: Text('Image not found'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food Image
              Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('assets/${foodData['image']}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Food Title and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    foodData['title'],
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 20.0),
                      SizedBox(width: 4.0),
                      Text(
                        foodData['rating'].toString(),
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              // Preparation and Serving Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Prep: ${foodData['prepTime']}',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                  Text('Total: ${foodData['totalTime']}',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                  Text('Servings: ${foodData['servings']}',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                ],
              ),
              SizedBox(height: 16.0),
              // Description
              Text(
                'Description',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                foodData['description'],
                style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
              ),
              SizedBox(height: 16.0),
              // Steps
              Text(
                'Steps',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              if (foodData['steps'] == null || !(foodData['steps'] is List))
                Center(child: Text('Steps not found'))
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: foodData['steps'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              foodData['steps'][index],
                              style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

