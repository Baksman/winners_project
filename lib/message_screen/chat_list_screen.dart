// import 'package:flutter/material.dart';
// import 'package:project/message_screen/message.dart';
// import 'package:project/model/user_model.dart';
// import 'package:project/ui/utils/color_utils.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:project/ui/utils/log_utils.dart';
// import 'package:provider/provider.dart';

// class ChatHome extends StatefulWidget {
//   final String currentUserId;

//   ChatHome({Key key, @required this.currentUserId}) : super(key: key);

//   @override
//   State createState() => ChatHomeState(currentUserId: currentUserId);
// }

// class ChatHomeState extends State<ChatHome> {
//   ChatHomeState({Key key, @required this.currentUserId});

//   String currentUserId;
//   // final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//   // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   // final GoogleSignIn googleSignIn = GoogleSignIn();
//   final ScrollController listScrollController = ScrollController();

//   int _limit = 20;
//   int _limitIncrement = 20;
//   bool isLoading = false;
//   // List<Choice> choices = const <Choice>[
//   //   const Choice(title: 'Settings', icon: Icons.settings),
//   //   const Choice(title: 'Log out', icon: Icons.exit_to_app),
//   // ];
//   @override
//   void initState() {
//     currentUserId = Provider.of<AppUser>(context, listen: false).uuid;
//     super.initState();
//   }

//   void scrollListener() {
//     if (listScrollController.offset >=
//             listScrollController.position.maxScrollExtent &&
//         !listScrollController.position.outOfRange) {
//       setState(() {
//         _limit += _limitIncrement;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Theme.of(context).primaryColor;
//     final double statusbarHeight = MediaQuery.of(context).padding.top;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(
//       //   elevation: 0,
//       //   automaticallyImplyLeading: false,
//       //   backgroundColor: Colors.white,
//       //   centerTitle: true,
//       //   flexibleSpace: Icon(Icons.mail),
//       //   title: Text(
//       //     "Messages",
//       //     style: TextStyle(color: Colors.black),
//       //   ),
//       // ),
//       appBar: PreferredSize(
//         preferredSize: Size(double.infinity, statusbarHeight + 50),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.only(top: statusbarHeight),
//               height: statusbarHeight + 30,
//               child: Text(
//                 "Messages",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25),
//               child: Container(
//                 margin: EdgeInsets.only(right: 10, left: 10),
//                 padding: EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                   color: Color.fromRGBO(234, 237, 247, 0.45),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: TextFormField(
//                   // controller: _emailController,
//                   onSaved: (value) {
//                     // _useremail = value;
//                   },
//                   decoration: InputDecoration(
//                       hintText: 'Search',
//                       hintStyle: TextStyle(
//                         fontSize: 14,
//                         color: Color(0xff2C3D57).withOpacity(0.46),
//                       ),
//                       suffixIcon: IconButton(
//                         onPressed: () {},
//                         // onPressed: _controller.clear,
//                         icon: Icon(Icons.search),
//                       ),
//                       border: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       errorBorder: InputBorder.none,
//                       disabledBorder: InputBorder.none,
//                       contentPadding: EdgeInsets.all(10)),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           // List
//           Container(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('users')
//                   .limit(_limit)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//                     ),
//                   );
//                 } else {
//                   return ListView.separated(
//                     separatorBuilder: (ctx, index) {
//                       return Divider();
//                     },
//                     padding: EdgeInsets.all(10.0),
//                     itemBuilder: (context, index) =>
//                         buildItem(context, snapshot.data.documents[index]),
//                     itemCount: snapshot.data.documents.length,
//                     controller: listScrollController,
//                   );
//                 }
//               },
//             ),
//           ),

//           // Loading
//           Positioned(
//             child: isLoading ? const CircularProgressIndicator() : Container(),
//           )
//         ],
//       ),
//     );
//   }

//   List<QueryDocumentSnapshot> listMessage = new List.from([]);
//   Widget buildItem(BuildContext context, DocumentSnapshot document) {
//     if (document.id == currentUserId) {
//       return Container();
//     } else {
//       String peerId = document.id;
//       logger.d("peer id $peerId");
//       String groupChatId;
//       if (currentUserId.hashCode <= peerId.hashCode) {
//         groupChatId = '$currentUserId-$peerId';
//       } else {
//         groupChatId = '$peerId-$currentUserId';
//       }
//       return Container(
//         child: FlatButton(
//           child: Row(
//             children: <Widget>[
//               Material(
//                 child: document.data()['photoUrl'] != null
//                     ? CachedNetworkImage(
//                         placeholder: (context, url) => Container(
//                           child: CircularProgressIndicator(
//                             strokeWidth: 1.0,
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(primaryColor),
//                           ),
//                           width: 40.0,
//                           height: 40.0,
//                           padding: EdgeInsets.all(15.0),
//                         ),
//                         imageUrl: document.data()['photoUrl'],
//                         width: 40.0,
//                         height: 40.0,
//                         fit: BoxFit.cover,
//                       )
//                     : Icon(
//                         Icons.account_circle,
//                         size: 40.0,
//                         color: Colors.grey,
//                       ),
//                 borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                 clipBehavior: Clip.hardEdge,
//               ),
//               Flexible(
//                 child: Container(
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         child: Text(
//                           document.data()['firstname'] ?? "No name",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         alignment: Alignment.centerLeft,
//                         margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
//                       ),
//                       Container(
//                         height: 20,
//                         child: StreamBuilder<QuerySnapshot>(
//                             stream: FirebaseFirestore.instance
//                                 .collection('messages')
//                                 .doc(groupChatId)
//                                 .collection(groupChatId)
//                                 .orderBy('timestamp', descending: true)
//                                 .limit(1)
//                                 .snapshots(),
//                             builder: (context, snapshot) {
//                               if (!snapshot.hasData) {
//                                 return LinearProgressIndicator();
//                               }
//                               QuerySnapshot qs = snapshot.data;
//                               listMessage.addAll(snapshot.data.docs);
//                               logger.d(groupChatId);
//                               logger.d(listMessage.length);
//                               // QuerySnapshot qs = snapshot.data;
//                               // int le = qs.docs.length;
//                               // logger.d(le);
//                               logger.d(listMessage.length);
//                               if (qs.docs.isEmpty) {
//                                 return Offstage();
//                               }
//                               return qs.docs[0].data()["type"] == 0
//                                   ? Text(
//                                       '${qs.docs[0].data()["content"] ?? 'Lorem ipsum'}',
//                                       style: TextStyle(color: Colors.black),
//                                     )
//                                   : Row(
//                                       children: [
//                                         Icon(
//                                           Icons.image,
//                                           color: Colors.grey,
//                                         ),
//                                         SizedBox(
//                                           width: 5,
//                                         ),
//                                         Text(
//                                           "image",
//                                           style: TextStyle(color: Colors.grey),
//                                         )
//                                       ],
//                                     );
//                             }),
//                         alignment: Alignment.centerLeft,
//                         margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
//                       )
//                     ],
//                   ),
//                   margin: EdgeInsets.only(left: 20.0),
//                 ),
//               ),
//             ],
//           ),
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => Chat(
//                           peerId: document.id ?? "new",
//                           peerAvatar: document.data()['photoUrl'],
//                         )));
//           },
//           color: Colors.white,
//           padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//         ),
//         margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
//       );
//     }
//   }
// }

// // class Choice {
// //   const Choice({this.title, this.icon});

// //   final String title;
// //   final IconData icon;
// // }
