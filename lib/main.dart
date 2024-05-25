import 'package:flutter/material.dart';

void main() {
  runApp(const GolfClubRecommendationApp());
}

class GolfClub {
  final String name;
  final String gripType;
  final String swingStrength;
  final int carryDistance;
  final int totalDistance;

  GolfClub({
    required this.name,
    required this.gripType,
    required this.swingStrength,
    required this.carryDistance,
    required this.totalDistance,
  });
}

class GolfClubRecommendationApp extends StatelessWidget {
  const GolfClubRecommendationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Golf Club Recommendation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GolfClubRecommendationScreen(),
    );
  }
}

class GolfClubRecommendationScreen extends StatefulWidget {
  const GolfClubRecommendationScreen({super.key});

  @override
  GolfClubRecommendationScreenState createState() => GolfClubRecommendationScreenState();
}

class GolfClubRecommendationScreenState extends State<GolfClubRecommendationScreen> {
  late TextEditingController _distanceController;
  List<GolfClub> _clubs = [];

  @override
  void initState() {
    super.initState();
    _distanceController = TextEditingController();
    _loadClubs();
  }

  @override
  void dispose() {
    _distanceController.dispose();
    super.dispose();
  }

  void _loadClubs() {
    // Manuelle Definition der Golfschläger
    _clubs = [
      GolfClub(
        name: '56er - Chip',
        gripType: 'Chip',
        swingStrength: '9 Uhr',
        carryDistance: 1,
        totalDistance: 4,
      ),
      GolfClub(
        name: '56er - Chip',
        gripType: 'Chip',
        swingStrength: '8 Uhr',
        carryDistance: 3,
        totalDistance: 6,
      ),
      GolfClub(
        name: '56er - Chip',
        gripType: 'Chip',
        swingStrength: '9 Uhr',
        carryDistance: 5,
        totalDistance: 10,
      ),
      GolfClub(
        name: '56er - Chip',
        gripType: 'Chip',
        swingStrength: '10 Uhr',
        carryDistance: 10,
        totalDistance: 18,
      ),
      GolfClub(
        name: '56er - Chip',
        gripType: 'Chip',
        swingStrength: '11 Uhr',
        carryDistance: 15,
        totalDistance: 25,
      ),
      GolfClub(
        name: '56er - Pitchen',
        gripType: 'kurz+offen',
        swingStrength: '9 Uhr',
        carryDistance: 20,
        totalDistance: 25,
      ),
      GolfClub(
        name: '56er - Pitchen',
        gripType: 'kurz',
        swingStrength: '9 Uhr',
        carryDistance: 35,
        totalDistance: 40,
      ),
      GolfClub(
        name: '56er - Pitchen',
        gripType: 'Standard',
        swingStrength: '9 Uhr',
        carryDistance: 30,
        totalDistance: 45,
      ),
      GolfClub(
        name: '56er',
        gripType: 'kurz',
        swingStrength: 'halb',
        carryDistance: 40,
        totalDistance: 45,
      ),
      GolfClub(
        name: '56er',
        gripType: 'Standard',
        swingStrength: 'halb',
        carryDistance: 58,
        totalDistance: 65,
      ),
      GolfClub(
        name: '56er',
        gripType: 'Standard',
        swingStrength: 'voll',
        carryDistance: 66,
        totalDistance: 75,
      ),
      GolfClub(
        name: 'PW',
        gripType: 'tief',
        swingStrength: 'voll',
        carryDistance: 77,
        totalDistance: 85,
      ),
      GolfClub(
        name: 'PW',
        gripType: 'Standard',
        swingStrength: 'voll',
        carryDistance: 95,
        totalDistance: 105,
      ),
      GolfClub(
        name: 'Eisen 9',
        gripType: 'Standard',
        swingStrength: 'voll',
        carryDistance: 115,
        totalDistance: 125,
      ),
      GolfClub(
        name: 'Eisen 8',
        gripType: 'Standard',
        swingStrength: 'voll',
        carryDistance: 138,
        totalDistance: 145,
      ),
      GolfClub(
        name: 'Eisen 7',
        gripType: 'Standard',
        swingStrength: 'voll',
        carryDistance: 150,
        totalDistance: 160,
      ),
      GolfClub(
        name: 'Eisen 6',
        gripType: 'Standard',
        swingStrength: 'voll',
        carryDistance: 155,
        totalDistance: 170,
      ),
      // Weitere Golfschläger hier hinzufügen...
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Golf Club Recommendation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _distanceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Distance (m)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final distance = int.tryParse(_distanceController.text) ?? 0;
                final recommendations = _getRecommendedClubs(distance);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Recommended Golf Clubs'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: recommendations.map((club) {
                            return ListTile(
                              title: Text('Name: ${club.name}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Grip Type: ${club.gripType}'),
                                  Text('Swing Strength: ${club.swingStrength}'),
                                  Text('Carry Distance: ${club.carryDistance}m'),
                                  Text('Total Distance: ${club.totalDistance}m'),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Get Recommendations'),
            ),
          ],
        ),
      ),
    );
  }

  List<GolfClub> _getRecommendedClubs(int distance) {
    if (distance <= 0) {
      return [];
    }

    _clubs.sort((a, b) => (a.totalDistance - distance).abs().compareTo((b.totalDistance - distance).abs()));

    return _clubs.take(2).toList();
  }
}