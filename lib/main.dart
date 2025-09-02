import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marondera Municipality',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      home: const MyHomePage(title: 'Marondera Municipality'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    debugPrint("Searching for: $query");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Pro AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: AppBar(
          elevation: 6,
          backgroundColor: Colors.teal,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 1.1,
            ),
          ),
          centerTitle: true,
        ),
      ),

      body: Column(
        children: [
          // ✅ Modern Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.teal.shade50,
            child: TextField(
              controller: _searchController,
              onSubmitted: _performSearch,
              decoration: InputDecoration(
                hintText: "Search services, info...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = "";
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.teal.shade200),
                ),
              ),
              onChanged: (value) {
                setState(() {}); // refresh suffix icon
              },
            ),
          ),

          // ✅ Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // HOME TAB
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.greenAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      margin: const EdgeInsets.all(24),
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.location_city,
                                size: 60, color: Colors.teal),
                            const SizedBox(height: 16),
                            const Text(
                              '👋 Welcome to Marondera',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Counter: $_counter',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            if (_searchQuery.isNotEmpty) ...[
                              const SizedBox(height: 20),
                              Text(
                                "🔍 Results for: $_searchQuery",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // INFO TAB
                Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.teal.shade50,
                  child: const Center(
                    child: Text(
                      '📢 Information about Marondera Municipality will appear here.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // SETTINGS TAB
                Container(
                  color: Colors.grey.shade100,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const Text(
                        "⚙️ Settings",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        leading: const Icon(Icons.notifications,
                            color: Colors.teal),
                        title: const Text("Notifications"),
                        trailing: Switch(value: true, onChanged: (v) {}),
                      ),
                      const Divider(),
                      ListTile(
                        leading:
                            const Icon(Icons.language, color: Colors.teal),
                        title: const Text("Language"),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip,
                            color: Colors.teal),
                        title: const Text("Privacy & Security"),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ✅ Bottom Navigation with Pro Look
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
        ),
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.teal,
          indicatorWeight: 3,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.info), text: "Info"),
            Tab(icon: Icon(Icons.settings), text: "Settings"),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        label: const Text("Add"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
