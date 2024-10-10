import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:le_cocon_ssbe/data/domain/entities/avis_clients/avis_clients.dart';
import 'package:le_cocon_ssbe/ui/avis_des_clients/avis_clients_list/view/recup_avis_client.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class AvisClientsView extends StatelessWidget {
  const AvisClientsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('avis_clients')
          .orderBy('publishDate', descending: true)
          .limit(3)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No reviews available');
        }

        List<AvisClients> avis = snapshot.data!.docs
            .map((doc) => AvisClients.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList();

        return LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Les clients nous donne leurs avis',
                  style: titleStyleMedium(context).copyWith(fontSize: size.width /15),
                  ),
                  // Top bubble
                  SizedBox(
                    width: constraints.maxWidth * 0.4,
                    child: RecupAvisClients(avis: avis[0]),
                  ),
                  SizedBox(height: 20), // Space between rows
                  // Bottom two bubbles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.4,
                        child: avis.length > 1 ? RecupAvisClients(avis: avis[1]) : SizedBox(),
                      ),
                      SizedBox(width: 20), // Space between bubbles
                      SizedBox(
                        width: constraints.maxWidth * 0.4,
                        child: avis.length > 2 ? RecupAvisClients(avis: avis[2]) : SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),

            );

          },
        );
      },

    );
  }
}