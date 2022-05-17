
class ResponseApi {
    String ?message;
    String ?error;
    bool success;
    dynamic data;


  ResponseApi(this.message, this.error, this.success);

  ResponseApi.fromJson(Map<String, dynamic> json) 
      : message = json['message'],
        error = json['error'],
        success = json['success'],
        data = json['data'];
      

  Map<String, dynamic> toJson() => {
        'message': message,
        'error': error,
        'success': success,
        'data': data,

      };
}
