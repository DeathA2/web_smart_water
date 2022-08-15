import 'dart:async';

class LoadingStream {
  bool isLoading = false;
  StreamController listController =  StreamController<bool>.broadcast();

  Stream get rebuildStream =>
      listController.stream.transform(rebuildTranformer);

  var rebuildTranformer =
  StreamTransformer<bool, bool>.fromHandlers(handleData: (data, sink) {
    sink.add(data);
  });

  void loading(bool data) {
    isLoading = data;
    listController.sink.add(loading);
  }

  void dispose() {
    listController.close();
  }
}
