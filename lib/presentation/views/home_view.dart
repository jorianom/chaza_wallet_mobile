import 'package:chaza_wallet/infraestructure/models/auth_model.dart';
import 'package:chaza_wallet/infraestructure/models/balance.dart';
import 'package:chaza_wallet/infraestructure/models/recharges_response.dart';
import 'package:chaza_wallet/infraestructure/models/transactions.dart';
import 'package:chaza_wallet/presentation/other/dio_client.dart';
import 'package:chaza_wallet/presentation/screens/login_screen.dart';
import 'package:chaza_wallet/presentation/screens/products_screen.dart';
import 'package:chaza_wallet/presentation/screens/recharges_screen.dart';
import 'package:chaza_wallet/presentation/screens/send_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Balance? balance;
String idUser = "";

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainContent();
  }
}

class MainContent extends StatelessWidget {
  const MainContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    idUser = authModel.userId;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/logo.png"),
          ),
        ),
        title: Text(
          authModel.username,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, size: 40),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('¿Quieres cerrar sesión?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Sí'),
                        onPressed: () {
                          authModel.logout();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginForm()),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        child: Column(
          children: [
            BalanceView(),
            Buttons(),
            Title(),
            ListTransactions(authModel: authModel),
            TitleRecharge(),
            ListRecharge(authModel: authModel),
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              IconButton.filledTonal(
                color: Colors.blueAccent,
                icon: const Icon(Icons.import_export, size: 40),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext contex) =>
                              const SendScreen()));
                },
              ),
              const Text('Enviar'),
            ],
          ),
          Column(
            children: [
              IconButton.filledTonal(
                color: Colors.blueAccent,
                icon: const Icon(Icons.local_atm, size: 40),
                onPressed: () {
                  // print('Retiro presionado');
                },
              ),
              const Text('Retiro'),
            ],
          ),
          Column(
            children: [
              IconButton.filledTonal(
                color: Colors.blueAccent,
                icon: const Icon(Icons.add_card, size: 40),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext contex) =>
                              const RechargesScreen()));
                },
              ),
              const Text('Recargas'),
            ],
          ),
          Column(
            children: [
              IconButton.filledTonal(
                color: Colors.blueAccent,
                icon: const Icon(Icons.credit_score, size: 40),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext contex) =>
                              const ProductScreen()));
                },
              ),
              const Text('Productos'),
            ],
          )
        ],
      ),
    );
  }
}

Future<void> getTransactions(authModel) async {
  String url;
  if (kIsWeb) {
    url = "https://35.238.88.129:82/graphql";
  } else {
    url = "http://10.0.2.2:81/graphql";
  }
  var response = await DioClient.instance.post(url, data: {
    'query': '''
            {
                getTransactionsForUser(id: $idUser) {
                    transactionId
                    amount
                    dateTime
                    description
                    senderId
                    receiverId
                }
            }
          '''
  });
  print(response);
  GetTransactions transactions = GetTransactions.fromJson(response.data);
  authModel.transactions(transactions);
}

Future<void> getBalance(balance, authModel) async {
  String url;
  if (kIsWeb) {
    url = "https://35.238.88.129:82/graphql";
  } else {
    url = "http://10.0.2.2:81/graphql";
  }
  var response = await DioClient.instance.post(url, data: {
    'query': '''
            {
                calculateBalanceForUser(id: $idUser)
            }
          '''
  });

  print(response);
  balance = Balance.fromJson(response.data);
  authModel.balances(balance?.data?.calculateBalanceForUser);
}

Future<void> getRecharge(authModel) async {
  String url;
  if (kIsWeb) {
    url = "https://35.238.88.129:82/graphql";
  } else {
    url = "http://10.0.2.2:81/graphql";
  }
  final response = await DioClient.instance.post(url, data: {
    'query': '''
            {
              getRecharges(id: $idUser) {
                  id
                  user
                  amount
                  date
              }
          }
          '''
  });
  print(response);
  ResponseRecharges recharges = ResponseRecharges.fromJson(response.data);
  authModel.recharges(recharges);
}

class Title extends StatefulWidget {
  const Title({
    super.key,
  });

  @override
  State<Title> createState() => _TitleState();
}

class _TitleState extends State<Title> {
  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Ultimas transacciones',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                getTransactions(authModel);
                getBalance(balance, authModel);
              });
            },
            child: const Text('Actualizar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class TitleRecharge extends StatefulWidget {
  const TitleRecharge({
    super.key,
  });

  @override
  State<TitleRecharge> createState() => _TitleRechargeState();
}

class _TitleRechargeState extends State<TitleRecharge> {
  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Mis recargas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                getRecharge(authModel);
                getBalance(balance, authModel);
              });
            },
            child: const Text('Actualizar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class ListTransactions extends StatefulWidget {
  final AuthModel authModel;
  const ListTransactions({super.key, required this.authModel});

  @override
  State<ListTransactions> createState() => _ListTransactionsState();
}

class _ListTransactionsState extends State<ListTransactions> {
  late AuthModel authModel;

  @override
  void initState() {
    super.initState();
    setState(() {
      getBalance(balance, widget.authModel);
      getTransactions(widget.authModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    if (authModel.transaction == null ||
        authModel.transaction?.data?.getTransactionsForUser!.isEmpty == true) {
      return const Text("Ups aún no tienes transacciones");
    }
    return Expanded(
        child: ListView.builder(
            itemCount:
                authModel.transaction?.data?.getTransactionsForUser?.length,
            itemBuilder: (context, index) {
              var transaction =
                  authModel.transaction?.data?.getTransactionsForUser?[index];
              return Transactions(transaction);
            }));
  }
}

class ListRecharge extends StatefulWidget {
  final AuthModel authModel;
  const ListRecharge({super.key, required this.authModel});

  @override
  State<ListRecharge> createState() => _ListRechargeState();
}

class _ListRechargeState extends State<ListRecharge> {
  late AuthModel authModel;

  @override
  void initState() {
    super.initState();
    setState(() {
      // getBalance(balance, widget.authModel);
      // getTransactions(widget.authModel);
      getRecharge(widget.authModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    if (authModel.recharge == null ||
        authModel.recharge?.data!.getRecharges?.isEmpty == true) {
      return const Text("Ups aún no tienes transacciones");
    }
    return Expanded(
        child: ListView.builder(
            itemCount: authModel.recharge?.data?.getRecharges?.length,
            itemBuilder: (context, index) {
              var recharge = authModel.recharge?.data?.getRecharges?[index];
              return Recharges(recharge);
            }));
  }
}

class Transactions extends StatelessWidget {
  final GetTransactionsForUser? transaction;
  const Transactions(
    this.transaction, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // String fechaString = transaction?.dateTime;
    DateTime? fecha = transaction!.dateTime;
    String formateado = DateFormat('yyyy-MM-dd').format(fecha!);
    final formatter = NumberFormat('#,###.00', 'es_CO');
    String formatted = formatter.format(transaction?.amount);
    var sign = transaction?.senderId.toString() == idUser ? '-' : '+';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.paid),
        title: Text(
          formateado,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              fontSize: 16,
              letterSpacing: 1),
        ),
        subtitle: Text(
          '${transaction?.description}',
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16,
              letterSpacing: 1),
        ),
        trailing: Text(
          '$sign\$$formatted',
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              fontSize: 16,
              letterSpacing: 1),
        ),
      ),
    );
  }
}

class Recharges extends StatelessWidget {
  final GetRecharge? recharge;
  const Recharges(
    this.recharge, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // String fechaString = transaction?.dateTime;
    DateTime? fecha = DateTime.parse(recharge!.date!);
    String formateado = DateFormat('yyyy-MM-dd').format(fecha);

    final formatter = NumberFormat('#,###.00', 'es_CO');
    double balance = double.parse(recharge!.amount!);
    String formatted = formatter.format(balance);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.paid),
        title: Text(
          formateado,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              fontSize: 16,
              letterSpacing: 1),
        ),
        subtitle: const Text(
          'Recarga de cuenta',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16,
              letterSpacing: 1),
        ),
        trailing: Text(
          '\$$formatted',
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              fontSize: 16,
              letterSpacing: 1),
        ),
      ),
    );
  }
}

class BalanceView extends StatefulWidget {
  const BalanceView({
    super.key,
  });

  @override
  State<BalanceView> createState() => _BalanceState();
}

class _BalanceState extends State<BalanceView> {
  late String formattedBalance;
  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    if (kDebugMode) {
      print("balance:${authModel.balance}");
    }
    if (authModel.balance == 0) {
      formattedBalance = "0,00";
    } else {
      final formatter = NumberFormat('#,###.00', 'es_CO');
      formattedBalance = formatter.format(authModel.balance);
    }
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: Colors.blueAccent,
          // borderRadius: BorderRadius.all(Radius.circular(32)))));
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[850]!.withOpacity(0.29),
                offset: const Offset(-10, 10),
                blurRadius: 10)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              children: [
                Text(
                  "Balance",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$ $formattedBalance",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 25,
                      letterSpacing: 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
