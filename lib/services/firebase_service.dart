import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> saveAnalysisToFirebase(String userId, Map<String, dynamic> data) async {
    await _firestore.collection('members').doc(userId).set(data, SetOptions(merge: true));
  }

  static Future<Map<String, dynamic>?> getAnalysisIfExists(String userId) async {
    final doc = await _firestore.collection('members').doc(userId).get();
    return doc.exists ? doc.data() : null;
  }

  static Future<void> saveRatingToFirebase(String userId, int stars) async {
    final docRef = _firestore.collection("ratings").doc(userId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (snapshot.exists) {
        final data = snapshot.data()!;
        final currentTotal = (data['total'] ?? 0) + stars;
        final currentCount = (data['count'] ?? 0) + 1;
        transaction.update(docRef, {
          'total': currentTotal,
          'count': currentCount,
          'average_rating': currentTotal / currentCount,
        });
      } else {
        transaction.set(docRef, {
          'total': stars,
          'count': 1,
          'average_rating': stars.toDouble(),
        });
      }
    });
  }

  static Future<double?> getUserRating(String userId) async {
    final doc = await _firestore.collection("ratings").doc(userId).get();
    return doc.exists ? (doc.data()?['average_rating'] ?? 0.0) : null;
  }
}
