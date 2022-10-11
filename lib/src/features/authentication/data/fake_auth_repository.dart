//https://codewithandrea.com/articles/flutter-repository-pattern/

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/app_user.dart';

// Use an abstract class to be able to easily switch between auth repositories based on environment variables
abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FirebaseAuthRepository implements AuthRepository {
  @override
  Stream<AppUser?> authStateChanges() {
    // TODO: implement authStateChanges
    throw UnimplementedError();
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  // TODO: implement currentUser
  AppUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

class FakeAuthRepository implements AuthRepository {
  // To check the authentication state of the user
  @override
  Stream<AppUser?> authStateChanges() => Stream.value(null); //TODO: Implememt

  @override
  AppUser? get currentUser => null; // TODO: Implement

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    // TODO: Implement
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    // TODO: Implement
  }

  @override
  Future<void> signOut() async {
    // TODO: Implement
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // The following can be be set by running the app with the following flag: --dart-define=useFakeRepos=true
  // final isFake = String.fromEnvironment("userFaleRepos") == 'true';
  const isFake = true;
  return isFake ? FakeAuthRepository() : FakeAuthRepository();
  // This allows us to easily switch between the FakeAuthRepository and Firebase without having to make any changes to the codebase.
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
