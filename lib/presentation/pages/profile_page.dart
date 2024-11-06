import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_social_media/domain/entities/user.dart';
import 'package:json_placeholder_social_media/injection_container.dart';
import 'package:json_placeholder_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:json_placeholder_social_media/presentation/bloc/profile/profile_event.dart';
import 'package:json_placeholder_social_media/presentation/bloc/profile/profile_state.dart';

class ProfilePage extends StatelessWidget {
  final User _user;

  const ProfilePage({
    super.key,
    required User user,
  }) : _user = user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ProfileBloc>()..add(ProfileLoadStartedEvent(userId: _user.id)),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(_user.name),
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfilePostsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfilePostsLoadFailState) {
              return const Center(
                child: Text("Failed to load posts."),
              );
            }
            if (state is ProfilePostsLoadedState) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(post.body),
                                ],
                              ),
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
