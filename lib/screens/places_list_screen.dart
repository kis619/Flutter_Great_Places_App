import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_info_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => (snapshot.connectionState ==
                ConnectionState.waiting)
            ? const Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                builder: (ctx, greatPlaces, ch) => (greatPlaces.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.items[i].image),
                          ),
                          title: Text(greatPlaces.items[i].title),
                          subtitle:
                              Text(greatPlaces.items[i].location.address!),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                PlaceInfoScreen.routeName,
                                arguments: greatPlaces.items[i].id);
                          },
                        ),
                      )),
                child: const Center(
                  child: Text('Got no places yet, start adding some!'),
                ),
              ),
      ),
    );
  }
}
