part of constants;

class AppColors {
  AppColors._(); // this basically makes it so you can instantiate this class

  // Application Colour scheme
  static const Color primaryRedColor = Color(0xFFCB2128);
  static const Color primaryGreenColor = Color(0xFF53D1B6);

  static const Color neutralDark = Color(0xFF353743);
  static const Color neutralBlack = Color(0xFF1F2028);
  static const Color neutralGold = Color(0xFFBF864C);
  static const Color neutralLight = Color(0xFFEBF0FF);
  static const Color neutralGrey = Color(0xFF777777);

  /// Generate Primary swatch using (mbitson.com)[http://mcg.mbitson.com/]
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF40BFFF,
    <int, Color>{
      50: Color(0xFFF9E4E5),
      100: Color(0xFFF0BCBE),
      200: Color(0xFFE68F92),
      300: Color(0xFFDB6266),
      400: Color(0xFFD44146),
      500: Color(0xFFCC1F25),
      600: Color(0xFFC71B21),
      700: Color(0xFFC0171B),
      800: Color(0xFFB91216),
      900: Color(0xFFAD0A0D)
    },
  );

  static const Color transparentColor = Color(0x00000000);

  static const Color greyColor = Color(0xFFA5A5A5);

  /// White Color
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color offWhiteColor = Color(0xFFF7F7F7);

  /// Black Color
  static const Color blackColor = Color(0xFF000000);
  static const Color offBlackColor = Color(0xFF8E8E8E);
  static const Color accentBlackColor = Color(0xFF525252);

  /// Red Color
  static const Color redColor = Color(0xFFEB5757);
  static const Color errorColor = Color(0xFFEB5757);

  /// Green Color
  static const Color greenColor = Color(0xFF6FCF97);
  static const Color successColor = Color(0xFF6FCF97);

  static const Color boxShadowColor = Color(0x29000000);

  /// Icon Color
  static const Color iconColor = Color(0xFF8B8E97);

  static const Color linkedInBlueColor = Color(0xFF468CE8);
}
