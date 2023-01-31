import 'package:rive/rive.dart';

class RiveAsset {
  final String atboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.atboard,
      required this.stateMachineName,
      required this.title,
      this.input});
  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset('assets/rive_assets/buttons.riv',
      atboard: 'CHAT', stateMachineName: "CHAT_Interactivity", title: 'Chat'),
  RiveAsset('assets/rive_assets/buttons.riv',
      atboard: 'SEARCH',
      stateMachineName: "SEARCH_Interactivity",
      title: 'Search'),
  RiveAsset('assets/rive_assets/buttons.riv',
      atboard: 'LIKE/STAR',
      stateMachineName: "STAR_Interactivity",
      title: 'Star'),
  RiveAsset('assets/rive_assets/buttons.riv',
      atboard: 'USER', stateMachineName: "USER_Interactivity", title: 'User'),
  RiveAsset('assets/rive_assets/buttons.riv',
      atboard: 'SETTINGS',
      stateMachineName: "SETTINGS_Interactivity",
      title: 'Settings'),
];
