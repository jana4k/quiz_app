class QuizStatus {
  final String quizId;
  final String status;
  final int currentQuestionIndex;

  QuizStatus({
    required this.quizId,
    required this.status,
    required this.currentQuestionIndex,
  });

  factory QuizStatus.fromMap(Map<String, dynamic> data) {
    return QuizStatus(
      quizId: data['quizId'],
      status: data['status'],
      currentQuestionIndex: data['currentQuestionIndex'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'status': status,
      'currentQuestionIndex': currentQuestionIndex,
    };
  }
}
