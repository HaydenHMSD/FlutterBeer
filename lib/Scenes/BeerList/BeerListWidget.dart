import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Data/Beer.dart';
import '../../API/FetchBeersRequest.dart';
import '../BeerDetails/BeerDetailsWidget.dart';

/*
Routing names
 */
const routeHome = '/';
const routeBeerDetails = '/beerdetails';

class BeerListWidget extends StatefulWidget {
  BeerListWidget({Key? key}) : super(key: key);

  @override
  _BeerListWidgetState createState() => _BeerListWidgetState();
}

class _BeerListWidgetState extends State<BeerListWidget> {
  late Future<List<Beer>> futureBeer;

  @override
  void initState() {
    super.initState();

    dev.debugger();

    futureBeer = fetchBeers();
  }
  @override
  void debugFillProperties(
      DiagnosticPropertiesBuilder properties
      ) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('Beer Listtt', 'BeerListWidget'));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {

        dev.log('router', name: 'Routing', error: {"name": settings.name});

        late Widget page;

        if (settings.name == routeHome) {
          page = BeerListWidget();
        } else if (settings.name == routeBeerDetails) {
          dev.log('construct beer details');
          Beer beer = settings.arguments as Beer;
          page = BeerDetailsScreen(beer: beer);
        } else {
          throw Exception('Unknown route: ${settings.name}');
        }

        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return page;
          },
          settings: settings,
        );
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('Punk API'),
        ),
        body: Center(
          child: FutureBuilder<List<Beer>>(
            future: futureBeer,
            builder: (context, snapshot) {
              List<Beer>? data = snapshot.data;
              if (data != null) {
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      Beer beer = data[index];
                      final name = beer.name;
                      final tagline = beer.tagline;
                      return ListTile(
                        title: Text('$name'),
                        subtitle: Text('$tagline'),
                        onTap: () {
                          Navigator.pushNamed(context, routeBeerDetails, arguments: beer);
                        },
                      );
                    }
                );
              } else {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}