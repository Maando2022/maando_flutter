String getInsurance(String code){
   if(code == 'Insurance-Premium'){
      return 'Premium';
   }else if(code == 'Insurance-Normal'){
      return 'Normal';
   }else if(code == 'Insurance-Basic'){
      return 'Basic';
   }else if(code == 'Insurance-Free'){
      return 'Free';
   }else{
    return '';
   }
}
