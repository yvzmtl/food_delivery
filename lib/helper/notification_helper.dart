

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationHelper{

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();
    final  AndroidInitializationSettings initializationSettingsAndroid =  AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
       // onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, 
        iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (data) async {
          if (data !=null) {
            debugPrint('notification patload: '+ data.payload!);
          }
          selectNotificationStream.add(data.payload);
        });

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(".................onMessage............");
      print(" onMessage : ${message.notification?.title}/${message.notification?.body}/"
    "${message.notification?.titleLocKey}");

    NotificationHelper.showNotification(message,flutterLocalNotificationsPlugin);
    if (Get.find<AuthController>().userLoggedIn()) {
      
    }
    });


     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(" onMessage : ${message.notification?.title}/${message.notification?.body}/"
        "${message.notification?.titleLocKey}");
      
     try {
       if (message.notification?.titleLocKey != null) {
         
       } else {
         
       }
     } catch (e) {
       print(e.toString());
     }
     });
  }

  static Future<void> showNotification(RemoteMessage msg, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      msg.notification!.body!,
      htmlFormatBigText: true,
      contentTitle: msg.notification!.title!,
      htmlFormatContentTitle: true
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "channel_id_1", "dbfood",
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true
      );

      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidNotificationDetails,iOS: const DarwinNotificationDetails());

      await fln.show(0, msg.notification!.title!, msg.notification!.body!, platformChannelSpecifics);
  }
  
}