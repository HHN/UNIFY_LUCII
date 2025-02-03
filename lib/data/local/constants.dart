class AssetConstants {
  static const basePathIcons = "assets/icons/";
  static const icOnlyLogo = "${basePathIcons}ic_only_logo.svg";
  static const ic_add_event = "${basePathIcons}ic_add_event.svg";
  static const icLogo = "${basePathIcons}ic_logo.svg";
  static const icLogoWithText = "${basePathIcons}ic_logo_with_tag.svg";
  static const icIcon = "${basePathIcons}icon.svg";
  static const icMenu = "${basePathIcons}ic_menu.svg";
  static const icPass = "${basePathIcons}ic_pass.png";
  static const icPost = "${basePathIcons}ic_post.svg";
  static const postNotification = "${basePathIcons}post_notification.svg";
  static const icNotification = "${basePathIcons}ic_notification.svg";
  static const icNotification1 = "${basePathIcons}ic_notification1.svg";
  static const icNotification2 = "${basePathIcons}ic_notification2.svg";
  static const icNotification3 = "${basePathIcons}ic_notification3.svg";
  static const icNotification4 = "${basePathIcons}ic_notification4.svg";
  static const icNotification5 = "${basePathIcons}ic_notification5.svg";
  static const icArrowLeft = "${basePathIcons}ic_arrow_left.svg";
  static const ic_arrow_right = "${basePathIcons}ic_arrow_right.svg";
  static const ic_arrow_down = "${basePathIcons}ic_arrow_down.svg";
  static const ic_close_box = "${basePathIcons}ic_close_box.svg";
  static const icCross = "${basePathIcons}ic_cross.svg";
  static const ic_filter = "${basePathIcons}ic_filter.svg";
  static const ic_home_color = "${basePathIcons}ic_home_color.svg";
  static const ic_home = "${basePathIcons}ic_home.svg";
  static const ic_logout = "${basePathIcons}ic_logout.svg";
  static const ic_password = "${basePathIcons}ic_password.svg";
  static const icProfile = "${basePathIcons}ic_profile.svg";
  static const icLockedProfile = "${basePathIcons}ic_locked_profile.svg";
  static const icLockedProfile2 = "${basePathIcons}ic_locked_profile2.svg";
  static const icLock = "${basePathIcons}ic_lock.svg";
  static const icWorld = "${basePathIcons}ic_world.svg";
  static const icEvent = "${basePathIcons}ic_event.svg";
  static const icEventOut = "${basePathIcons}ic_event_out.svg";
  static const icAddEvent = "${basePathIcons}ic_add_event.svg";
  static const icAddEvent2 = "${basePathIcons}ic_add_event2.svg";
  static const icProfileMen = "${basePathIcons}ic_profile_men.svg";
  static const icSetting = "${basePathIcons}ic_setting.svg";
  static const icSearch = "${basePathIcons}ic_search.svg";
  static const icActionShow = "${basePathIcons}ic_action_show.svg";
  static const icBigProfile = "${basePathIcons}ic_big_profile.svg";
  static const icDocument = "${basePathIcons}ic_document.svg";
  static const icEdit = "${basePathIcons}ic_edit.svg";
  static const icCheckLarge = "${basePathIcons}ic_check_large.svg";
  static const icCameraBgRound = "${basePathIcons}ic_camera_bg_round.svg";
  static const icCamera = "${basePathIcons}ic_camera.svg";
  static const icPasswordHide = "${basePathIcons}ic_password_hide.svg";
  static const icPasswordShow = "${basePathIcons}ic_password_show.svg";
  static const icBoxSquare = "${basePathIcons}ic_box_square.svg";
  static const icTickRound = "${basePathIcons}ic_tick_round.svg";
  static const icTickSquare = "${basePathIcons}ic_tick_square.svg";

  static const basePathImages = "assets/images/";
  static const imageAvatar = "${basePathImages}avatar.png";
  static const imageProfileAvatar = "${basePathImages}profile.png";
  static const imageProfileAlex = "${basePathImages}alex_photo.png";
  static const imageProfileFatih = "${basePathImages}fatih.png";
  static const imageProfileHamza = "${basePathImages}hamza.png";
  static const icLogoText = "${basePathImages}ic_logo_text.png";
}

class FromKey {
  static const buy = "buy";
  static const sell = "sell";
}

class PreferenceKey {
  static const isDark = 'is_dark';
  static const languageKey = "language_key";
  static const isLoggedIn = "is_logged_in";
  static const accessToken = "access_token";
  static const accessType = "access_type";
  static const userObject = "user_object";
  static const settingsObject = "settings_object";
}

class LimitConst {
  static const int passwordLength = 6;
  static const int codeLength = 6;
  static const int usernameMinLength = 6;
  static const int usernameMaxLength = 20;
  static const int listLarge = 20;
  static const int listMedium = 10;
  static const int listShort = 5;
}

class DefaultConst {
  static const String currency = "USD";
  static const String randomImage =
      "https://media.istockphoto.com/photos/high-angle-view-of-a-lake-and-forest-picture-id1337232523";
//"https://picsum.photos/200";
}

class ListConst {
  static const List<String> coinType = [
    "BTC",
    "LTCT",
    "ETH",
    "LTC",
    "DOGE",
    "BCH",
    "DASH",
    "ETC",
    "USDT"
  ];
}

class CurrencyType {
  static const int crypto = 1;
  static const int fiat = 2;
  static const int both = 3;
}

class AddressType {
  static const int external = 1;
  static const int internal = 2;
}

class TransactionType {
  static const int deposit = 1;
  static const int withdrawal = 2;
}
