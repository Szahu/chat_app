import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/services/auth_service.dart';

class UserData {
  final profile_picture;
  final name;
  final uid;
  UserData({this.name, this.profile_picture, this.uid});
}

class MessageData {
  final String sender;
  final String message;
  final String timeStamp;
  MessageData({this.sender, this.message, this.timeStamp});
}

class ConversationData {
  List<dynamic> users_uids;
  Stream<List<MessageData>> messagesStream;
  String documentPath;
  ConversationData({this.users_uids, this.messagesStream, this.documentPath});
}

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

  List<UserData> _userDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
          name: doc.data['name'],
          profile_picture: doc.data['profile_picture'],
          uid: doc.data['uid']);
    }).toList();
  }

  Stream<List<UserData>> get usersData {
    return _usersCollection.snapshots().map(_userDataFromSnapshot);
  }

  List<MessageData> _messageDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return MessageData(
          message: doc.data['message'],
          timeStamp: doc.data['timeStamp'],
          sender: doc.data['sender']);
    }).toList();
  }

  List<ConversationData> _convDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ConversationData(
          users_uids: doc.data['users'],
          messagesStream: doc.reference
              .collection('messages')
              .snapshots()
              .map(_messageDataFromSnapshot),
          documentPath: doc.reference.path);
    }).toList();
  }

  Stream<List<ConversationData>> getConvData(dynamic uid) {
    return _convsDataCollection
        .where('users', arrayContains: uid)
        .snapshots()
        .map(_convDataFromSnapshot);
  }

  void createUserData(String uid) {
    _usersCollection.document(uid).setData({
      'name': 'new name',
      'conversation_refrences': [],
      'profile_picture': 'emptyUrl',
      'uid': uid
    });
  }

  void updateUserData(
      {String uid,
      String name,
      String profile_pic_url,
      List<String> conv_refs}) {
    _usersCollection.document(uid).updateData({
      'name': name ?? 'nameWasNull',
      'conversation_refrences': conv_refs ?? [],
      'profile_picture': profile_pic_url ?? 'urlWasNull'
    });
  }

  void updateUserName(uid, {String name}) {
    _usersCollection.document(uid).updateData({
      'name': name ?? 'nameWasNull',
    });
  }

  Future<UserData> getUserData(String uid) async {
    String _name;
    String _profile_picture;
    String _uid;
    await _usersCollection.document(uid).get().then((doc) {
      _name = doc.data['name'];
      _profile_picture = doc.data['profile_picture'];
      _uid = uid;
    });
    return UserData(name: _name, profile_picture: _profile_picture, uid: _uid);
  }

  void createChatRoom(List<User> users) async {
    String newConvRef;
    List<String> userUids = List<String>();
    users.forEach((element) {
      userUids.add(element.uid);
    });
    print(userUids);
    await _convsDataCollection.add({
      'users': users.map((e) {
        return e.uid;
      }).toList(),
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
      'sender': sendersUid,
      'timeStamp': DateTime.now()
          .difference(DateTime.utc(2020, 5, 7, 12, 00))
          .inSeconds
          .toString()
    });
  }

  /*Future<List<ConversationData>> getConversations(String uid) async {
    List<String> refs = List<String>();
    await _usersCollection.document(uid).get().then((doc) {
      refs = doc.data['conversation_refrences'];
    }).catchError((e) {
      print(e.toString());
    });

    List<ConversationData> convs = List<ConversationData>();

    refs.forEach((ref) async {
      ConversationData convData;
      await _dataBase
          .collection(ref.split('/')[0])
          .document(ref.split('/')[1])
          .get()
          .then((doc) {
        convData.users_uids = doc.data['users'];
      });
      await _dataBase
          .collection(ref.split('/')[0])
          .document(ref.split('/')[1])
          .collection('messages')
          .getDocuments()
          .then((doc) {convData.messages.});
    });
  }*/
}
