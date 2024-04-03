import 'package:flutter/material.dart';

class RatingCard extends StatefulWidget {
  @override
  _RatingCardState createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  int initialRating = 0; // Track initial rating
  TextEditingController ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildRatingCard1(initialRating);
  }

  Widget buildRatingCard1(int initialRating) {
    return Container(

      child: Card(
        elevation: 5,
        margin: EdgeInsets.only(top: 20),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Give Ratings: $initialRating',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: List.generate(
                  5,
                      (starIndex) => GestureDetector(
                    onTap: () {
                      setState(() {
                        initialRating = starIndex + 1;
                      });
                    },
                    child: Icon(
                      starIndex < initialRating
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Show dialog to input new rating
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Edit Rating"),
                        content: TextField(
                          controller: ratingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "New Rating"),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              // Update the rating
                              setState(() {
                                initialRating = int.parse(ratingController.text);
                              });
                              // Send the updated rating to backend
                              sendRatingToBackend(initialRating);
                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                            child: Text("Save"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Edit Rating'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendRatingToBackend(int rating) {
    // Implement backend communication to send the updated rating
    print("Sending rating $rating to backend...");
    // Here you would have the logic to send the rating to your backend API
  }

  @override
  void dispose() {
    ratingController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Rating Card Example'),
      ),
      body: RatingCard(),
    ),
  ));
}
