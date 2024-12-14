import 'package:account_picker/account_picker.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:mobile_number/sim_card.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = (await MobileNumber.mobileNumber)!;
      _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    _mobileNumber = mobileNumber;
  }

  void checkPermission() async {
    final isPermissionGranted = await MobileNumber.hasPhonePermission;

    if (isPermissionGranted) {
      getSimData();
    } else {
      requestPermission();
    }
  }

  void requestPermission() async {
    await MobileNumber.requestPhonePermission;
    checkPermission();
  }

  void getSimData() async {
    try {
      final mobileNumber = await MobileNumber.mobileNumber ?? '';
      final simCards = await MobileNumber.getSimCards ?? [];
      print(simCards);
      List<String> numbers =
          simCards.map((SimCard sim) => '${sim.number}').toList();

      emit(AuthSimNumberListSuccess(numbers));
    } on PlatformException catch (e) {
      print("Failed to get mobile number because of '${e.message}'");
    }
  }

  Future<void> fetchAccounts() async {
    try {
      emit(GoogleSignInLoading());
      final EmailResult? emailResult = await AccountPicker.emailHint();
      emit(GoogleSignInAccountsFetched(accounts: emailResult));
    } catch (e) {
      emit(GoogleSignInError(message: e.toString()));
    }
  }

  Future<void> googleSignIn() async {
    emit(GoogleSignInLoading());

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        emit(GoogleSignInSuccess());
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());

    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    emit(AuthLoading());

    try {
      print(phoneNumber);
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          final User? user = userCredential.user;

          if (user != null) {
            emit(Authenticated(user));
          } else {
            emit(Unauthenticated());
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthError(e.message!));
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(AuthCodeSent(verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifySMSCode(String verificationId, String smsCode) async {
    emit(AuthLoading());

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
