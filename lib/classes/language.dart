class Language{
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(this.id, this.name, this.flag, this.languageCode);

  static List<Language> languageList(){
    return <Language>[
      Language(1, 'English', '🇺🇸', 'en'),
      Language(2, 'فارسئ', '🇸🇦', 'fa'),
      Language(3, 'لعربيّة', '🇺🇸', 'ar'),
      Language(4, 'हिन्दी', '🇮🇳', 'hi'),
      Language(5, 'French', '🇫🇷', 'fr'),
      Language(6, 'Amharic', '🇪🇹', 'am'),
      Language(7, 'Swahili', '🇰🇪', 'sw'),
     // Language(8, 'Somali', '🇪🇹', 'so'),
    ];
  }


}