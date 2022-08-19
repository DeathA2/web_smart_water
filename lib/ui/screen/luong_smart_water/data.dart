class User{
  static String userList = '';
  static Map<String, List<String>> streets = {};
  static Map<String, List<String>> customer = {};
}

class Street{
  static String code = '';
  static String des = '';
  static String name = '';
  static String user = '';
  static String sumCustomer = '';
  static int countCustomer = 0;
  static Map<String, int> count = {};
}