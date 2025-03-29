import 'package:flutter/material.dart';
import 'package:kilimboga/components/blog_card.dart';
import 'package:kilimboga/data/dummy_data.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: LazyLoadScrollView(
            onEndOfPage: () {},
            child: ListView.separated(
              itemCount: blogs.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return BlogCard(
                  blog: blogs[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
            ),
          ),
        ),
      ),
    );
  }
}
