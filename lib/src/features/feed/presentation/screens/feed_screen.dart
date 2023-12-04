import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/post_repository.dart';
import '../../domain/use_cases/get_posts_use_case.dart';
import '../blocs/feed/feed_bloc.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedBloc(
        getPostsUseCase: GetPostsUseCase(
          postRepository: context.read<PostRepository>(),
        ),
      )..add(FeedGetPosts()),
      child: const FeedView(),
    );
  }
}

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        centerTitle: true,
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state.status == FeedStatus.initial ||
              state.status == FeedStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == FeedStatus.loaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          state.posts[index].imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.posts[index].caption,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}
