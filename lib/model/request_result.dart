/// <BaseRespR<T> 返回 status code msg data Response.
class Result<T> {
  String status;
  T data;
  String token;
  String ipAddress;

  Result(this.status, this.data,this.token,this.ipAddress);

  Result.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = json['data'],
        token = json['token'],
  ipAddress = json['ipAddress'];

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write(",\"status\":\"$status\"");
    sb.write(",\"data\":\"$data\"");
    sb.write(",\"token\":\"$token\"");
    sb.write(",\"ipAddress\":\"$ipAddress\"");
    sb.write('}');
    return sb.toString();
  }
}