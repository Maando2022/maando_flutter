
String cleanElements(String elements){
  
  if(elements[elements.length -1] == ' ' || elements[elements.length -1] == ','){
    elements = elements.substring(0, elements.length -1);
    if(elements[elements.length -1] == ' ' || elements[elements.length -1] == ','){
      elements = elements.substring(0, elements.length -1);
    }
    return elements;
  }else{
    return elements;
  }
}




  String elementsString(List<dynamic> items){
    if(items == null || items.length == 0){
      return '';
    }
     String e = '';
     for(var i in items){
       e = e + '${i["name"]}, ';
     }
     return e.substring(0, e.length -2);
   }