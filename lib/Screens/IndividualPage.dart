import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_detail.dart';
import 'package:intl/intl.dart';
import '../providers/http_exception.dart';
import '../widgets/chat_detail_widget.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({super.key});
  static const routeName = '/chat_detail';

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  TextEditingController _newController = TextEditingController();
  FocusNode _existingFocusNode =  FocusNode();
  var chatRoom;
  var _isInit = true;
  var _isLoading = false;
  var senderId;
  var receiverId;
  var receiverName;
  var lastSeenDate;
  var lastSeenCustomisedDateString;
  var lastSeenTime;
  var receiverProfilePicture;
  var profilePicUrl;
  late FocusNode _focusNode;
  TextEditingController addMessageController = new TextEditingController();
  bool sendButton = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   final chatRoom = ModalRoute.of(context)?.settings.arguments as Map;

    //   final senderId = chatRoom['sender_id'];
    //   final receiverId = chatRoom['receiver_id'];
    //   final supplierId = chatRoom['supplier_id'];
    //   final supplierName = chatRoom['supplier_name'];
    //   final profilePicUrl = chatRoom['profile_pic_url'];
    //   final stateCode = chatRoom['state'];
    //   final countryCode = chatRoom['country'];

    //   setState(() {
    //     _isLoading = true;
    //   });

    //   // await Provider.of<ChatDetail>(context, listen: false).fetchChatDetail(
    //   //     senderId, receiverId, supplierId, stateCode, countryCode);
    //   await Provider.of<ChatDetail>(context, listen: false).fetchChatDetail();
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      chatRoom = ModalRoute.of(context)?.settings.arguments as Map;

      senderId = chatRoom['sender_id'];
      receiverId = chatRoom['receiver_id'];
      receiverName = chatRoom['supplier_name'] ?? chatRoom['receiver_name'];
      final supplierId = '0'; //chatRoom['supplier_id'] ?? '0';
      final supplierName = ''; //chatRoom['supplier_name'] ?? '';
      profilePicUrl = chatRoom['profile_pic_url'] ?? '';
      final stateCode = chatRoom['state'] ?? '0';
      final countryCode = chatRoom['country'] ?? '0';
      lastSeenDate = chatRoom['formated_created_date'];
      lastSeenTime = chatRoom['formated_created_time'];
      lastSeenCustomisedDateString =
          lastSeenDate == dateFormat.format(DateTime.now())
              ? "today"
              : lastSeenDate;

      await Provider.of<ChatDetail>(context).fetchChatDetail(
          senderId, receiverId, supplierId, stateCode, countryCode);
      //await Provider.of<ChatDetail>(context).fetchChatDetail(senderId);
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  Future<void> _sendMessage(value, ctx) async {
    try {
      var response = await Provider.of<ChatDetail>(ctx, listen: false)
          .sendMessage(value, chatRoom);  
          _newController.clear();
          FocusScope.of(ctx).requestFocus(_existingFocusNode);
    } on HttpException catch (e) {
      _showErrorDialog(e.message);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An error occurred'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/chat_bgimage.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 80,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.orangeAccent,
                      backgroundImage: profilePicUrl == null ||
                              profilePicUrl == ''
                          ? const NetworkImage(
                              'https://graph.facebook.com/114021488194584/picture?type=normal')
                          : NetworkImage(profilePicUrl),
                    )
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receiverName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Last seen ${lastSeenCustomisedDateString} ${lastSeenTime}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
                PopupMenuButton<String>(onSelected: (value) {
                  print(5);
                }, itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("Settings"),
                      value: "Settings",
                    ),
                  ];
                })
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ChatDetailWidget(senderId, receiverId),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width - 55,
                              child: Card(
                                  margin: EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    controller: _newController,
                                    focusNode: _existingFocusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    maxLines: 4,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a Message",
                                      prefixIcon: IconButton(
                                        icon: Icon(Icons.free_breakfast,
                                            color: Colors.orangeAccent),
                                        onPressed: () {
                                          print('submit text');
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.photo_camera_back_rounded,
                                              color: Colors.orangeAccent,
                                              size: 30,

                                            ),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomSheet());
                                            },
                                          ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        ],
                                      ),
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                    onFieldSubmitted: (value) =>
                                        _sendMessage(value, context),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                              right: 5,
                              left: 2,
                            ),
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.orange,
                              child: IconButton(
                                icon: Icon(
                                  sendButton ? Icons.send : Icons.send,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _sendMessage(
                                      _newController.value.text, context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.insert_drive_file, Colors.pink, "Files"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.green, "Gallery"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.audiotrack, Colors.purple, "Audio"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 28,
            child: Icon(
              icon,
              color: Colors.white,
              size: 29,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
