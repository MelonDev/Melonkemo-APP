class LoginResponseModel {
  final String? access_token;
  final String? refresh_token;
  final String? token_type;

  LoginResponseModel.fromJson(json)
      : access_token = json['data']['token']['access_token'],
        refresh_token = json['data']['token']['refresh_token'],
        token_type = json['data']['token']['token_type'];
}