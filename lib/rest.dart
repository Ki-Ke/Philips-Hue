import 'dart:convert';
import 'package:http/http.dart' as http;

class IPResponse {
  final String internalipaddress;
  final String id;

  IPResponse({this.internalipaddress, this.id});

  factory IPResponse.fromJson(List<dynamic> json) {
    return IPResponse(
      id: json[0]['id'],
      internalipaddress: json[0]['internalipaddress'],
    );
  }
}

Future<IPResponse> fetchIp() async {
  final response =
  await http.get('https://discovery.meethue.com/');

  if (response.statusCode == 200) {
    String ip = IPResponse.fromJson(json.decode(response.body)).internalipaddress;
    getUser(ip);
  } else {
    throw Exception('Failed to load post');
  }
}

class GetUserId {
  final String username;

  GetUserId({this.username});

  factory GetUserId.fromJson(List<dynamic> json) {
    return GetUserId(
      username: json[0]['success']['username'],
    );
  }
}

Future<GetUserId> getUser(ip) async {
  String t = ip.toString();
  print('https://' + t + '/api');
  final response =
  await http.post('https://' + t + '/api', body: {"devicetype":"my_hue_app#iphone peter"});

  if (response.statusCode == 200) {
    return GetUserId.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}