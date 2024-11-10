import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_social_media/domain/entities/comment.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/comments/comments_bloc.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/comments/comments_event.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/comments/comments_state.dart';

class CommentSectionWidget extends StatelessWidget {
  final int _postId;

  const CommentSectionWidget({super.key, required postId}) : _postId = postId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(builder: (context, state) {
      final postCommentsState = state.getCommentsStateFromPost(_postId);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPostCommentsIconButton(
            postId: _postId,
            postCommentsState: postCommentsState,
            context: context,
          ),
          if (!postCommentsState.isUnloaded)
            buildPostComments(
              state: postCommentsState,
              context: context,
            ),
        ],
      );
    });
  }

  Widget buildPostCommentsIconButton({
    required int postId,
    required PostCommentsState postCommentsState,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
        color: postCommentsState.isUnloaded ? null : Colors.lightBlue,
      ),
      margin: const EdgeInsets.only(top: 10),
      height: 30,
      child: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.comment,
          ),
          onPressed: postCommentsState.isLoading
              ? null
              : () {
                  if (postCommentsState.isUnloaded) {
                    context
                        .read<CommentsBloc>()
                        .add(CommentsLoadStartedEvent(postId: postId));
                  } else {
                    context
                        .read<CommentsBloc>()
                        .add(CommentsClosedEvent(postId: postId));
                  }
                }),
    );
  }

  Widget buildPostComments({
    required PostCommentsState state,
    required BuildContext context,
  }) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.error != null) {
      return Center(
        child: Text(state.error!),
      );
    }
    if (state.comments.isEmpty) {
      return const Center(
        child: Text("This post has no comments."),
      );
    }
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: state.comments
            .mapIndexed((index, comment) => Padding(
                  padding: index != 0
                      ? const EdgeInsets.only(top: 15)
                      : EdgeInsets.zero,
                  child: buildPostComment(comment: comment),
                ))
            .toList(),
      ),
    );
  }

  Widget buildPostComment({required Comment comment}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: const Icon(Icons.person),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                comment.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(comment.body),
      ],
    );
  }
}
