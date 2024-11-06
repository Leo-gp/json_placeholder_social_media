abstract class ProfileEvent {}

class ProfileLoadStartedEvent extends ProfileEvent {
  final int userId;

  ProfileLoadStartedEvent({required this.userId});
}
