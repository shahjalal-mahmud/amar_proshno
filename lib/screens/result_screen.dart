import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import 'quiz_screen.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final List<int?> selectedAnswers;

  const ResultScreen({super.key, required this.selectedAnswers});

  int get _correctCount {
    int count = 0;
    for (int i = 0; i < quizQuestions.length; i++) {
      if (selectedAnswers[i] == quizQuestions[i].correctAnswerIndex) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final correct = _correctCount;
    final wrong = quizQuestions.length - correct;
    final total = quizQuestions.length;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Quiz Results',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    _ScoreSummaryCard(
                      correct: correct,
                      wrong: wrong,
                      total: total,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Detailed Results',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: quizQuestions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final question = quizQuestions[index];
                        final userAnswerIndex = selectedAnswers[index];
                        final isCorrect = userAnswerIndex ==
                            question.correctAnswerIndex;
                        final userAnswerText = userAnswerIndex != null
                            ? question.options[userAnswerIndex]
                            : 'No answer';
                        final correctAnswerText =
                        question.options[question.correctAnswerIndex];

                        return _ResultItem(
                          index: index + 1,
                          questionText: question.question,
                          userAnswer: userAnswerText,
                          correctAnswer: correctAnswerText,
                          isCorrect: isCorrect,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _BottomActions(
              onRestart: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const QuizScreen()),
                );
              },
              onGoHome: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreSummaryCard extends StatelessWidget {
  final int correct;
  final int wrong;
  final int total;

  const _ScoreSummaryCard({
    required this.correct,
    required this.wrong,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final percentage = (correct / total * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.emoji_events_rounded,
            color: Colors.amber,
            size: 48,
          ),
          const SizedBox(height: 12),
          const Text(
            'Quiz Completed!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Score: $correct / $total',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$percentage% Correct',
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatChip(
                icon: Icons.check_circle_rounded,
                label: 'Correct',
                value: '$correct',
                iconColor: Colors.greenAccent,
              ),
              const SizedBox(width: 20),
              _StatChip(
                icon: Icons.cancel_rounded,
                label: 'Wrong',
                value: '$wrong',
                iconColor: Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultItem extends StatelessWidget {
  final int index;
  final String questionText;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const _ResultItem({
    required this.index,
    required this.questionText,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderColor =
    isCorrect ? Colors.green.shade300 : Colors.red.shade300;
    final bgColor = isCorrect
        ? Colors.green.shade50
        : Colors.red.shade50;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isCorrect
                    ? Icons.check_circle_rounded
                    : Icons.cancel_rounded,
                color: isCorrect ? Colors.green : Colors.red,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '$index. $questionText',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AnswerRow(
                  label: 'Your Answer:',
                  value: userAnswer,
                  valueColor: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                ),
                const SizedBox(height: 4),
                _AnswerRow(
                  label: 'Correct Answer:',
                  value: correctAnswer,
                  valueColor: Colors.green.shade700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _AnswerRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomActions extends StatelessWidget {
  final VoidCallback onRestart;
  final VoidCallback onGoHome;

  const _BottomActions({
    required this.onRestart,
    required this.onGoHome,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onGoHome,
              icon: const Icon(Icons.home_rounded),
              label: const Text(
                'Go Home',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text(
                'Restart',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}