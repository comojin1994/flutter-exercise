import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:idea_note/data/idea_info.dart';
import 'package:idea_note/database/database_helper.dart';

class DetailIdeaScreen extends StatefulWidget {
  IdeaInfo? ideaInfo;
  DetailIdeaScreen({super.key, required this.ideaInfo});

  @override
  State<DetailIdeaScreen> createState() => _DetailIdeaScreenState();
}

class _DetailIdeaScreenState extends State<DetailIdeaScreen> {
  var dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 24),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                widget.ideaInfo!.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Container(
            child: TextButton(
              child: Text(
                '삭제',
                style: TextStyle(
                  color: Color(0xFFFF0000),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('주의'),
                      content: Text('아이디어를 삭제하시겠습니까?'),
                      actions: [
                        TextButton(
                          child: Text(
                            '취소',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text(
                            '삭제',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () async {
                            // Delete the idea
                            await setDeleteIdeaInfo(widget.ideaInfo);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              Navigator.pop(context, 'delete');
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        '아이디어를 떠올린 계기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(
                        widget.ideaInfo!.motive,
                        style: TextStyle(
                          color: Color(0xFFA4A4A4),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        '아이디어 내용',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(
                        widget.ideaInfo!.content,
                        style: TextStyle(
                          color: Color(0xFFA4A4A4),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        '아이디어 중요도 점수',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: RatingBar.builder(
                        initialRating: widget.ideaInfo!.priority.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemSize: 35,
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
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        '유저 피드백 사항',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(
                        widget.ideaInfo!.feedback,
                        style: TextStyle(
                          color: Color(0xFFA4A4A4),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                child: Container(
                    alignment: Alignment.center,
                    width: 328,
                    height: 65,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      '내용 편집하기',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                onTap: () async {
                  // Update the idea
                  var result = await Navigator.pushNamed(context, '/newIdea',
                      arguments: widget.ideaInfo);

                  if (result != null) {
                    if (context.mounted) {
                      Navigator.pop(context, 'update');
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  setDeleteIdeaInfo(IdeaInfo? ideaInfo) async {
    await dbHelper.initDatabase();
    await dbHelper.deleteIdeaInfo(ideaInfo!.id!);
  }
}
