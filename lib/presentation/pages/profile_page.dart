import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_social_media/domain/entities/user.dart';
import 'package:json_placeholder_social_media/injection_container.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/comments/comments_bloc.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/comments/comments_event.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/posts_bloc.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/posts_event.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/posts_state.dart';
import 'package:json_placeholder_social_media/presentation/widgets/post_widget.dart';

class ProfilePage extends StatelessWidget {
  final User _user;

  const ProfilePage({
    super.key,
    required User user,
  }) : _user = user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<PostsBloc>()..add(PostsLoadStartedEvent(userId: _user.id)),
        ),
        BlocProvider(create: (context) => getIt<CommentsBloc>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(_user.name),
          backgroundColor: Colors.blue,
        ),
        body: BlocConsumer<PostsBloc, PostsState>(
          listener: (context, state) {
            if (state is PostsLoadedState) {
              context.read<CommentsBloc>().add(
                    CommentsInitiatedEvent(
                      postsIds: state.posts.map((post) => post.id).toList(),
                    ),
                  );
            }
          },
          builder: (context, state) {
            if (state is PostsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PostsLoadFailState) {
              return const Center(
                child: Text("Failed to load posts."),
              );
            }
            if (state is PostsLoadedState) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: PostWidget(post: state.posts[index]),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
