import 'dart:convert';

import 'package:demo_http/models/blog.dart';
import 'package:demo_http/screens/blog_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  List<Blog> blogs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
      ),
      body: Builder(
        builder: (context) {
          if (blogs.isEmpty) {
            return Center(
              child: Text('No data'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async{
              setState(() {
                blogs.clear();
                fetchBlogs();
              });
            },
            child: ListView.builder(
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return ListTile(
                  title: Text(blog.title),
                  subtitle: Text(blog.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogDetailScreen(blog: blog),
                      ),
                    );
                  },
                );
              },
              itemCount: blogs.length,
            ),
          );
        },
      ),
    );
  }

  Future<void> fetchBlogs() async {
    const url = 'https://632e54cdb37236d2ebe8b3ef.mockapi.io/posts';
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      'accept': 'application/json',
    });

    final decode = jsonDecode(response.body) as List;
    final parsed = decode.map<Blog>((json) {
      return Blog(
        json['id'],
        json['content'],
        json['title'],
        json['avatar'],
        json['name'],
        json['createdAt'],
      );
    }).toList();

    setState(() {
      blogs = parsed;
    });
  }
}
