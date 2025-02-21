import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// This is my Contact Model
class Contact {
  int? pid;
  String pname;
  String pphone;

  Contact({this.pid, required this.pname, required this.pphone});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      pid: json['pid'],
      pname: json['pname'],
      pphone: json['pphone'],
    );
  }

  Map<String, dynamic> toFormData() {
    return {
      'pname': pname,
      'pphone': pphone,
      if (pid != null) 'pid': pid,
    };
  }
}
