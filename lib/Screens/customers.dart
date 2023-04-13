import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:snackchat/Model/ChatModel.dart';
import 'package:snackchat/providers/chatusers.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});
  static const routeName = '/customers';

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  var _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      //Provider.of<ChatUsers>(context).fetchCahatUsers();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('customer list'),
    );
  }
}
