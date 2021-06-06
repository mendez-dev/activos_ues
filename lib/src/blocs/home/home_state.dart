part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String user;

  HomeState({@required this.user});

  factory HomeState.initial() {
    return HomeState(
      user: "",
    );
  }

  HomeState copyWith({
    String user,
  }) {
    return HomeState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [
        user,
      ];
}
