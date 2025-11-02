import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/app_pages.dart';
import 'package:get/get.dart';

class TopicSelectionScreen extends StatefulWidget {
  const TopicSelectionScreen({super.key});

  @override
  State<TopicSelectionScreen> createState() => _TopicSelectionScreenState();
}

class _TopicSelectionScreenState extends State<TopicSelectionScreen> {
  final List<String> topics = [
    "Business",
    "Finance",
    "Politics",
    "World Affairs",
    "Climate",
    "Health",
    "Science",
    "Culture",
    "Breaking News",
    "Tech",
    "Economy",
    "Sports",
    "Learning",
    "Automotive",
    "Dance",
    "Comedy",
    "Arts & Crafts",
    "Animals",
    "Personal Growth",
    "Food",
  ];

  final Set<String> selectedTopics = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Get.offAllNamed(Routes.SPLASH);
          },
        ),
        title: Text(
          "Choose Interests News",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 40, bottom: 30),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12,
                    runSpacing: 12,
                    children: topics.map((topic) {
                      final bool isSelected = selectedTopics.contains(topic);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected
                                ? selectedTopics.remove(topic)
                                : selectedTopics.add(topic);
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(0xFFC7ACFE)
                                : Color(0xFF564E63),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            topic,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

           SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 22,
                  ),
                  label: Text(
                    "Skip",
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF0EEF1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.offAllNamed(Routes.HOME);
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 22,
                  ),
                  label: Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4C4452),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
