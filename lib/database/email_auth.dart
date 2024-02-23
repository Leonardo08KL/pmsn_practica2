import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class EmailAuth {
  static final NAMEDB = 'usuario';
  static final VERSIONDB = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, NAMEDB);
    return openDatabase(
      pathDB,
      version: VERSIONDB,
      onCreate: (db, version) {
        String query = '''CREATE TABLE User (
          idUsuario INTERGER PRIMARY KEY,
          Name VARCHAR(30),
          Correo VARCHAR(50),
          Contrasena VARCHAR(50),
          )''';

        db.execute(query);
      },
    );
  }

  Future<int> INSERTAR(Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.insert('User', data);
  }

//   final emailAuth = null;
// //   static const String CLIENT_ID = "15b6215cdb2ddf501d02";
// //   static const String CLIENT_SECRET =
// //       "cbc86513e9eabaf92d45332bd1ce6f9e3d9c21f9";

//   Future<bool> createUserWithEmailAndPassword(
//       {required String email, required String password}) async {
//     try {
//       final userCredential = await emailAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       userCredential.user!.sendEmailVerification();
//       return true;
//     } catch (e) {}
//     return false;
//   }

//   Future<String> getUserToken() async {
//     String token = '';
//     try {
//       User? user = emailAuth.currentUser;
//       if (user != null) {
//         //token = await user.getIdToken();
//       }
//     } catch (e) {}
//     return token;
//   }

//   Future<bool> signInWithEmailAndPassword(
//       {required String email, required String password}) async {
//     try {
//       final userCredential = await emailAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//       if (userCredential.user!.emailVerified) return true;
//     } on FirebaseAuthException {
//     } catch (e) {}
//     return false;
//   }

//   Future<bool> sendResetPasswordLink({required String email}) async {
//     try {
//       final userCredential =
//           await emailAuth.sendPasswordResetEmail(email: email);
//       return true;
//     } on FirebaseException {
//     } catch (e) {}
//     return false;
//   }

//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       if (kIsWeb) {
//         GoogleAuthProvider googleProvider = GoogleAuthProvider();

//         googleProvider
//             .addScope("https://www.googleapis.com/auth/contacts.readonly");

//         await emailAuth.signInWithPopup(googleProvider);
//       } else {
//         final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//         final GoogleSignInAuthentication? googleAuth =
//             await googleUser?.authentication;

//         if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
//           final credential = GoogleAuthProvider.credential(
//             accessToken: googleAuth?.accessToken,
//             idToken: googleAuth?.idToken,
//           );

//           UserCredential userCredential =
//               await emailAuth.signInWithCredential(credential);
//         }
//       }
//     } on FirebaseAuthException {
//     } catch (e) {
//       print('Error');
//     }
//   }

//   Future<User> signInWithGithub(String code) async {
//     final response = await http.post(
//       "https://github.com/login/oauth/access_token" as Uri,
//       headers: {
//         "Content-Type": "application/json",
//         "Accept": "application/json"
//       },
//       body: jsonEncode(GitHubLoginRequest(
//         clientId: CLIENT_ID,
//         clientSecret: CLIENT_SECRET,
//         code: code,
//       )),
//     );

//     GitHubLoginResponse loginResponse =
//         GitHubLoginResponse.fromJson(json.decode(response.body));

//     final AuthCredential credential =
//         GithubAuthProvider.credential(loginResponse.accessToken!);

//     final User user = (await emailAuth.signInWithCredential(credential)).user!;
//     return user;
//   }

//   Future<void> signOut() async {
//     try {
//       await emailAuth.signOut();
//       //await FirebaseAuth.instance.setPersistence(Persistence.NONE);
//     } on FirebaseAuthException {
//     } catch (e) {}
//   }

//   getCurrentUser(String email, String pwd) async {
//     final user = await emailAuth.currentUser;
//     final uid = user?.uid;
//     // Similarly we can get email as well
//     //final uemail = user.email;
//     print(uid);
//     //print(uemail);
//   }
}
