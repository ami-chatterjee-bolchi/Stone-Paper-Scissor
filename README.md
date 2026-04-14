# ✊ Stone - Paper - Scissors ✂️

A high-fidelity, cross-platform implementation of the classic game built with **Flutter**. This project demonstrates advanced UI techniques, including asynchronous timers for animations and dynamic state management.

---

## 🌟 Key Features

* **Timed Shuffle Animation:** Uses `Timer.periodic` to cycle through emojis, creating a "shuffling" effect before revealing choices.
* **Dynamic Visual Feedback:** Implements `AnimatedSwitcher` and `AnimatedOpacity` for smooth transitions between game states.
* **Custom UI Styling:** Features a custom neon-glow start screen and a gradient-based game arena.
* **Session Scoreboard:** Real-time score tracking for both the player and the AI.

---

## 🛠️ Technical Implementation

### **Asynchronous Logic**
The game doesn't just show the result; it simulates anticipation. When a user picks an option, two simultaneous timers (`startTransition` and `startcomTransition`) trigger a 1-second shuffle cycle through the emoji list before locking in the final selection.

### **UI Components**
* **State Management:** Utilizes `setState` to manage game flow, result calculation, and score persistence.
* **Animations:** * `ScaleTransition`: Used within an `AnimatedSwitcher` to pop the emojis onto the screen.
    * `AnimatedOpacity`: Used to fade the result text and score in/out.
* **Navigation:** Uses `Navigator.pushReplacement` to move from the splash screen to the game arena.

---

## 🚀 Getting Started

### **Prerequisites**
* [Flutter SDK](https://docs.flutter.dev/get-started/install) (Latest Version)
* An IDE (VS Code, Android Studio, or IntelliJ)

### **Installation**

1. **Clone the repo:**
   ```bash
   git clone [https://github.com/your-username/stone-paper-scissors-flutter.git](https://github.com/your-username/stone-paper-scissors-flutter.git)
   ```
2. **Install Dependencies**
  ```bash
  flutter pub get
```
3. **Run the app:**
   ```bash
   flutter run
   ```

 ## 🎮 How to Play
 1. Press S T A R T on the landing page.
 2. Choose your move: Stone (🪨), Paper (📃), or Scissors (✂️).
 3. Watch the shuffle animation as the Computer makes its move.
 4. The result (Win/Lose/Draw) and the updated score will fade into view!

## 📂 Project Structure
```bash
lib/
└── main.dart  # Contains the entry point, Splash Screen, and Game Logic
```
## 📄 License
This project is open-source and available under the MIT License.
* Developed by **Tirthankar Chatterjee** CS Student & Tech-Enthusiast

