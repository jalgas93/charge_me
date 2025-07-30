import 'package:charge_me/core/helpers/app_user.dart';
import 'package:charge_me/feature/account/model/user_model/user_model.dart';
import 'package:charge_me/feature/profile/bloc/profile_bloc.dart';
import 'package:charge_me/feature/profile/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../feature/_app/widgets/throw_error.dart';


class UserData {
  final User user;

  UserData({required this.user});
}

class UserProvider extends StatefulWidget {
  const UserProvider({super.key, required this.child});

  final Widget child;

  @override
  State<UserProvider> createState() => _UserProviderState();
}

class _UserProviderState extends State<UserProvider> {
  ProfileBloc get _bloc => BlocProvider.of<ProfileBloc>(context);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadBalances();
    });
  }

  void loadBalances() {
    _bloc.add(ProfileEvent.getUser(userId: AppUser.userModel?.userId ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      listener: (context, ProfileState state) {
        state.maybeWhen(
            error: (e) {
              ThrowError.showNotify(context: context, errMessage: e.toString());
            },
            orElse: () {});
      },
      builder: (context, ProfileState state) {
        return state.maybeWhen(successGetUser: (data) {
          return Provider<UserData>(
            create: (_) => UserData(user: data),
            child: widget.child,
          );
        }, orElse: () {
          return const SizedBox.shrink();
        });
      },
    );
  }
}
