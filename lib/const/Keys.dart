import 'package:swifty/stock_token.dart';
const String UID = "bf3efd2a762f8f26511f17f897faec85277fd7acdd981ecddf09bd84f562c1af";
const String SECRET = "144fc4505f84aa0015f3d31026d2978bd388f91316024577c9fd8ea2adc04cd0";

Map<String, String> bodytoken =
{
  'grant_type': 'client_credentials',
  'client_id': UID,
  'client_secret': SECRET,
};

Map<String, String> body =
{
  'Authorization': 'Bearer ' + stock_token.access_token,
};