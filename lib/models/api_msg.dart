import 'dart:convert';

ApiMsg apiMsgFromJson(String str) => ApiMsg.fromJson(json.decode(str));

String apiMsgToJson(ApiMsg data) => json.encode(data.toJson());

class ApiMsg {
    ApiMsg({
        required this.msg,
        required this.msgType,
        required this.title,
    });

    String msg;
    String msgType;
    String title;

    factory ApiMsg.fromJson(Map<String, dynamic> json) => ApiMsg(
        msg: json["msg"],
        msgType: json["msgType"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "msgType": msgType,
        "title": title,
    };
}