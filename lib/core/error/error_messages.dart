// String error messages
import 'package:news_app/core/error/failures_error.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String NO_INTERNET_MESSAGE = "No Internet Connection";

// Method for to show error
String mapFailureToMessage(Exception exception) {
  switch (exception.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case NoInternet:
      return NO_INTERNET_MESSAGE;
    default:
      return "Unexpected error";
  }
}
