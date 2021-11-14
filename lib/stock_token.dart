class stock_token {
  static String access_token;
  static String expires_in;
  static stock_token mInstance;

  static stock_token getInstance() {
    if (mInstance == null) mInstance = new stock_token();
    return mInstance;
  }

  String get gettoken => access_token;
  String get getexpires => expires_in;
  set settoken(String value) {
    access_token = value;
  }

  set setexpires(String value) {
    expires_in = value;
  }
}
