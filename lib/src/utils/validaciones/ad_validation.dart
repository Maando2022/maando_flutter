import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:maando/src/utils/textos/ads_text.dart';

class AdValidation {
  final validarTitle =
      StreamTransformer<String, String>.fromHandlers(handleData: (title, sink) {
    if (title.trim().length >= 2 && title.trim().length < 13) {
      sink.add(title);
    } else {
      sink.addError(
          'Enter minimum 2 characters: takes: ' + title.length.toString());
    }
  });

// ---------------------------------------
  final validarDateTime =
      StreamTransformer<DateTime, DateTime>.fromHandlers(handleData: (dateTime, sink) {
    if (dateTime.toString().length >= 3) {
      sink.add(dateTime);
    } else {
      sink.addError(
          'Error');
    }
  });
  // ---------------------------------------
  final validarCountryCity =
      StreamTransformer<String, String>.fromHandlers(handleData: (countryCity, sink) {
    if (countryCity.trim().length >= 3) {
      sink.add(countryCity);
    } else {
      sink.addError(
          'Enter minimum 6 characters: takes: ' + countryCity.length.toString());
    }
  });
// ---------------------------------------
  final validarImages =
      StreamTransformer<List<PickedFile>, List<PickedFile>>.fromHandlers(
          handleData: (images, sink) {
    bool validacion = false;

    for (PickedFile file in images) {
      if (file.runtimeType == PickedFile) {
        validacion = true;
      } else {
        validacion = false;
      }
    }

    if (validacion) {
      sink.add(images);
    } else {
      sink.addError('No image.');
    }
  });

  // ----------------------------------------
  final validarKindOfPackage = StreamTransformer<String, String>.fromHandlers(
      handleData: (kindOfPackage, sink) {
    if (kindOfPackage.length >= 3) {
      sink.add(kindOfPackage);
    } else {
      sink.addError('Enter minimum 3 characters: takes: ' +
          kindOfPackage.length.toString());
    }
  });

  // *********************************
  final validarPlaceOfDelivery = StreamTransformer<String, String>.fromHandlers(
      handleData: (placeOfDelivery, sink) {
    if (placeOfDelivery.trim().length <= 150 && placeOfDelivery.trim().length > 2) {
      sink.add(placeOfDelivery);
    } else {
      sink.addError('Enter minimum 150 characters: takes: ' +
          placeOfDelivery.length.toString());
    }
  });
}

// *********************************
final validarDescription = StreamTransformer<String, String>.fromHandlers(
    handleData: (description, sink) {
  if (description.trim().length <= 50) {
    sink.add(description);
  } else {
    sink.addError(
        'Enter minimum 50 characters: takes: ' + description.length.toString());
  }
});

// *********************************
final validarHeightWidthLongWeight =
    StreamTransformer<String, String>.fromHandlers(
        handleData: (heightWidthLongWeight, sink) {
  if (isNumber(heightWidthLongWeight)) {
    sink.add(heightWidthLongWeight);
  } else {
    sink.addError(adsText.validateNumber());
  }
});
final validarPrice =
    StreamTransformer<String, String>.fromHandlers(handleData: (price, sink) {
      bool validate = false;
      try{ validate = (int.parse(price).runtimeType == int); }catch(e){ validate = false; }

  if (isNumber(price) && validate) {
    sink.add(price);
  } else {
    sink.addError(adsText.validateNumber());
  }
});

bool isNumber(String p) {
  if (p.isEmpty) return false;
  final n = num.tryParse(p);

  return (n == null) ? false : true;
}