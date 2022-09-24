import 'package:demo_http/models/blog.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({Key? key, required this.blog}) : super(key: key);
  
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Text(blog.content),
      ),
    );
  }
}
