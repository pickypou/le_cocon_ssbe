import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final double? fontSize;
  final String assetImage;
  final String name;
  final String phone;
  final String email;
  final String address;
  final LatLng? location; // Coordonnées optionnelles pour Google Maps
  final String? website; // URL optionnelle pour le site web

  const ContactCard({
    super.key,
    required this.assetImage,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    this.location, // Peut être null pour désactiver la carte
    this.website,
    this.fontSize, // Peut être null pour désactiver le lien du site web
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double calculatedFontSize =
        fontSize ?? (size.width > 749 ? size.width / 75 : 16);
    return SizedBox(
      width: size.width * 0.3,
      child: Card(
        elevation: 0,
        color: Colors.transparent, // Fond transparent
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      assetImage,
                      fit: BoxFit.cover, // L'image couvre tout le cercle
                      width: 60, // Largeur du cercle
                      height: 60, // Hauteur du cercle
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    name,
                    style: textStyleText(context)
                        .copyWith(fontSize: calculatedFontSize),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildContactRow(context, Icons.phone, phone),
              const SizedBox(height: 8),
              _buildContactRow(context, Icons.email, email),
              const SizedBox(height: 8),
              _buildContactRow(context, Icons.location_on, address),
              if (website != null) ...[
                const SizedBox(height: 8),
                _buildWebsiteRow(context, website!),
              ],
              if (location != null) ...[
                const SizedBox(height: 16),
                // Carte Google Maps
                SizedBox(
                  height: 200, // Taille de la carte
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: location!, // Position initiale de la carte
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('locationMarker'),
                        position: location!,
                      ),
                    },
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () =>
                      _launchMapsUrl(location!.latitude, location!.longitude),
                  child: Text(
                    'Ouvrir dans Google Maps',
                    style: textStyleText(context).copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: calculatedFontSize,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactRow(BuildContext context, IconData icon, String text) {
    Size size = MediaQuery.sizeOf(context);
    double calculatedFontSize =
        fontSize ?? (size.width > 749 ? size.width / 75 : 16);

    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 8),
        Text(
          text,
          style: textStyleText(context).copyWith(fontSize: calculatedFontSize),
        ),
      ],
    );
  }

  Widget _buildWebsiteRow(BuildContext context, String website) {
    Size size = MediaQuery.sizeOf(context);
    double calculatedFontSize =
        fontSize ?? (size.width > 749 ? size.width / 75 : 14);

    return Row(
      children: [
        Icon(Icons.web, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _launchURL(website),
          child: Text(
            website,
            style: textStyleText(context).copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: calculatedFontSize,
              decoration: TextDecoration
                  .underline, // Pour montrer qu'il s'agit d'un lien
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url); // Convertir l'URL en URI
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossible d\'ouvrir le lien $url';
    }
  }

  Future<void> _launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossible d\'ouvrir Google Maps';
    }
  }
}
