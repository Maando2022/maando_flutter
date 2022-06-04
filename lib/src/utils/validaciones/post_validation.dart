import 'dart:async';


class PostValidation {

   final validarAux =
      StreamTransformer<String, String>.fromHandlers(handleData: (aux, sink) {
    if (aux.trim().length >= 1) {
      sink.add(aux);
    } else {
      sink.addError(
          'Enter minimum 1 characters: takes: ' + aux.length.toString()
          );
    }
  });

  final validarContent =
      StreamTransformer<String, String>.fromHandlers(handleData: (content, sink) {
    if (content.trim().length >= 1) {
      sink.add(content);
    } else {
      sink.addError(
        ''
          // 'Enter minimum 1 characters: takes: ' + content.length.toString()
          );
    }
  });

// ---------------------------------------
}