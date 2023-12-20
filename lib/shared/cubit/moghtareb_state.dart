part of 'moghtareb_cubit.dart';

@immutable
sealed class MoghtarebState {}

final class MoghtarebInitial extends MoghtarebState {}

final class SignInState extends MoghtarebState {}

final class SignOutState extends MoghtarebState {}

final class AdminSignInState extends MoghtarebState {}

final class SignUpState extends MoghtarebState {}

final class SignInScreenState extends MoghtarebState {}

final class ChangeHeartColor extends MoghtarebState {}

final class AddToFavorite extends MoghtarebState {}

final class DeleteFromFavorite extends MoghtarebState {}
