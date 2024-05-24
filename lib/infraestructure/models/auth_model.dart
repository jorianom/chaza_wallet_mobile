import 'package:chaza_wallet/infraestructure/models/recharges_response.dart';
import 'package:chaza_wallet/infraestructure/models/transactions.dart';
import 'package:chaza_wallet/infraestructure/models/user.dart';
import 'package:chaza_wallet/presentation/other/dio_client.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthModel extends ChangeNotifier {
  String _token = "";
  bool _isAuthenticate = false;
  double _balance = 0;
  String _username = "";
  String _userId = "";
  String _phoneUser = "";
  GetTransactions? _transaction;
  ResponseRecharges? _recharge;
  User? _user;

  bool get isAuthenticate => _isAuthenticate;
  String get token => _token;
  String get username => _username;
  String get userId => _userId;
  String get phoneUser => _phoneUser;
  double get balance => _balance;
  GetTransactions? get transaction => _transaction;
  ResponseRecharges? get recharge => _recharge;
  User? get user => _user;

  Future<void> login(String token) async {
    _isAuthenticate = true;
    _token = token;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    _username = decodedToken["sub"];
    _userId = decodedToken["userId"].toString();
    _user = await getIdUser(_userId);
    _phoneUser = _user!.data!.getUser!.phone!;
    notifyListeners();
  }

  void logout() {
    _isAuthenticate = false;
    _token = "";
    _username = "";
    _userId = "";
    _phoneUser = "";
    notifyListeners();
  }

  void balances(balance) {
    _balance = balance;
    notifyListeners();
  }

  void transactions(transaction) {
    _transaction = transaction;
    notifyListeners();
  }

  void recharges(recharge) {
    _recharge = recharge;
    notifyListeners();
  }
}

Future<User> getIdUser(String userId) async {
  String url;
  // print(authModel.token);
  if (kIsWeb) {
    // Some web specific code there
    url = "https://35.238.88.129:82/graphql";
  } else {
    // Some android/ios specific code
    url = "http://10.0.2.2:81/graphql";
  }
  final response = await DioClient.instance.post(url, data: {
    'query': '''
            {                            
              getUser(id: $userId){
                id
                firstName
                lastName
                documentNumber
                phone
                dateBirth
              }
            }
          '''
  });
  print(response.data);
  User user = User.fromJson(response.data);
  return user;
}
