import 'package:flutter/material.dart';
import 'package:w13_quiz/models/grocery.dart';

class SearchTab extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final List<Grocery> results;
  const SearchTab({
    super.key,
    required this.searchController,
    required this.onSearch,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: searchController,
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder(),
            ),
          ),
        ),
         Expanded(
          child: results.isEmpty
              ? const Center(child: Text('No results found'))
              : ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final item = results[index];
                    return ListTile(
                      leading: Container(
                        width: 15,
                        height: 15,
                        color: item.category.color,
                      ),
                      title: Text(item.name),
                      trailing: Text(item.quantity.toString()),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
