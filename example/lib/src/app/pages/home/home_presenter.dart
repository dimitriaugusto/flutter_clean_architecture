import 'package:example/src/domain/entities/user.dart';
import 'package:flutter/material.dart';

import 'package:example/src/domain/usecases/get_user_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePresenter extends Presenter {
  final GetUserUseCase getUserUseCase;

  HomeViewModel viewModel;

  HomePresenter(usersRepo, this.viewModel)
      : getUserUseCase = GetUserUseCase(usersRepo) {
    viewModel._counter = 0;
  }

  void getUser(String uid) {
    GenericUseCaseObserver<GetUserUseCaseResponse> observer =
        GenericUseCaseObserver();

    observer.onUseCaseComplete = () {
      print('User retrieved');
    };

    observer.onUseCaseNext = (GetUserUseCaseResponse response) {
      print(response.user.toString());
      viewModel._user = response.user;
      refreshUI();
    };

    observer.onUseCaseError = (e) {
      print('Could not retrieve user.');
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text(e.message)));
      viewModel._user = null;
      refreshUI(); // Refreshes the UI manually
    };

    getUserUseCase.execute(
      observer,
      GetUserUseCaseParams(uid),
    );
  }

  @override
  void dispose() {
    getUserUseCase.dispose();
  }

  void buttonPressed() {
    viewModel._counter++;
    refreshUI();
  }
}

class HomeViewModel {
  int _counter;
  User _user;

  int get counter => _counter;

  User get user => _user;
}
