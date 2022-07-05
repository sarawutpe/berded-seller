class NetworkAPI {
  static const String baseURL = '$developmentURL';
  static const String productionURL = 'https://berded.in.th/nodeapi/v1';
  static const String developmentURL = 'https://berded.in.th/nodeapi/v1';
  // static const String developmentURL = 'http://192.168.0.14:3000/api/v1';
  // static const String developmentURL = 'http://192.168.0.184:3000/api/v1';
  static const String login = '/authen/login';
  static const String branches = '/authen/my_branches';
  static const String selected_branches = '/authen/seleceted_branch';
}