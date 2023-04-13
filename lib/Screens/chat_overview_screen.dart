import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:snackchat/widgets/chat_room.dart';
import '../providers/chatusers.dart';
import '../providers/chatuser.dart';
import '../widgets/chat_item.dart';

class ChatOverviewScreen extends StatefulWidget {
  const ChatOverviewScreen({super.key});
  static const routeName = '/chat_overview';

  @override
  State<ChatOverviewScreen> createState() => _ChatOverviewScreenState();
}

class _ChatOverviewScreenState extends State<ChatOverviewScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
    //SchedulerBinding.instance.scheduleFrameCallback((timeStamp) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<ChatUsers>(context, listen: false).fetchChatUsers();
      setState(() {
        _isLoading = false;
      });
    });
  }

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<ChatUsers>(context).fetchChatUsers().then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final chatUsers = Provider.of<ChatUsers>(context);
    final rooms = chatUsers.rooms;

    return Scaffold(
        appBar: AppBar(
          title: Text('Snackchat'),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : //Text(rooms[0].receiverName!)
            Text('navigating to next page')
        //ListView.builder(
        //    itemCount: rooms!.length,
        //    itemBuilder: (ctx, i) => ChatItem(rooms[i])),
        );
  }
}
