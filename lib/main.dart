import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
        fontFamily: "Roboto",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Gradient AppBar
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // ✅ Glass-style Search Bar
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onSubmitted: _performSearch,
              decoration: InputDecoration(
                hintText: "Search services, info...",
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
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),

          // ✅ Tab Views with Lottie Animations
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // HOME TAB
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.greenAccent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(24),
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ✅ City animation
                            Lottie.asset(
                              "assets/animations/city.json",
                              height: 120,
                              repeat: true,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "👋 Welcome to Marondera",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Counter: $_counter",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (_searchQuery.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Text(
                                "🔍 Results for: $_searchQuery",
                                style: const TextStyle(fontSize: 16),
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
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ✅ Info animation
                      Lottie.asset(
                        "assets/animations/info.json",
                        height: 150,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "📢 Information about Marondera Municipality will appear here.",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // SETTINGS TAB
                Container(
                  color: Colors.grey.shade50,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Center(
                        child: Lottie.asset(
                          "assets/animations/settings.json",
                          height: 120,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "⚙️ Settings",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSettingsTile(
                        icon: Icons.notifications,
                        title: "Notifications",
                        trailing: Switch(value: true, onChanged: (v) {}),
                      ),
                      _buildSettingsTile(
                        icon: Icons.language,
                        title: "Language",
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      _buildSettingsTile(
                        icon: Icons.privacy_tip,
                        title: "Privacy & Security",
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ✅ Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.teal,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.info), text: "Info"),
            Tab(icon: Icon(Icons.settings), text: "Settings"),
          ],
        ),
      ),

      // ✅ Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        icon: const Icon(Icons.add),
        label: const Text("Add"),
        backgroundColor: Colors.teal,
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        trailing: trailing,
      ),
    );
  }
}
