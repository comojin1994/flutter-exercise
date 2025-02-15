import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> lstNewsInfo = [];

  @override
  void initState() {
    super.initState();

    getNewsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF414141),
        title: Row(
          children: [
            Text(
              '📰 Headline News',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          itemCount: lstNewsInfo.length,
          itemBuilder: (context, index) {
            return listCard(context, index);
          },
        ),
      ),
    );
  }

  listCard(context, int index) {
    var newItem = lstNewsInfo[index];

    return Card(
      child: GestureDetector(
        child: Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // 이미지
              Container(
                height: 170,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: newItem['urlToImage'] == null
                      ? Image.asset('assets/noimage.png')
                      : Image.network(newItem['urlToImage'], fit: BoxFit.cover),
                ),
              ),
              // 반투명 검정
              Container(
                width: double.infinity,
                height: 57,
                decoration: ShapeDecoration(
                  color: Colors.black.withValues(alpha: 0.70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    // 뉴스제목
                    Container(
                      padding: EdgeInsets.all(9),
                      child: Text(
                        newItem['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // 일자
                    Container(
                      padding: EdgeInsets.only(right: 16, bottom: 5),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        formatDate(newItem['publishedAt']),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/detail', arguments: newItem);
        },
      ),
    );
  }

  Future getNewsInfo() async {
    const apiKey = '';
    const apiurl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiurl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(
          () {
            lstNewsInfo = responseData['articles'];
          },
        );
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  String formatDate(String date) {
    final dateTime = DateTime.parse(date);
    final formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(dateTime);
  }
}
