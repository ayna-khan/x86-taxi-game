# 🚕 Rush Hour — A Taxi Game in x86 Assembly

A fully playable taxi-driving arcade game written **entirely in x86 Assembly** (MASM, using the Irvine32 library). Pick up passengers, dodge obstacles and NPC traffic, and rack up points across three distinct game modes — all running in a console window.

![Language](https://img.shields.io/badge/language-x86%20Assembly-blue)
![Library](https://img.shields.io/badge/library-Irvine32-informational)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey)

---

## 🎮 Features

- **Three Game Modes**
  - **Career Mode** — drop off a target number of passengers to win
  - **Time Mode** — score as much as possible in 60 seconds
  - **Endless Mode** — survive and keep scoring until you run out of points
- **Two Taxi Types** with different speed/penalty tradeoffs
  - 🟡 Yellow Taxi — faster, but harsher obstacle/car penalties
  - 🔴 Red Taxi — slower, but more forgiving penalties
- **Dynamic City Grid** — procedurally placed buildings, roads, and obstacles
- **Live NPC Traffic** — cars that patrol the grid and can collide with your taxi
- **Passengers & Destinations** — pick up passengers and drop them at highlighted destinations for points
- **Bonus Items** — collectible `$` tiles for extra score
- **Difficulty Levels** — Easy / Medium / Hard, affecting starting score, obstacle count, and traffic density
- **Pause Menu** — resume, restart, save & quit, or return to the main menu mid-game
- **Sound Effects & Background Music** — pickup, drop-off, collisions, bonuses, win/lose, and looping background music

---

## 🕹️ Controls

| Key | Action |
|---|---|
| `W` / `A` / `S` / `D` or Arrow Keys | Move the taxi |
| `Spacebar` | Pick up / drop off passenger |
| `P` | Pause game |
| `R` | Restart (on Game Over screen) |
| `Q` | Quit (on Game Over screen) |

---

## 🏆 Scoring

| Event | Points |
|---|---|
| Successful passenger drop-off | +10 |
| Collect a bonus item (`$`) | +10 |
| Hit an obstacle (Yellow Taxi) | -4 |
| Hit an obstacle (Red Taxi) | -2 |
| Hit an NPC car (Yellow Taxi) | -2 |
| Hit an NPC car (Red Taxi) | -3 |
| Hit a passenger | -5 |

---

## 🛠️ Requirements

- Windows OS
- [MASM (Microsoft Macro Assembler)](https://visualstudio.microsoft.com/) — comes with Visual Studio's "Desktop development with C++" workload
- [Irvine32 library](https://kipirvine.com/asm/) by Kip Irvine
- `winmm.lib` (Windows Multimedia API) — used for sound playback, included with the Windows SDK

## ▶️ Building & Running

1. Install Visual Studio with the **MASM** component enabled, and set up the **Irvine32** library following [Kip Irvine's setup guide](https://kipirvine.com/asm/gettingstarted/index.htm).
2. Clone this repo:
   ```bash
   git clone https://github.com/<your-username>/rush-hour-taxi-asm.git
   ```
3. Add the required sound files to the project directory (see **Sound Files** below).
4. Open the `.asm` file in a MASM-configured Visual Studio project, build, and run.

---

## 🔊 Sound Files

This project uses `PlaySound` and `mciSendStringA` to play `.wav` and `.mp3` files referenced by name in the code:

| Filename | Used for |
|---|---|
| `pickup.wav` | Passenger picked up |
| `drop.wav` | Passenger dropped off |
| `crash.wav` | Hit an obstacle |
| `carcrash.wav` | Hit an NPC car |
| `hit.wav` | Hit a passenger |
| `bonus.wav` | Collected a bonus item |
| `click.wav` | Menu selection |
| `pause.wav` | Game paused |
| `gameover.wav` | Game over |
| `win.wav` | Career mode win |
| `open background.mp3` | Looping background music |

> **Note:** Sound files are **not included** in this repository (see `.gitignore`). Supply your own audio files with these exact filenames in the project's working directory, or the game will run silently without them (missing sound calls fail silently and won't crash the game).

---

## 📂 Project Structure

Single-file MASM source containing:
- Main menu / game mode / difficulty / color selection flows
- Grid-based world rendering and collision detection
- Passenger, obstacle, bonus item, and NPC car spawn/update logic
- Pause menu and restart/reset logic
- Sound integration via `winmm.lib`

---

## 📝 License

This project is shared for educational purposes. Feel free to fork, learn from, and build on it. If you reuse the code, a credit back to this repo is appreciated.

---

## 🙋 Author

Built by Ayna Khan as a systems programming / assembly language project.
