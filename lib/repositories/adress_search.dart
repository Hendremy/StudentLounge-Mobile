import 'package:flutter/material.dart';
import 'package:studentlounge_mobile/repositories/place_service.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  PlaceApiProvider? apiClient;

  AddressSearch(sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return IconButton(
      tooltip: 'Result',
      icon: const Icon(Icons.search),
      onPressed: () {},
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        // We will put the api call here
        future: query == "" ? null : apiClient?.fetchSuggestions(query, 'fr'),
        builder: (context, snapshot) {
          if (query == '') {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text('Enter your address'),
            );
          } else {
            if (snapshot.hasData) {
              final list = snapshot.data as List;
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  // we will display the data returned from our future here
                  title: Text(list[index].getDescription()),
                  onTap: () {
                    close(context, list[index]);
                  },
                ),
                itemCount: list.length,
              );
            } else {
              return Container(child: Text('Loading...'));
            }
          }
        });
  }
}
