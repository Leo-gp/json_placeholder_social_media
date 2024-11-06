import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_social_media/injection_container.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/users_bloc.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/users_event.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/users_state.dart';
import 'package:json_placeholder_social_media/presentation/pages/profile_page.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UsersBloc>()..add(UsersLoadStartedEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.person),
          title: const Text("Users"),
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UsersLoadedState) {
              return Center(
                child: ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.users[index].name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProfilePage(user: state.users[index]);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }
            return const Center(child: Text("Failed to load users."));
          },
        ),
      ),
    );
  }
}
