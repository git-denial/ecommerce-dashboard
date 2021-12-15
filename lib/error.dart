var ErrorUtil = {
  'XMLHttpRequest error.': {'title': "Server Error", 'content':"Can't connect to server"},
  'BAD_TOKEN_FORMAT' : {'title': 'Unauthorized', 'content':"You are unauthorized to perform this request"},
  'NO_ADMIN_DATA' : {'title': 'Unauthorized', 'content':"You are unauthorized to perform this request"},
  'NO_TOKEN_PROVIDED': {'title': 'Unauthorized', 'content':"You are unauthorized to perform this request"},
  'JWT_MALFORMED': {'title': 'Unauthorized', 'content':"You are unauthorized to perform this request"},
  'ADMIN_NOT_FOUND': {'title': 'Not found', 'content':"Username or password is incorrect"},
  'ADMIN_PASSWORD_WRONG': {'title': 'Not found', 'content':"Username or password is incorrect"},
  'MISSING_LOGIN_CREDENTIAL': {'title': 'Not found', 'content':"Username or password is incorrect"},

  'DEFAULT':{'title':"Unknown", 'content':"Unknown"}

};

class HTTPErrorType {
  
  int? http_code;
  String? code;
  String? timestamp;
  String? error_message;

  HTTPErrorType({this.http_code,this.code,this.timestamp,this.error_message});

  factory HTTPErrorType.fromJson(Map<String, dynamic> json) {
    return HTTPErrorType(
      http_code: json['http_code'],
      code: json['code'],
      timestamp: json['timestamp'],
      error_message: json['error_message'],
    );
  }

  Map<String,String> generateAlertitleContent(){
    var x = ErrorUtil[this.code] ?? ErrorUtil['DEFAULT'];
    return x!;
  }
}