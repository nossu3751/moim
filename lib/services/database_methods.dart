import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByName(String college, String name) {
    return Firestore.instance
        .collection(college)
        .document('path')
        .collection('users')
        .where('name', isEqualTo: name)
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

  uploadUserInfo(String college, userMap) {
    Firestore.instance
        .collection(college)
        .document('path')
        .collection('users')
        .add(userMap)
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
}
