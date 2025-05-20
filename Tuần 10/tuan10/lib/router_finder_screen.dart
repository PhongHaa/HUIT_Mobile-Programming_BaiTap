import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteFinderScreen extends StatefulWidget {
  @override
  _RouteFinderScreenState createState() => _RouteFinderScreenState();
}

class _RouteFinderScreenState extends State<RouteFinderScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  LatLng? _startLatLng;
  LatLng? _endLatLng;
  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(10.7769, 106.7009), // TP.HCM mặc định
    zoom: 12,
  );
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Lấy vị trí hiện tại
  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _startLatLng = LatLng(position.latitude, position.longitude);
      _addMarker(_startLatLng!, "Xuất phát");
      _moveCamera(_startLatLng!);
      _startController.text = "${position.latitude}, ${position.longitude}";
    });
  }

  // Thêm marker
  void _addMarker(LatLng position, String markerId) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          infoWindow: InfoWindow(title: markerId),
        ),
      );
    });
  }

  // Di chuyển camera
  Future<void> _moveCamera(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }

  // Tìm đường đi
  Future<void> _findRoute() async {
    if (_startController.text.isEmpty || _endController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Vui lòng nhập cả hai điểm!')));
      return;
    }
    List<String> start = _startController.text.split(',');
    List<String> end = _endController.text.split(',');
    _startLatLng = LatLng(double.parse(start[0]), double.parse(start[1]));
    _endLatLng = LatLng(double.parse(end[0]), double.parse(end[1]));
    String apiKey =
        "AIzaSyBIBJ_OiUwOLzv2J_jqDk0PvqKhLjq5UrE"; // Thay bằng API Key
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${_startLatLng!.latitude},${_startLatLng!.longitude}&destination=${_endLatLng!.latitude},${_endLatLng!.longitude}&key=$apiKey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['routes'] != null && data['routes'].isNotEmpty) {
        String polylinePoints =
            data['routes'][0]['overview_polyline']['points'];
        List<LatLng> points = _decodePolyline(polylinePoints);
        setState(() {
          _markers.clear();
          _addMarker(_startLatLng!, "Xuất phát");
          _addMarker(_endLatLng!, "Đích đến");
          _polylines.clear();
          _polylines.add(
            Polyline(
              polylineId: PolylineId('route'),
              points: points,
              color: Colors.blue,
              width: 5,
            ),
          );
          _moveCamera(_startLatLng!);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không tìm thấy tuyến đường nào!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi gọi API: ${response.statusCode}')),
      );
    }
  }

  // Giải mã polyline
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Route Finder')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _startController,
                  decoration: InputDecoration(
                    labelText: 'Điểm xuất phát (lat, lng)',
                  ),
                ),
                TextField(
                  controller: _endController,
                  decoration: InputDecoration(
                    labelText: 'Điểm đích (lat, lng)',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _findRoute,
                  child: Text('Tìm đường đi'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
