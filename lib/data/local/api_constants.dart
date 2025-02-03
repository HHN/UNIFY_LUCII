class APIURLConstants {
  static const baseUrl = "https://socialxmatch.com/_matrix/client/v3/";
  static const baseUrl1 = "http://179.61.246.8:5000/";

  ///End Urls : POST
  static const signIn = "${baseUrl}login";
  static const register = "${baseUrl}register";
  static const join = "${baseUrl1}join";
  static const createEvent = "${baseUrl1}create_event";
  static const getAllEvents = "${baseUrl1}get_all_events";

  ///End Urls : GET
  static const logoutApp = "/api/logout";

}

class APIKeyConstants {
  static const accept = "Accept";
  static const authorization = "Authorization";
  static const email = "email";
  static const password = "password";
  static const name = "name";
  static const username = "username";
}



class ErrorConstants {
  static const unauthorized = "Unauthorized";
}
