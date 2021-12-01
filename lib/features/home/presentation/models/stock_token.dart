class stock_token {
  String access_token;
  int expires_in;
  int created_at;
  String autorized_token;

  stock_token(
      {this.access_token,
      this.autorized_token,
      this.created_at,
      this.expires_in});

  factory stock_token.fromJson(Map<String, dynamic> json) {
    return stock_token(
      access_token: json['access_token'],
      expires_in: json['expires_in'],
      created_at: json['created_at'],
    );
  }

  Map<String, dynamic> tojson() => {
        "access_token": access_token,
        "expires_in": expires_in,
        "created_at": created_at
      };

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
