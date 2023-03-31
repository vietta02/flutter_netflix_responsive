import 'package:flutter/material.dart';
import '../models/models.dart';

class ContentList extends StatelessWidget {
  const ContentList(
      {super.key,
      required this.title,
      required this.contentList,
      this.isOriginals = false});
  final String title;
  final List<Content> contentList;
  final bool isOriginals;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: isOriginals ? 500.0 : 220.0,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: contentList.length,
              itemBuilder: ((context, index) {
                final Content content = contentList[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  height: isOriginals ? 400.0 : 200.0,
                  width: isOriginals ? 200.0 : 130.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(content.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
