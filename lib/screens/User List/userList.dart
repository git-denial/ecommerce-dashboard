import 'package:admin/error.dart';
import 'package:admin/models/User.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/User%20List/components/userRowList.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../constants.dart';
import '../../side_menu.dart';
import '../../header.dart';

class UserListScreen extends StatefulWidget {
  static const String routeName = 'User List';

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Header(),
                      SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                SizedBox(height: defaultPadding),
                                FutureBuilder(
                                    future: User.getAll(),
                                    builder: (ctx, snapshot) {
                                      
                                      if(snapshot.hasError){
                                        //Future.delayed(Duration.zero, () => _showDialog(context));
                                        String err = snapshot.error.toString() ?? "";
                                        var errObject = ErrorUtil[err];
                                        String title = errObject?['title'] ??"Unknown";
                                        String content = errObject?['content'] ??"Unknown";
                                        Future.delayed(Duration.zero, () => _showDialog(context,title,content));
                                        //showDialog(context: context, builder: (BuildContext context) => errorDialog(context));
                                        debugPrint('yesir');
                                      }
                                      else if(snapshot.hasData){
                                        debugPrint('yeso');
                                      }
                                      return UserRows();  
                                      
                                    }),
                                if (Responsive.isMobile(context))
                                  SizedBox(height: defaultPadding),
                                // if (Responsive.isMobile(context)) StarageDetails(),
                              ],
                            ),
                          ),
                          if (!Responsive.isMobile(context))
                            SizedBox(width: defaultPadding),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AlertDialog alert(context){
  return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
}

void _showDialog(context,title,content) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Dialog errorDialog (context)=> Dialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
  child: Container(
    height: 300.0,
    width: 300.0,
   
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.all(15.0),
          child: Text('Cool', style: TextStyle(color: Colors.red),),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text('Awesome', style: TextStyle(color: Colors.red),),
        ),
        Padding(padding: EdgeInsets.only(top: 50.0)),
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        },
            child: Text('Got It!', style: TextStyle(color: Colors.purple, fontSize: 18.0),))
      ],
    ),
  ),
);

