
import 'package:flutter/material.dart';
import 'package:travel_project/post_page.dart';




class HomePage extends StatelessWidget {
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> travelData = [
    {
      'imagePath': 'lib/assets/ajloun.jpeg',
      'description': 'Ajloun Castle,Ajloun',
      'iconData': Icons.location_on,
    },
    {
      'imagePath': 'lib/assets/deadsea.jpeg',
      'description': 'Dead Sea, Amman',
      'iconData': Icons.location_on,
    },
    {
      'imagePath': 'lib/assets/petra.webp',
      'description': "Petra,Ma\'an",
      'iconData': Icons.location_on,
    },
    {
      'imagePath': 'lib/assets/umqais.jpeg',
      'description': 'Um Qais,Irbid',
      'iconData': Icons.location_on,
    },
    {
      'imagePath': 'lib/assets/wadi rum.jpeg',
      'description': 'Wadi Rum,Aqaba',
      'iconData': Icons.location_on,
    },
    {
      'imagePath': 'lib/assets/citadel.jpeg',
      'description': 'Amman Citadel,Amman',
      'iconData': Icons.location_on,
    },
    // Add more dummy data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.airplanemode_active,color: Colors.blue[900]), // Icon for the title
              ),
              Text('My ',style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
               // color: Colors.cyan,
              )),
              Text('adventure',style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
               // color: Colors.lightBlue[900],
              )),// Title text
            ],
          ),

          bottom: TabBar(
            tabs: [
              Tab(text: 'Home'), // Tab 1 with text 'Explore'
              Tab(text: 'About us'), // Tab 1 with text 'Explore'
              Tab(text: 'Favorites'), // Tab 1 with text 'Explore'
              Tab(text: 'Blog'), // Tab 1 with text 'Explore'
              Tab(text: 'Contact us'),
            // Tab 2 with text 'Favorites'
            ],indicatorColor: Colors.blue[900],


          ),actions: [
            Row(
              children: [
                Text("Search"),
                IconButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostPage(null)));
                  
                }, icon: Icon(Icons.add)),
              ],
            )],
        ),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,

          children: [
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(textAlign: TextAlign.center,
                'Travel Destinations',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: travelData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Number of columns in the grid
                  crossAxisSpacing: 8.0, // Spacing between columns
                  mainAxisSpacing: 8.0, // Spacing between rows
                ),
                itemBuilder: (BuildContext context, int index) {
                  final Map<String, dynamic> item = travelData[index];
                  return TravelCard(
                    imagePath: item['imagePath'],
                    description: item['description'],
                    iconData: item['iconData'],
                    onTap: () {
                      // Navigate to another page when the card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailsPage()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class TravelCard extends StatelessWidget {
  final String imagePath;
  final String description;
  final IconData iconData;
  final Function onTap;

  const TravelCard({
    required this.imagePath,
    required this.description,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call onTap function when the card is tapped
        onTap();
      },
      child: Container(
        width: 300,
        child: Card(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 200.0, // adjust height as needed
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          iconData,
                          color: Colors.blue[900],
                          size: 24.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          description,
                          style: TextStyle(fontSize: 16.0),
                          
                        ),
                      ],
                    )
                    ,
                    SizedBox(height: 8.0),
                    // Add more icons or text as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Center(
        child: Text('Details Page Content'),
      ),
    );
  }
}

