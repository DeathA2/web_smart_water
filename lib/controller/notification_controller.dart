import 'dart:async';

class PushNotificationStream {
  bool push = false;
  StreamController listController =  StreamController<bool>.broadcast();

  Stream get rebuildStream =>
      listController.stream.transform(rebuildTranformer);

  var rebuildTranformer =
  StreamTransformer<bool, bool>.fromHandlers(handleData: (data, sink) {
    sink.add(data);
  });

  void rebuildWidget(bool data) {
    push = data;
    listController.sink.add(push);
  }

  void dispose() {
    listController.close();
  }
}
