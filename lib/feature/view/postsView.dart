import 'package:flutter/material.dart';
import 'package:mockend/feature/model/postModel.dart';
import 'package:mockend/feature/service/post_service.dart';

class PostsView extends StatefulWidget {
  const PostsView({Key? key}) : super(key: key);

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  late final IPostService _postService;
  bool _isLoading = false;
  List<PostModel>? _items;
  @override
  void initState() {
    super.initState();
    _postService = PostService();
    fetchPostItemsAdvance();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchPostItemsAdvance() async {
    _changeLoading();
    _items = await _postService.fetchPostItems();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Test'),
          actions: [_isLoading ? const CircularProgressIndicator.adaptive() : const SizedBox.shrink()],
        ),
        body: _items == null
            ? const Placeholder()
            : ListView.builder(
                itemCount: _items?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      
                      title: Text(_items?[index].title ?? 'no title'),
                    ),
                  );
                },
              ));
  }
}
