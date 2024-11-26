import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Pokemon>> fetchFavorites(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Pokemon.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Error fetching favorites: $e');
    }
  }

  Future<void> toggleFavorite(String userId, Pokemon pokemon) async {
    try {
      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(pokemon.id.toString());

      if (pokemon.isFav) {
        await docRef.delete();
        debugPrint('Favorite removed: ${pokemon.id}');
      } else {
        await docRef.set(pokemon.copyWith(isFav: true).toJson());
        debugPrint('Favorite added: ${pokemon.id}');
      }
    } catch (e) {
      throw Exception('Error toggling favorite: $e');
    }
  }
}
