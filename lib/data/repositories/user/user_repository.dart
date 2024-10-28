import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../features/authentication/models/gym_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../authentication/authentication_repository.dart';

class UserRepository extends GetxController {
  // --- Variables
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  GymOwnerModel gymOwner = GymOwnerModel.empty();

  /// Function to save user record
  Future<void> saveUserRecord(GymOwnerModel owner) async {
    try {
      await _db.collection('Gyms').doc(owner.id).set(owner.toJson());
      gymOwner = owner;
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
      gymOwner = owner;
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
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        gymOwner = GymOwnerModel.fromSnapshot(documentSnapshot);
        return GymOwnerModel.fromSnapshot(documentSnapshot);
      } else {
        return GymOwnerModel.empty();
      }
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

  /// Functions to update user details
  Future<void> updateUserDetails(GymOwnerModel updatedModel) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedModel.id)
          .update(updatedModel.toJson());
      gymOwner = updatedModel;
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
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .update(json);
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

  /// Function to delete User data from Firestore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
      gymOwner = GymOwnerModel.empty();
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
