import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_data.dart';

Future<void> migrateDataToFirestore() async {
  final db = FirebaseFirestore.instance;

  for (final product in AppData.dummyProducts) {
    await db.collection('products').doc(product.id).set(product.toMap());
  }

  print('Migration complete');
}
