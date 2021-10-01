import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import '../../Data/Beer.dart';
import '../../Data/DataManager.dart';

class BeerDetailsScreen extends StatefulWidget {

  final Beer beer;
  BeerDetailsScreen({Key? key, required this.beer}) : super(key: key);

  @override
  _BeerDetailsScreenState createState() => _BeerDetailsScreenState(beer: beer);
}

class _BeerDetailsScreenState extends State<BeerDetailsScreen> {
  final Beer beer;
  late List<BeerPanelInfo> _panelInfos;
  bool isFavorite;
  DataManager dataManager = DataManager();
  late Future<List<int>> favoriteIDs;

  _BeerDetailsScreenState({required this.beer, this.isFavorite = false,}) : super();

  @override
  void initState() {
    super.initState();
    _panelInfos = _buildBeerPanelInfos(beer);
    favoriteIDs = dataManager.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    String name = beer.name ?? '';
    String imagePath = beer.imagePath ??
        'https://images.punkapi.com/v2/192.png';
    favoriteIDs = dataManager.loadFavorites();

    return FutureBuilder<List<int>>(
        future: favoriteIDs,
        builder: (context, snapshot) {
          var favoriteIDs = snapshot.data;

          final beerID = beer.id;

          if (beerID != null && favoriteIDs != null) {

            isFavorite = favoriteIDs.contains(beerID);
            return MaterialApp(
              title: 'Fetch Data Example',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Scaffold(
                appBar: AppBar(
                  title: Text(name),
                  leading: IconButton(icon: Icon(Icons.arrow_back),
                    //onPressed:() => Navigator.pop(context, false),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  actions: [
                    IconButton(
                      icon: isFavorite
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border_outlined),
                      tooltip: 'Toggle favorite',
                      onPressed: () {
                        developer.log('Trying to toggle favorite');
                        _toggleFavoriteState(beer);
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                  ],
                ),
                body: Center(
                    child:
                    ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Image.network(
                            imagePath,
                            height: 200,
                          ),
                        ),
                        _buildPanelList(_panelInfos),
                      ],
                    )
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Text('loading...');
          }

        }
    );

    // return
  }

  _toggleFavoriteState(Beer beer) async {
    final id = beer.id;
    if (id != null) {
      favoriteIDs = dataManager.toggleFavorite(id);
    }
  }

  Widget _buildPanelList(List<BeerPanelInfo> infos) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          infos[index].isExpanded = !isExpanded;
        });
      },
      children: infos.map<ExpansionPanel>((BeerPanelInfo item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold)),
            );
          },
          body: ListView(
              shrinkWrap: true,
              children:
              List.from(
                  item.details.map<Widget>((String details) =>
                      ListTile(
                        title:
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Text(details),
                        ),
                      ))
              )
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

List<BeerPanelInfo> _buildBeerPanelInfos(Beer beer) {
  // details
  BeerPanelInfo detailsInfo = BeerPanelInfo(title: 'Details', details: List.filled(1, beer.panelDetails()));
  detailsInfo.isExpanded = true;
  List<BeerPanelInfo> list = List<BeerPanelInfo>.filled(1, detailsInfo, growable: true);

  // ingredients
  final ingredients = beer.ingredients;
  if (ingredients != null) {
    BeerPanelInfo ingredientsInfo = BeerPanelInfo(
        title: 'Ingredients', details: ingredients.panelDetails());
    list.add(ingredientsInfo);
  }

  return list;
}
/*
Beer Panel Info
 */
class BeerPanelInfo {
  String title;
  List<String> details;
  bool isExpanded;

  BeerPanelInfo({
    required this.title,
    required this.details,
    this.isExpanded = false,
  });
}