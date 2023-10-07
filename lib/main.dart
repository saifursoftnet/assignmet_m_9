import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Implement search functionality here
              },
            ),
          ],
        ),
        body: MyBagPage(),
      ),
    );
  }
}

class MyBagPage extends StatefulWidget {
  @override
  _MyBagPageState createState() => _MyBagPageState();
}

class _MyBagPageState extends State<MyBagPage> {
  int itemCount = 0; // Initialize with the initial item count
  double itemPrice = 0; // Initialize with the item price

  int pullOverItem = 0;
  int tshirt = 0;
  int sprotDress = 0;

  void showCongratulationSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Your order has been placed.'),
      ),
    );
  }

  void _updateItem(int item, double price) {
    setState(() {
      itemCount += item;
      itemPrice += price;
    });
  }

  Widget _buildProductCard(
      String imageAsset,
      String title,
      String color,
      String size,
      double price,
      int item,
      void Function(int, double) updateItem) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey, width: 1.0),
      ),
      margin: EdgeInsets.all(10),
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: Image.asset(
          imageAsset,
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Color: "),
                RichText(
                  text: TextSpan(
                    text: color,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 10),
                Text("Size: "),
                RichText(
                  text: TextSpan(
                    text: size,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    if (item > 0) {
                      updateItem(-1, -price);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                  child: Icon(Icons.remove, color: Colors.black),
                ),
                Text(item.toString()),
                ElevatedButton(
                  onPressed: () {
                    updateItem(1, price);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                  child: Icon(Icons.add, color: Colors.black),
                ),
                Expanded(
                  child: Text(
                    "\$$price",
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            )
          ],
        ),
        trailing: TextButton(
          onPressed: () {},
          child: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Column(
              children: [
                _buildProductCard(
                  "assets/pullover.png",
                  "Pullover",
                  "Black",
                  "L",
                  51.0,
                  pullOverItem,
                      (int item, double price) {
                    setState(() {
                      pullOverItem += item;
                      itemCount += item;
                      itemPrice += price;
                    });
                  },
                ),
                _buildProductCard(
                  "assets/T-shirt.png",
                  "T-Shirt",
                  "Gray",
                  "L",
                  30.0,
                  tshirt,
                      (int item, double price) {
                    setState(() {
                      tshirt += item;
                      itemCount += item;
                      itemPrice += price;
                    });
                  },
                ),
                _buildProductCard(
                  "assets/Sportdress.png",
                  "Sport Dress",
                  "Black",
                  "M",
                  43.0,
                  sprotDress,
                      (int item, double price) {
                    setState(() {
                      sprotDress += item;
                      itemCount += item;
                      itemPrice += price;
                    });
                  },
                ),
              ],
            ),
            // Add more ListTiles or other content as needed
          ],
        ),
        Positioned(
          bottom: 6,
          left: 6,
          right: 6,
          child: Column(
            children: [
              ListTile(
                title: Text("Total Amount"),
                trailing: Text(
                    "\$${itemPrice.toStringAsFixed(2)}"), // Display the total amount
              ),
              InkWell(
                onTap: () {
                  showCongratulationSnackbar(context);
                },
                child: Container(
                  height: 80, // Increase the height as needed
                  decoration: BoxDecoration(
                    color: Colors.red, // Background color of the container
                    borderRadius: BorderRadius.circular(40), // Circular corners
                  ),
                  child: Center(
                    child: Text(
                      "Check Out",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}