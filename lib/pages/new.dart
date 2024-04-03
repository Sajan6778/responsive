import 'package:flutter/material.dart';

class MyNew extends StatefulWidget {
  const MyNew({super.key});

  @override
  State<MyNew> createState() => _MyNewState();
}

class _MyNewState extends State<MyNew> {
  List<Map<String, dynamic>> wishlistItems = [];
  List<bool> isFavoriteList = List.generate(FishData.length, (index) => false);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: FishData.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              isFavoriteList[index] = !isFavoriteList[index];

              if (isFavoriteList[index]) {
                wishlistItems.add(FishData[index]);
              } else {
                wishlistItems.remove(FishData[index]);
              }
            });
          },
          child: Stack(
            children: [
              Container(
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: Text('Item ${index + 1}'),
              ),
              Positioned(
                top: 5.0,
                right: 5.0,
                child: Visibility(
                  visible: isFavoriteList[index],
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 20.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
List<Map<String, dynamic>> FishData = List.generate(
  20,
      (index) => {'name': 'Fish ${index + 1}', 'description': 'Description $index'},
);


