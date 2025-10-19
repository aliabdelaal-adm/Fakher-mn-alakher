class Faq {
  final String question;
  final String answer;


  Faq.fromJson(json)

      : question = json['q'],
        answer = json['a'];

}
