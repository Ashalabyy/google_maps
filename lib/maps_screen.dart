import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps/maps_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MapsScreen extends StatefulWidget {
  static const routeName = '/MapsScreen';
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  static Position? positions;
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _mycurrentlocationCameraposition = CameraPosition(
    bearing: 0.0,
    zoom: 16,
    target: LatLng(positions!.latitude, positions!.longitude),
    tilt: 0.0,
  );

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_mycurrentlocationCameraposition),
    );
  }

  @override
  void didChangeDependencies() async {
    await Provider.of<MapsRepo>(context, listen: false).getLocation().then(
        (_) async {
      positions = await Geolocator.getLastKnownPosition().whenComplete(() {
        setState(() {});
      });
    }, onError: (err) {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          positions != null
              ? buildMap()
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(8),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: _goToMyCurrentLocation,
          child: const Icon(
            Icons.place,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  //build Map Ui
  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: _mycurrentlocationCameraposition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
