import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../features/authentication/models/gym_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';

class UserRepository extends GetxController {
  // --- Variables
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user record
  Future<void> saveUserRecord(GymOwnerModel owner) async {
    try {
      await _db.collection('Gyms').doc(owner.id).set(owner.toJson());
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZFormatException(e.code).message;
    } catch (e) {
      ZLogger.error(e.toString());
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateGYMRecord(GymOwnerModel owner) async {
    try {
      await _db.collection('Gyms').doc(owner.id).update(owner.toJson());
    } on FirebaseException catch (e) {
      ZLogger.error(e.toString());
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZFormatException(e.code).message;
    } catch (e) {
      ZLogger.error(e.toString());
      throw 'Something went wrong. Please try again $e';
    }
  }

  /// Functions to fetch user details based on user id
  Future<GymOwnerModel> fetchUserDetails() async {
    try {
      final userId = await FirebaseAuth.instance.currentUser!.uid;
      final documentSnapshot = await _db.collection('Gyms').doc(userId).get();
      if (documentSnapshot.exists) {
        ZLogger.info('GYM Owner Found');
        return GymOwnerModel.fromSnapshot(documentSnapshot);
      } else {
        ZLogger.error('GYM Owner Not Found');
        return GymOwnerModel.empty();
      }
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZFormatException(e.code).message;
    } catch (e) {
      ZLogger.error('Error: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  /// Functions to update user details
  Future<void> updateUserDetails(GymOwnerModel updatedModel) async {
    try {
      await _db
          .collection('Gyms')
          .doc(updatedModel.id)
          .update(updatedModel.toJson());
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Functions to update single field
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      final _userId = FirebaseAuth.instance.currentUser!.uid;
      ZLogger.info('Current User UID: $_userId');
      await _db.collection('Gyms').doc(_userId).update(json);
      ZLogger.info('Updated Successful');
    } on FirebaseException catch (e) {
      ZLogger.error("Error: $e");
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      ZLogger.error("Error: $_");
      throw ZFormatException();
    } on PlatformException catch (e) {
      ZLogger.error("Error: $e");
      throw ZFormatException(e.code).message;
    } catch (e) {
      ZLogger.error("Error: $e");
      throw 'Something went wrong. Please try again';
    }
  }

  /// Functions to update single field
  Future<void> updateSingleFieldInBankDetails(String key, String value) async {
    try {
      final _userId = FirebaseAuth.instance.currentUser!.uid;
      ZLogger.info('Current User UID: $_userId');
      await _db
          .collection('Gyms')
          .doc(_userId)
          .update({'owner_bank_details.$key': value});
      ZLogger.info('Updated Successful');
    } on FirebaseException catch (e) {
      ZLogger.error("Error: $e");
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      ZLogger.error("Error: $_");
      throw ZFormatException();
    } on PlatformException catch (e) {
      ZLogger.error("Error: $e");
      throw ZFormatException(e.code).message;
    } catch (e) {
      ZLogger.error("Error: $e");
      throw 'Something went wrong. Please try again';
    }
  }

  /// Functions to update single field
  Future<List<TransactionHistory>> fetchTransactionHistory() async {
    try {
      // Fetch the current user's UID
      final _userId = FirebaseAuth.instance.currentUser!.uid;
      if (_userId == null) {
        ZLogger.error('User ID is null. Ensure the user is authenticated.');
        return [];
      }
      ZLogger.info('Current User UID: $_userId');

      // Fetch the transaction history document
      final docSnapshot = await _db.collection('Gyms').doc(_userId).get();

      if (!docSnapshot.exists) {
        ZLogger.error('Document does not exist for User ID: $_userId');
        return [];
      }

      ZLogger.info('Fetched Successfully');

      final data = docSnapshot.data();
      ZLogger.info('History: ${data.toString()}');

      // Parse transaction history
      final transactions = (data!['transactions'] as List<dynamic>?)
          ?.map((json) => TransactionHistory.fromJson(json))
          .toList();
      return transactions ?? [];
    } on FirebaseException catch (e) {
      ZLogger.error("Error: $e");
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      ZLogger.error("Error: $_");
      throw ZFormatException();
    } on PlatformException catch (e) {
      ZLogger.error("Error: $e");
      throw ZFormatException(e.code).message;
    } catch (e) {
      ZLogger.error("Error: $e");
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> addTransactionHistory(TransactionHistory newTransaction) async {
    try {
      // Fetch the current user's UID
      final _userId = FirebaseAuth.instance.currentUser!.uid;
      if (_userId == null) {
        ZLogger.error('User ID is null. Ensure the user is authenticated.');
        return;
      }
      ZLogger.info('Current User UID: $_userId');

      // Convert the new transaction to JSON
      final newTransactionJson = newTransaction.toJson();

      // Get the user's document reference
      final docRef = _db.collection('Gyms').doc(_userId);

      // Atomically update the transactions array with the new transaction
      await docRef.update({
        'transactions': FieldValue.arrayUnion([newTransactionJson]),
        'balance': 0
      });

      ZLogger.info('Transaction added successfully: $newTransactionJson');
    } on FirebaseException catch (e) {
      ZLogger.error("Firebase Error: $e");
      throw ZFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      ZLogger.error("Platform Error: $e");
      throw ZFormatException(e.code).message;
    } catch (e) {
      ZLogger.error("Error: $e");
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Function to delete User data from Firestore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Gym').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload Profile Picture
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
