class WeeklyTimes {
  static final supportedLocales = const ['ko', 'en',];

  static final dates = {
    "ko": <String>['', '월', '화', '수', '목', '금'],
    "en": <String>['', 'MON', 'TUE', 'WED', 'THU', 'FRI'],
  };

  static final times = {
    "ko": <String>[
      '오전 8시',
      '오전 9시',
      '오전 10시',
      '오전 11시',
      '오후 12시',
      '오후 1시',
      '오후 2시',
      '오후 3시',
      '오후 4시',
      '오후 5시',
      '오후 6시',
      '오후 7시',
      '오후 8시',
      '오후 9시',
    ],
    "en": <String>[
      'AM 8',
      'AM 9',
      'AM 10',
      'AM 11',
      'PM 12',
      'PM 1',
      'PM 2',
      'PM 3',
      'PM 4',
      'PM 5',
      'PM 6',
      'PM 7',
      'PM 8',
      'PM 9',
    ],
  };

  static bool localContains(String locale) => supportedLocales.contains(locale);
}
