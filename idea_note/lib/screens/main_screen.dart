import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:idea_note/data/idea_info.dart';
import 'package:idea_note/database/database_helper.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var dbHelper = DatabaseHelper();
  List<IdeaInfo> lstIdeaInfo = [];

  @override
  void initState() {
    super.initState();

    getIdeaInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5, left: 16),
              child: Text(
                'Archive Idea',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: lstIdeaInfo.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: listItem(index),
              onTap: () async {
                var result = await Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: lstIdeaInfo[index],
                );

                if (result != null) {
                  getIdeaInfo();

                  String msg = '';
                  if (result == 'update') {
                    msg = '아이디어가 수정되었습니다.';
                  } else if (result == 'delete') {
                    msg = '아이디어가 삭제되었습니다.';
                  }

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(msg),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xB27E52FC).withValues(alpha: 0.7),
        onPressed: () async {
          var result = await Navigator.pushNamed(context, '/newIdea');
          if (result != null) {
            getIdeaInfo();

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('아이디어가 저장되었습니다.'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          }
        },
        child: Image.asset(
          width: 64,
          height: 64,
          'assets/idea.png',
        ),
      ),
    );
  }

  Widget listItem(int index) {
    return Container(
      height: 82,
      margin: EdgeInsets.only(top: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // 제목
          Container(
            margin: EdgeInsets.only(left: 16, bottom: 16),
            child: Text(
              lstIdeaInfo[index].title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // 일시
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(right: 16, bottom: 8),
              child: Text(
                DateFormat("yyyy.MM.dd HH:mm").format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lstIdeaInfo[index].createdAt)),
                style: TextStyle(
                  color: Color(0xFFAEAEAE),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // 중요도 점수
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(left: 16, bottom: 8),
              child: RatingBar.builder(
                initialRating: lstIdeaInfo[index].priority.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                itemSize: 16,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 0),
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
                ignoreGestures: true,
                updateOnDrag: false,
                onRatingUpdate: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getIdeaInfo() async {
    await dbHelper.initDatabase();
    lstIdeaInfo = await dbHelper.getAllIdeaInfo();
    lstIdeaInfo.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );
    setState(() {});
    // await dbHelper.closeDatabase();
  }
}
