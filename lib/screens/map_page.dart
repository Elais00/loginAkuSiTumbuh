import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akusitumbuh/widgets/legend_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MapsStuntingScreen(),
    );
  }
}

// ================= DATA =================

class KabupatenData {
  final String name;
  final double persenStunting;

  const KabupatenData({required this.name, required this.persenStunting});
}

final List<KabupatenData> kabupatenList = [
  KabupatenData(name: 'Bangka', persenStunting: 28.4),
  KabupatenData(name: 'Bangka Barat', persenStunting: 36.2),
  KabupatenData(name: 'Bangka Tengah', persenStunting: 26.7),
  KabupatenData(name: 'Bangka Selatan', persenStunting: 34.1),
  KabupatenData(name: 'Belitung', persenStunting: 21.3),
  KabupatenData(name: 'Belitung Timur', persenStunting: 33),
  KabupatenData(name: 'Pangkalpinang', persenStunting: 19.2),
];

// ================= SCREEN =================

class MapsStuntingScreen extends StatefulWidget {
  const MapsStuntingScreen({super.key});

  @override
  State<MapsStuntingScreen> createState() => _MapsStuntingScreenState();
}

class _MapsStuntingScreenState extends State<MapsStuntingScreen> {
  KabupatenData? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //  MAP
          Positioned.fill(
            child: GeoJsonMap(
              kabupatenList: kabupatenList,
              onTap: (data) {
                setState(() => selected = data);
              },
            ),
          ),

          /// TOP BAR
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Row(
              children: [
                _btn(Icons.arrow_back, () {
                  Navigator.pop(context);
                }),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      style: GoogleFonts.inriaSerif(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Cari lebih banyak",

                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFD6A7C9),
                        ),

                        hintStyle: GoogleFonts.inriaSerif(
                          fontSize: 15,
                          color: const Color(0xFFD6A7C9),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: Color(0xFFD6A7C9), // pink kamu
                            width: 1.5,
                          ),
                        ),
                        // biar posisi teks pas tengah
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                _btn(Icons.tune, () {
                  print("tune diklik");
                }),
              ],
            ),
          ),

          /// POPUP
          if (selected != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 150,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Text(
                  selected!.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          Positioned(left: 16, bottom: 20, child: LegendCard()),
        ],
      ),
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Color(0xFFD6A7C9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class GeoJsonMap extends StatefulWidget {
  final List<KabupatenData> kabupatenList;
  final Function(KabupatenData) onTap;

  const GeoJsonMap({
    super.key,
    required this.kabupatenList,
    required this.onTap,
  });

  @override
  State<GeoJsonMap> createState() => _GeoJsonMapState();
}

Color getColor(double persen) {
  if (persen >= 35) return const Color(0xFFB71C1C); // sangat tinggi
  if (persen >= 30) return const Color(0xFFE57373); // tinggi
  if (persen >= 20) return const Color(0xFFEF9A9A); // sedang
  return const Color(0xFFFFEBEE); // rendah
}

class _GeoJsonMapState extends State<GeoJsonMap> {
  List<Polygon> polygons = [];

  @override
  void initState() {
    super.initState();
    loadGeoJson();
  }

  Future<void> loadGeoJson() async {
    List<String> paths = [
      'assets/19.01_Bangka/19.01_Bangka.geojson',
      'assets/19.02_Belitung/19.02_Belitung.geojson',
      'assets/19.03_Bangka_Selatan/19.03_Bangka_Selatan.geojson',
      'assets/19.04_Bangka_Tengah/19.04_Bangka_Tengah.geojson',
      'assets/19.05_Bangka_Barat/19.05_Bangka_Barat.geojson',
      'assets/19.06_Belitung_Timur/19.06_Belitung_Timur.geojson',
    ];

    List<Polygon> temp = [];

    for (String path in paths) {
      final data = await rootBundle.loadString(path);
      final jsonData = json.decode(data);

      for (var feature in jsonData['features']) {
        print(feature['properties']);
        final name = feature['properties']['nm_dati2'] ?? '';

        final cleanName = name
            .toLowerCase()
            .replaceAll("kab.", "")
            .replaceAll("kabupaten", "")
            .trim();

        KabupatenData? kab;

        for (var k in widget.kabupatenList) {
          if (cleanName == k.name.toLowerCase()) {
            kab = k;
            break;
          }
        }

        if (kab == null) {
          print("TIDAK MATCH: $cleanName");
          continue;
        }

        final geometry = feature['geometry'];
        final type = geometry['type'];
        final coords = geometry['coordinates'];

        List polygonsData = [];

        if (type == 'Polygon') {
          polygonsData = [coords];
        } else if (type == 'MultiPolygon') {
          polygonsData = coords;
        }

        for (var polygon in polygonsData) {
          for (var ring in polygon) {
            List<LatLng> points = [];

            for (var point in ring) {
              points.add(LatLng(point[1], point[0]));
            }

            temp.add(
              Polygon(
                points: points,
                color: getColor(kab.persenStunting).withOpacity(0.6),
                borderColor: Colors.white,
                borderStrokeWidth: 1,
              ),
            );
          }
        }
      }
    }

    setState(() {
      polygons = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(initialCenter: LatLng(-2.5, 106.0), initialZoom: 8),
      children: [
        TileLayer(
          urlTemplate:
              "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
          subdomains: ['a', 'b', 'c', 'd'],
        ),
        PolygonLayer(polygons: polygons),
      ],
    );
  }
}
