class ListStringConfig{
  static final Map<String,dynamic> listString = {
    'user':{

    },
    'role_account':{
      'admin':'Admin',
      'operation':'Operation',
      'manager':'Manager',
    }
  };

  static Map getListString(String key){
    return listString[key]??{};
  }

  static void setListString(String key,Map data){
    listString[key] = data;
  }

  static String getValueInList(String listString,key){
    return getListString(listString)[key]??key;
  }
}