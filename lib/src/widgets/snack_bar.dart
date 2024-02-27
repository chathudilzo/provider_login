// Widget MySnackBar(){
//   returnfinal snackBar = SnackBar(
//                   /// need to set following properties for best effect of awesome_snackbar_content
//                   elevation: 0,
//                   behavior: SnackBarBehavior.floating,
//                   backgroundColor: Colors.transparent,
//                   content: AwesomeSnackbarContent(
//                     title: 'On Snap!',
//                     message:
//                         'This is an example error message that will be shown in the body of snackbar!',

//                     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//                     contentType: ContentType.failure,
//                   ),
//                 );

//                 ScaffoldMessenger.of(context)
//                   ..hideCurrentSnackBar()
//                   ..showSnackBar(snackBar);
// }