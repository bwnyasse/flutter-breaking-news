class AuthEvent {}

///
/// Event triggered when App is starting - Check Auth State of the User
///
class AuthInitEvent extends AuthEvent {}

///
/// Event triggered when user try to log with Google
///
class AuthLoginWithGoogleEvent extends AuthEvent {}

///
/// Event triggered when Auth is ok
///
class AuthSuccessEvent extends AuthEvent {}

///
/// Event triggered when Auth is ko
///
class AuthFailedEvent extends AuthEvent {}
