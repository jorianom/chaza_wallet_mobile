import 'package:chaza_wallet/presentation/screens/recharges_screen.dart';
import 'package:chaza_wallet/presentation/screens/send_screen.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/logo.png"),
          ),
        ),
        title: const Text(
          "Bienvenido Username",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: false,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        child: Column(
          children: [Balance(), Buttons(), Title(), ListTransactions()],
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
                  // print('Retiro presionado');
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

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            child: const Text('Ver mas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class ListTransactions extends StatelessWidget {
  const ListTransactions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const Transactions();
            }));
  }
}

class Transactions extends StatelessWidget {
  const Transactions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.paid),
        title: Text(
          'Netflix',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              fontSize: 16,
              letterSpacing: 1),
        ),
        subtitle: Text(
          'Subscription',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16,
              letterSpacing: 1),
        ),
        trailing: Text(
          '-\$10.99',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              fontSize: 16,
              letterSpacing: 1),
        ),
      ),
    );
  }
}

class Balance extends StatelessWidget {
  const Balance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      child: const Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
                  "\$ 500.000",
                  style: TextStyle(
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
