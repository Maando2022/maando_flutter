class ConvertListElementsString {
  String convetirListaElementosString(List<String> listaElementos) {
    String string = '';
    if (listaElementos.length > 0) {
      for (var elemento in listaElementos) {
        string = string + '$elemento, ';
      }
      // return string;
    } else if (listaElementos.length > 1) {
      for (var elemento in listaElementos) {
        string = string + '$elemento, ';
      }
      // return string;
    } else {
      // return string;
    }
    string = string.substring(0, string.length - 2);
    // print('Listasssss  $string');
    return string;
  }

  String convertCodePackageToDescription(String code) {
    if (code == 'Package-Handybag') {
      return 'Handybag';
    } else if (code == 'Package-Compact') {
      return 'Compact';
    } else {
      return '';
    }
  }
}

ConvertListElementsString convert = ConvertListElementsString();
