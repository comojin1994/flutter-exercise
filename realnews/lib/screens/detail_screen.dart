import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  dynamic newsInfo;
  DetailScreen({super.key, required this.newsInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16),
            child: Text(
              '뒤로가기',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 이미지
            Container(
              height: 245,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: newsInfo['urlToImage'] == null
                    ? Image.asset('assets/noimage.png')
                    : Image.network(newsInfo['urlToImage'], fit: BoxFit.cover),
              ),
            ),
            // 제목
            Container(
              padding: EdgeInsets.only(top: 31),
              child: Text(
                newsInfo['title'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // 날짜
            Container(
              padding: EdgeInsets.only(top: 5),
              alignment: Alignment.bottomRight,
              child: Text(
                formatDate(newsInfo['publishedAt']),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // 내용
            Container(
              padding: EdgeInsets.only(top: 31),
              child: Text(
                newsInfo['description'] == 'null'
                    ? Text('No Details')
                    : newsInfo['description'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String date) {
    final dateTime = DateTime.parse(date);
    final formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(dateTime);
  }
}
