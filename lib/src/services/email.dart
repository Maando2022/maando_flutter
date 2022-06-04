
// // https://stackoverflow.com/questions/58731933/flutter-mailer-isnt-working-due-to-these-errors
// // https://myaccount.google.com/lesssecureapps

// class EmailService {
//   sendMail() async {
//     // Setting up Google SignIn
//     // final googleSignIn = GoogleSignIn.standard(
//     //     scopes: ['email', 'https://www.googleapis.com/auth/gmail.send']);

//     // // Signing in
//     // final account = await googleSignIn.signIn();

//     // if (account == null) {
//     //   // User didn't authorize
//     //   return;
//     // }

//     String username = 'davgui242011@gmail.com';
//     String password = 'Zkmt3h9yxg*';

//     final smtpServer = gmail(username, password);

//     final message = Message()
//       ..from = Address(username, 'Your name')
//       ..recipients.add('davgui242011@gmail.com')
//       ..ccRecipients.addAll(['davgui242011@gmail.com'])
//       ..bccRecipients.add(Address('davgui242011@gmail.com'))
//       ..subject = 'Prueba :: 😀 :: ${DateTime.now()}'
//       ..text = 'Esta es una prueba'
//       ..html =
//           "<h1>Esta es una prueba</h1>\n<p>Esta es una prueba de correo electrónico</p>";

//     try {
//       final sendReport = await send(message, smtpServer);
//       print('Message sent: ' + sendReport.toString());
//     } on MailerException catch (e) {
//       print('Message not sent.  ${e.message}');
//       for (var p in e.problems) {
//         print('Problem: ${p.code}: ${p.msg}');
//       }
//     }
//   }

//   //************************************************************************* */
//   // new api_key Rf6zAt
//   // enviarMail(String email) {
//   //   Http _http = Http();
//   //   // _http.email(api_key: 'pk_e3498e606b2aab90191f8c6b93cd68a5fb', profiles: [
//   //   _http.senderEmailRegister(api_key: 'pk_55fde6f3042687a2426133daeab58310d0', profiles: [
//   //     {
//   //       "email": email,
//   //       "phone_number": "+573227387867",
//   //       "sms_consent": true,
//   //       "example_property": "valueB"
//   //     }
//   //   ]).then((value) {
//   //     print('EL EMAIL ENVIDO $value');
//   //   });
//   // }
// }

// EmailService emailService = EmailService();
