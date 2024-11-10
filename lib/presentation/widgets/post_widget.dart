import 'package:flutter/widgets.dart';
import 'package:json_placeholder_social_media/domain/entities/post.dart';
import 'package:json_placeholder_social_media/presentation/widgets/comment_section_widget.dart';

class PostWidget extends StatelessWidget {
  final Post _post;

  const PostWidget({
    super.key,
    required post,
  }) : _post = post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _post.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(_post.body),
        CommentSectionWidget(postId: _post.id),
      ],
    );
  }
}
