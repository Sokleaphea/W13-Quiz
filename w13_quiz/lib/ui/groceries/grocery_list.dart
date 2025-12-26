import 'package:flutter/material.dart';
import 'package:w13_quiz/ui/tabs/search_tab.dart';
import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';
import 'grocery_form.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

enum Tab { groceries, search }

class _GroceryListState extends State<GroceryList> {
  final TextEditingController searchController = TextEditingController();
  List<Grocery> filteredItems = [];
  Tab currentTab = Tab.groceries;
  void onCreate() async {
    // Navigate to the form screen using the Navigator push
    Grocery? newGrocery = await Navigator.push<Grocery>(
      context,
      MaterialPageRoute(builder: (context) => const GroceryForm()),
    );
    if (newGrocery != null) {
      setState(() {
        dummyGroceryItems.add(newGrocery);
      });
    }
  }

  void searchItem(String query) async {
    setState(() {
      filteredItems = dummyGroceryItems
          .where(
            (items) => items.name.toLowerCase().startsWith(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      //  Display groceries with an Item builder and  LIst Tile
      content = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (context, index) =>
            GroceryTile(grocery: dummyGroceryItems[index]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: onCreate, icon: const Icon(Icons.add))],
      ),
      // body: content,
      body: IndexedStack(
        index: currentTab.index,
        children: [
          Container(child: content),
          SearchTab(searchController: searchController, onSearch: searchItem, results: filteredItems),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab.index,
        selectedItemColor: Colors.red,
        onTap: (index) {
          setState(() {
            currentTab = Tab.values[index];
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store),
            label: "Groceries",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        ],
      ),
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(width: 15, height: 15, color: grocery.category.color),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
