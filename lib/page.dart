import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post_page.dart';

class PageN extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getTravelDataStream() {
    return _firestore
        .collection('Posts')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;

        return data;
      }).toList();
    });
  }

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
                child: Icon(Icons.airplanemode_active, color: Colors.blue[900]),
              ),
              const Text(
                'My ',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'adventure',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              const Tab(text: 'Home'),
              const Tab(text: 'About us'),
              const Tab(text: 'Favorites'),
              const Tab(text: 'Blogs'),
              const Tab(text: 'Contact us'),
            ],
            indicatorColor: Colors.blue[900],
          ),
          actions: [
            Row(
              children: [
                const Text("Add Post"),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PostPage(null)));
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Travel Destinations',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: getTravelDataStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  } else {
                    final travelData = snapshot.data!;
                    return GridView.builder(
                      itemCount: travelData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // Adjusted for better mobile layout
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final Map<String, dynamic> item = travelData[index];
                        return TravelCard(
                          imagePath: item['image'],
                          description: item['description'],
                          iconData: Icons.location_on,
                          owner: item['owner'],
                          id: item['id'],

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage()),
                            );
                          },
                        );
                      },
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
}

class TravelCard extends StatelessWidget {
  final String imagePath;
  final String description;
  final IconData iconData;

  final String owner;
  final String id;
  final Function onTap;

  const TravelCard({
    required this.imagePath,
    required this.description,
    required this.iconData,
    required this.owner,

    required this.id,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 300,
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // future: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get(),

           /*   FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection("users").doc().get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return  ListTile(
                title: Text("${data['full name']} "),

                leading: FirebaseAuth.instance.currentUser!.email==owner?IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostPage({
                            "image":imagePath,
                            "description":description,
                            "id":id,

                          })));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.amber,
                    )):SizedBox(),
                trailing: FirebaseAuth.instance.currentUser!.email==owner?IconButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button?
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                                'Are you sure you want to delete the post?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Yes"),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("Posts")
                                      .doc(id)
                                      .delete();
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),):SizedBox(),);





            }

            return Text("loading");
          },
        ),*/




              ListTile(
                title: Text("$owner "),
                leading: FirebaseAuth.instance.currentUser!.email == owner
                    ? IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PostPage({
                                    "image": imagePath,
                                    "description": description,
                                    "id": id,
                                  })));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.amber,
                        ))
                    : const SizedBox(),
                trailing: FirebaseAuth.instance.currentUser!.email == owner
                    ? IconButton(
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button?
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                    'Are you sure you want to delete the post?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("Yes"),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("Posts")
                                          .doc(id)
                                          .delete();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      )
                    : const SizedBox(),
              ),

              Image.network(
                imagePath,
                fit: BoxFit.cover,
                height: 200.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      iconData,
                      color: Colors.blue[900],
                      size: 24.0,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        description,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
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
        title: const Text('Details Page'),
      ),
      body: const Center(
        child: Text('Details Page Content'),
      ),
    );
  }
}
