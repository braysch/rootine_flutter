class LoadingState {
  final Status status;
  final String? msg;

  LoadingState(this.status, {this.msg});

  static final LoadingState LOADED = LoadingState(Status.SUCCESS);
  static final LoadingState IDLE = LoadingState(Status.IDLE);
  static final LoadingState LOADING = LoadingState(Status.RUNNING);

  static LoadingState error(String? msg) {
    return LoadingState(Status.FAILED, msg: msg);
  }
}

enum Status {
  RUNNING,
  SUCCESS,
  FAILED,
  IDLE,
}
