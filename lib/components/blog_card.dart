import 'package:flutter/material.dart';
import 'package:kilimboga/data/models.dart';
import 'package:kilimboga/views/pages/single_blog_page.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SingleBlogPage(blog: blog)));
      },
      splashColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0),
        ),
        width: double.infinity,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                blog.imagePath,
                height: 182,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              maxLines: 2,
              softWrap: true,
              blog.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(255, 255, 255, 1),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              blog.body,
              maxLines: 2,
              softWrap: true,
              style: TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
  }
}
