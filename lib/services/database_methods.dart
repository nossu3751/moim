import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByName(String college, String name) {
    return Firestore.instance
        .collection(college)
        .document('path')
        .collection('users')
        .where('username', isEqualTo: name)
        .getDocuments();
  }

  getUserByEmail(String college, String email) {
    return Firestore.instance
        .collection(college)
        .document('path')
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
  }

  uploadUser(String college, userMap, String email) {
    Firestore.instance
        .collection(college)
        .document('path')
        .collection('users')
        .document(email)
        .setData(userMap)
        //     .setData(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  uploadUserAccountInfo(String college, userMap, String email) {
    Firestore.instance
        .collection(college)
        .document('path')
        .collection('users')
        .document(email)
        .updateData(userMap)
        //     .setData(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String college, String chatId, chatRoomMap) {
    Firestore.instance
        .collection(college)
        .document('path')
        .collection('chatroom')
        .document(chatId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String college, String chatId, messageMap) {
    Firestore.instance
        .collection(college)
        .document('path')
        .collection('chatroom')
        .document(chatId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationLastMessage(String college, String chatId) async {
    return await Firestore.instance
        .collection(college)
        .document('path')
        .collection('chatroom')
        .document(chatId)
        .collection('chats')
        .orderBy('time', descending: false)
        .snapshots();
  }

  getConversationMessages(String college, String chatId) async {
    return await Firestore.instance
        .collection(college)
        .document('path')
        .collection('chatroom')
        .document(chatId)
        .collection('chats')
        .orderBy('time', descending: false)
        //stream of queory snapshots
        .snapshots();
  }

  getAllChatRooms(String college, String userName) async {
    return await Firestore.instance
        .collection(college)
        .document('path')
        .collection('chatroom')
        .where('users', arrayContains: userName)
        .snapshots();
  }

  getAllPosts(String college, String userName) async {
    return await Firestore.instance
        .collection(college)
        .document('path')
        .collection('post')
        .orderBy('last_created')
        .snapshots();
  }

  static Future<String> getCollegeByEmail(String email) async{
    String college;
    await Firestore.instance.collection('all_users')
        .document(email)
        .get().then((document){
          college = document.data['college'];
        }
    );
    return college;
  }
}
