import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const WelcomeScreen(),
    );
  }
}

// --- Welcome Screen ---
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "ROCK • PAPER • SCISSORS",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                letterSpacing: 2,
                color: Colors.cyanAccent,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.cyanAccent,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
              child: const Text(
                "S T A R T",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Game Screen ---
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> moves = ["🪨", "📃", "✂️"];

  String? userChoice;
  String? computerChoice;
  String resultText = "Choose your move!";
  int userScore = 0;
  int computerScore = 0;

  bool isPlaying = false;
  int shuffleIndexUser = 0;
  int shuffleIndexCom = 0;

  void _playGame(int playerIndex) {
    if (isPlaying) return;

    HapticFeedback.mediumImpact(); // Professional touch: Tactile feedback

    setState(() {
      isPlaying = true;
      userChoice = moves[playerIndex];
    });

    int comFinalIndex = Random().nextInt(3);
    int currentShuffle = 0;
    const maxShuffle = 3;

    Timer.periodic(const Duration(milliseconds: 400), (timer) {
      setState(() {
        shuffleIndexUser = (shuffleIndexUser + 1) % 3;
        shuffleIndexCom = (shuffleIndexCom + 1) % 3;
        currentShuffle++;
      });

      if (currentShuffle >= maxShuffle) {
        timer.cancel();
        _calculateWinner(playerIndex, comFinalIndex);
      }
    });
  }

  void _calculateWinner(int uIdx, int cIdx) {
    setState(() {
      isPlaying = false;
      computerChoice = moves[cIdx];

      if (uIdx == cIdx) {
        resultText = "It's a Draw! 🤝";
      } else if ((uIdx == 0 && cIdx == 2) ||
          (uIdx == 1 && cIdx == 0) ||
          (uIdx == 2 && cIdx == 1)) {
        userScore++;
        resultText = "You Win! 🎉";
      } else {
        computerScore++;
        resultText = "Computer Wins! 😢";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ARENA",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF16213E), Color(0xFF0F3460)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildScoreboard(),
              const Spacer(),
              _buildGameView(),
              const Spacer(),
              _buildControlPanel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreboard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _scoreView("COMPUTER", computerScore, Colors.redAccent),
          _scoreView("YOU", userScore, Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _scoreView(String value, int score, Color color) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        Text(
          score.toString(),
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildGameView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _displayBox(
          "Computer",
          isPlaying ? moves[shuffleIndexCom] : (computerChoice ?? "❓"),
        ),
        const Text(
          "VS",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white30),
        ),
        _displayBox(
          "Y O U",
          isPlaying ? moves[shuffleIndexUser] : (userChoice ?? "❓"),
        ),
      ],
    );
  }

  Widget _displayBox(String value, String emoji) {
    return Column(
      children: [
        Text(value),
        const SizedBox(height: 10),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Text(
            emoji,
            key: ValueKey(emoji),
            style: const TextStyle(fontSize: 90),
          ),
        ),
      ],
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.05),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Text(
            resultText,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) => _choiceButton(index)),
          ),
        ],
      ),
    );
  }

  Widget _choiceButton(int index) {
    return InkWell(
      onTap: () => _playGame(index),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white10,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Text(moves[index], style: const TextStyle(fontSize: 40)),
      ),
    );
  }
}
