class Language{
  final int id;
  final String name;
  final String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList(){
    return <Language>[
      Language(1, 'English', 'en'),
      Language(2, 'Persian', 'fa'),
      Language(3, 'Arabic', 'ar'),
      Language(4, 'Hindi', 'hi'),
      Language(5, 'French','fr'),
      Language(6, 'Amharic', 'am'),
      Language(7, 'Swahili', 'sw'),
    ];
  }


}