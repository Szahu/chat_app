import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/services/auth_service.dart';

class DataBaseService {
  static final DataBaseService _instance = DataBaseService._internal();

  DataBaseService._internal();

  factory DataBaseService() {
    return _instance;
  }

  final _dataBase = Firestore.instance;
  final _usersCollection = Firestore.instance.collection('users');
  final _convsDataCollection =
      Firestore.instance.collection('conversation_data');

  void createUserData(String uid) {
    _usersCollection.document(uid).setData({
      'name': 'new name',
      'conversation_refrences': [],
      'profile_picture': 'emptyUrl'
    });
  }

  void updateUserData(
      String uid, String name, String profile_pic_url, List<String> conv_refs) {
    _usersCollection.document(uid).updateData({
      'name': name ?? 'nameWasNull',
      'conversation_refrences': conv_refs ?? [],
      'profile_picture': profile_pic_url ?? 'urlWasNull'
    });
  }

  void createChatRoom(List<User> users) async {
    String newConvRef;
    List<String> userUids = List<String>();
    users.forEach((element) {
      userUids.add(element.uid);
    });
    await _convsDataCollection.add({
      'users': ['essa1', 'essa2'],
    }).then((docRef) {
      newConvRef = docRef.path;
    }).catchError((error) => print(error.toString()));

    users.forEach((user) async {
      List<dynamic> refList;
      await _usersCollection
          .document(user.uid)
          .get()
          .then((doc) => refList = doc.data['conversation_refrences'])
          .catchError((error) => print(error.toString()));
      refList.add(newConvRef);
      await _usersCollection
          .document(user.uid)
          .updateData({'conversation_refrences': refList}).catchError(
              (error) => print(error.toString()));
    });
  }

  void sentMessageToChatRoom(
      String sendersUid, String chatRoomPath, String message) async {
    await _dataBase
        .collection(chatRoomPath.split('/')[0])
        .document(chatRoomPath.split('/')[1])
        .collection('messages')
        .add({
      'message': message,
      'sender:': sendersUid,
      'timeStamp': DateTime.now().toString()
    });
  }
}
