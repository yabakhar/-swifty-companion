class stock_token {
  static String access_token;
  static int expires_in;
  static stock_token mInstance;
  static String autorized_token;

  static stock_token getInstance() {
    if (mInstance == null) mInstance = new stock_token();
    return mInstance;
  }

  String get gettoken => access_token;
  String get getautorizedtoken => autorized_token;
  int get getexpires => expires_in;
  set settoken(String value) {
    access_token = value;
  }

  set setautorizedtoken(String value) {
    autorized_token = value;
  }

  set setexpires(int value) {
    expires_in = value;
  }
}
