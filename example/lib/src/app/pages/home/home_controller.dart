import 'package:example/src/app/pages/home/home_presenter.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomeController extends Controller {

  HomeViewModel get viewModel => presenter.viewModel;

  @override
  Presenter getPresenter() => presenter;

  final HomePresenter presenter;

  // Presenter should always be initialized this way
  HomeController(usersRepo)
      : presenter = HomePresenter(usersRepo, HomeViewModel()),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
  }

  void getUser() {
    presenter.getUser('test-uid');
  }

  void getUserwithError() => presenter.getUser('test-uid231243');

  void buttonPressed() {
    presenter.buttonPressed();
  }

  @override
  void onResumed() => print('On resumed');

  @override
  void onReassembled() => print('View is about to be reassembled');

  @override
  void onDeactivated() => print('View is about to be deactivated');

  @override
  void onDisposed() {
    presenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }
}
