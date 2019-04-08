import 'dart:convert';
import 'dart:math';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_listview/easy_listview.dart';
var flutterLocalNotificationsPlugin;
void main() async{
flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
runApp(MaterialApp(home:HomePage()));
}
class HomePage extends StatefulWidget{
@override
_HomePageState createState()=>_HomePageState();
}
class _HomePageState extends State<HomePage>{
List _data;
final _random=Random();
initState(){
super.initState();
_loadData();
var initializationSettingsAndroid=AndroidInitializationSettings('app_icon_transp');
var initializationSettingsIOS=IOSInitializationSettings(onDidReceiveLocalNotification:onDidRecieveLocalNotification);
var initializationSettings=InitializationSettings(initializationSettingsAndroid,initializationSettingsIOS);
flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification:onSelectNotification);
}
_loadData(){
rootBundle.loadString('assets/data.json').then((jsonStr){
setState(()=>_data=jsonDecode(jsonStr));
});}
Future _scheduleNotification(index) async{
List quotes=_data[index]['quotes'];
var r=_rand(0,quotes.length-1);
String author=quotes[r]['author'];
String body=quotes[r]['body'];
var time=Time(9,0,0);
var androidPlatformChannelSpecifics=AndroidNotificationDetails('buddyApp','Buddy Notifications','Helping and encouraging quotes');
var iOSPlatformChannelSpecifics=IOSNotificationDetails();
var platformChannelSpecifics=NotificationDetails(androidPlatformChannelSpecifics,iOSPlatformChannelSpecifics);
await flutterLocalNotificationsPlugin.showDailyAtTime(0,author,body,time,platformChannelSpecifics,payload:"$author|$body|$index");
}
Future _cancelAllNotifications() async=>await flutterLocalNotificationsPlugin.cancelAll();
Future onDidRecieveLocalNotification(int id,String title,String body,String payload) async{
_onSelect(title,body,payload);
}
Future onSelectNotification(String payload) async{
_onSelect(null,null,payload);
}
_onSelect(title,body,payload) async{
var data=payload.split('|');await _cancelAllNotifications();await _scheduleNotification(int.parse(data[2]));_showMsg(title??data[0],body??data[1]);
}
_showMsg(title,body){
showDialog(
context: context,builder: (BuildContext context)=>AlertDialog(
title:Text(title),content:SingleChildScrollView(child:ListBody(children:[Text(body),],),),actions:[
FlatButton(
child:Text('OK'),onPressed:(){
Navigator.of(context).pop();
},),],),);}
int _rand(int min,int max)=>min+_random.nextInt(max-min);
@override
Widget build(BuildContext context) {
return Scaffold(
body:Stack(
children:[
Column(
mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
Container(
height:200,child:Row(
mainAxisAlignment:MainAxisAlignment.start,children:[
Flexible(
flex:2,child:FlareActor("assets/buddy.flr",fit:BoxFit.contain,alignment:Alignment.center,animation:'hover',),),Flexible(
flex:4,child:Text("Hi, I'm Buddy!\nI'm here to help you.",style:TextStyle(fontSize:24,fontWeight:FontWeight.w300),),),],),),Container(
height:200,child:FlareActor("assets/waves.flr",fit:BoxFit.cover,alignment:Alignment.center,animation:'move',),),],),_data==null
?CircularProgressIndicator()
:EasyListView(
padding:EdgeInsets.only(top:170),headerBuilder:(context){
return Container(padding:EdgeInsets.fromLTRB(25,0,20,10),child:Text(
"Tell me how you're feeling and everyday I'll show you an encouraging tip or quote.",style:TextStyle(fontSize:17),),);
},footerBuilder:(context){
return Container(padding:EdgeInsets.fromLTRB(15,0,20,0),alignment:Alignment.centerLeft,child:FlatButton(
child:Text("* If you need to talk with someone, click here.",style:TextStyle(fontSize:14,fontWeight:FontWeight.w400)),onPressed:() async{
await launch('https://suicidepreventionlifeline.org');
},),);
},itemCount:_data.length,itemBuilder:(context,index){
return Padding(padding:EdgeInsets.fromLTRB(20,16,20,8),child:Container(child:ListTile(contentPadding:EdgeInsets.fromLTRB(15,8,8,8),title:Text(_data[index]['title'],style:TextStyle(fontSize:21,fontWeight:FontWeight.w300)),onTap:() async{
showDialog(
context: context,builder:(BuildContext context){
return AlertDialog(
title:Text('Buddy Notifications'),content: SingleChildScrollView(
child:ListBody(children:[Text('I can show you everyday a notification with a different quote about this topic. Tell me what you want to do.'),],),),actions:[
FlatButton(child:Text('Cancel All'),onPressed:() async{
await _cancelAllNotifications();
Navigator.of(context).pop();
},),FlatButton(child:Text('Not now'),onPressed:(){
Navigator.of(context).pop();
},),FlatButton(
child:Text('Confirm'),onPressed:() async{
await _cancelAllNotifications();
await _scheduleNotification(index);
Navigator.of(context).pop();
},),],);},);},),decoration:BoxDecoration(borderRadius:BorderRadius.circular(16),border:Border.all(width:2,color:Color(int.parse(_data[index]['color']))),),),);
},),],),);}}