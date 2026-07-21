INCLUDE Irvine32.inc
INCLUDELIB winmm.lib

PlaySound PROTO,
    pszSound:PTR BYTE,
    hmod:DWORD,
    fdwSound:DWORD

mciSendStringA PROTO,
    lpstrCommand:PTR BYTE,
    lpstrReturnString:PTR BYTE,
    uReturnLength:DWORD,
    hwndCallback:DWORD

.data
    SND_FILENAME EQU 00020000h
    SND_ASYNC EQU 00000001h
    SND_LOOP EQU 00000008h
    SND_NOSTOP EQU 00000010h

    soundPickup BYTE "pickup.wav", 0
    soundDrop BYTE "drop.wav", 0
    soundCrashObstacle BYTE "crash.wav", 0
    soundCrashCar BYTE "carcrash.wav", 0
    soundCrashPassenger BYTE "hit.wav", 0
    soundBonus BYTE "bonus.wav", 0
    soundClick BYTE "click.wav", 0
    soundPause BYTE "pause.wav", 0
    soundGameOver BYTE "gameover.wav", 0
    soundWin BYTE "win.wav", 0

    bgMusicStart BYTE "open background.mp3", 0
    bgMusicStop BYTE "close background", 0
    bgMusicCommand BYTE "play background repeat", 0
    mciReturn BYTE 128 DUP(0)

    gameTitle BYTE "-------------- RUSH HOUR --------------", 0
    playerPrompt BYTE "Enter Player Name: ", 0
    scoreText BYTE "Score: ", 0
    playerName BYTE 50 DUP(0)
    score DWORD 10

    menuTitle1 BYTE "==========================================", 0
    menuTitle2 BYTE "        RUSH HOUR - TAXI GAME            ", 0
    menuTitle3 BYTE "==========================================", 0
    
    menu1 BYTE "1. Start New Game", 0
    menu2 BYTE "2. Continue Game", 0
    menu3 BYTE "3. Change Difficulty Level", 0
    menu4 BYTE "4. View Leader Board", 0
    menu5 BYTE "5. Read Instructions", 0
    menu6 BYTE "6. Exit Game", 0
    menuPrompt BYTE "Select Option (1-6): ", 0

    instTitle BYTE "============== GAME INSTRUCTIONS ==============", 0
    inst1 BYTE "OBJECTIVE: Pick up passengers and drop them at destinations", 0
    inst2 BYTE "CONTROLS: Arrow Keys/WASD - Move Taxi", 0
    inst3 BYTE "          Spacebar - Pick up / Drop off Passenger", 0
    inst4 BYTE "          P - Pause Game", 0
    inst5 BYTE "SCORING: +10 points for successful drop-off", 0
    inst6 BYTE "         +10 points for collecting bonus items ($)", 0
    inst7 BYTE "PENALTIES (Yellow Taxi): -4 for obstacles, -2 for cars", 0
    inst8 BYTE "PENALTIES (Red Taxi): -2 for obstacles, -3 for cars", 0
    inst9 BYTE "          -5 for hitting passengers", 0
    inst10 BYTE "DESTINATION: Highlighted in GREEN after pickup", 0
    instBack BYTE "Press any key to return to menu...", 0

    continueMsg BYTE "Continue Game - Not yet implemented. Press any key...", 0
    difficultyMsg BYTE "Difficulty Selection - Not yet implemented. Press any key...", 0
    leaderboardMsg BYTE "Leaderboard - Not yet implemented. Press any key...", 0

    menuChoice BYTE ?
    inMainMenu BYTE 1
    returnMenuMsg BYTE "Press M for Menu or any key to play...", 0

    gameOverMsg BYTE "========== GAME OVER ==========", 0
    finalScoreMsg BYTE "Final Score: ", 0
    restartMsg BYTE "Press R to Restart or Q to Quit", 0
    
    GRID_SIZE = 20
    CELL_SIZE = 2
    
    grid BYTE GRID_SIZE * GRID_SIZE DUP(0)
    
    taxiRow BYTE 0
    taxiCol BYTE 0
    taxiColor BYTE ?
    
    colorPrompt BYTE "Select Taxi Color:", 0
    colorOption1 BYTE "1) Yellow Taxi (Faster, -4 for obstacles, -2 for cars)", 0
    colorOption2 BYTE "2) Red Taxi (Slower, -2 for obstacles, -3 for cars)", 0
    colorOption3 BYTE "3) Random Selection", 0
    colorChoice BYTE ?
    
    gameRunning BYTE 1

    MAX_PASSENGERS = 5
    
    passengerRow BYTE MAX_PASSENGERS DUP(0)
    passengerCol BYTE MAX_PASSENGERS DUP(0)
    passengerActive BYTE MAX_PASSENGERS DUP(0)
    destRow BYTE MAX_PASSENGERS DUP(0)
    destCol BYTE MAX_PASSENGERS DUP(0)
    
    hasPassenger BYTE 0
    currentPassenger BYTE 0
    
    seed DWORD ?

    MAX_OBSTACLES = 5
    MAX_BONUS = 3
    
    obstacleRow BYTE MAX_OBSTACLES DUP(0)
    obstacleCol BYTE MAX_OBSTACLES DUP(0)
    obstacleType BYTE MAX_OBSTACLES DUP(0)
    obstacleActive BYTE MAX_OBSTACLES DUP(1)
    
    bonusRow BYTE MAX_BONUS DUP(0)
    bonusCol BYTE MAX_BONUS DUP(0)
    bonusActive BYTE MAX_BONUS DUP(1)
    
    MAX_NPC_CARS = 10
    
    npcCarRow BYTE MAX_NPC_CARS DUP(0)
    npcCarCol BYTE MAX_NPC_CARS DUP(0)
    npcCarDirection BYTE MAX_NPC_CARS DUP(0)
    npcCarColor BYTE MAX_NPC_CARS DUP(0)
    npcCarActive BYTE MAX_NPC_CARS DUP(1)
    
    moveCounter DWORD 0

    pauseTitle BYTE "=============== GAME PAUSED ===============", 0
    pauseOption1 BYTE "1. Resume Game", 0
    pauseOption2 BYTE "2. Save & Quit", 0
    pauseOption3 BYTE "3. Restart Game", 0
    pauseOption4 BYTE "4. Back to Main Menu", 0
    pausePrompt BYTE "Select Option (1-4): ", 0
    pauseChoice BYTE ?
    gamePaused BYTE 0

    dropCounter DWORD 0
    speedLevel DWORD 1

    collisionMsg BYTE "COLLISION! ", 0
    collisionType BYTE 20 DUP(0)
    showCollision BYTE 0
    collisionTimer DWORD 0

    minPassengers = 3
    maxPassengers = 5
    activePassengerCount BYTE 0

    dropCountText BYTE "Drops: ", 0
    speedLevelText BYTE " | Speed: ", 0

    difficultyLevel BYTE 1
    diffTitle BYTE "========== SELECT DIFFICULTY ==========", 0
    diff1 BYTE "1. Easy   - More time, fewer obstacles", 0
    diff2 BYTE "2. Medium - Balanced gameplay", 0
    diff3 BYTE "3. Hard   - Fast-paced, more obstacles", 0
    diffPrompt BYTE "Select Difficulty (1-3): ", 0
    diffChoice BYTE ?

    currentMaxObstacles BYTE 8
    currentMaxNPCCars BYTE 8
    currentStartScore DWORD 10

    gameMode BYTE 1
    modeTitle BYTE "========== SELECT GAME MODE ==========", 0
    mode1 BYTE "1. Career Mode - Drop 5 passengers to win!", 0
    mode2 BYTE "2. Time Mode   - Score as much in 60 seconds!", 0
    mode3 BYTE "3. Endless Mode - Play until score reaches 0!", 0
    modePrompt BYTE "Select Mode (1-3): ", 0

    timeRemaining DWORD 60
    startTime DWORD ?
    timeText BYTE "Time: ", 0
    secondsText BYTE "s", 0

    careerTarget BYTE 5
    careerGoalText BYTE "Goal: ", 0
    careerSlashText BYTE "/", 0

    careerWinMsg BYTE "===== CAREER MODE COMPLETE! =====", 0
    timeUpMsg BYTE "======== TIME'S UP! ========", 0
    congratsMsg BYTE "Congratulations! You completed the goal!", 0
    timeScoreMsg BYTE "Your Time Mode Score: ", 0

.code
main PROC
    call Clrscr
    
    call GetMseconds ; INITIALIZE RANDOM SEED FOR GAME
    mov seed, eax

ShowMainMenu:
    call DisplayMainMenu
    call GetMenuChoice
    
    movzx eax, menuChoice ; LOAD AND VALIDATE MENU SELECTION
    cmp eax, 1
    je StartNewGame
    cmp eax, 2
    je ContinueGame
    cmp eax, 3
    je ChangeDifficulty
    cmp eax, 4
    je ViewLeaderboard
    cmp eax, 5
    je ReadInstructions
    cmp eax, 6
    je ExitProgram
    
    jmp ShowMainMenu ; INVALID INPUT - REDISPLAY MENU

StartNewGame:
    call Clrscr
    mov inMainMenu, 0 ; FLAG THAT WE'RE LEAVING MAIN MENU

    call DisplayGameModeMenu ; SHOW GAME MODE SELECTION SCREEN
    call GetGameModeChoice
    
    call Clrscr
    
    mov edx, OFFSET playerPrompt ; GET PLAYER NAME INPUT
    call WriteString
    mov edx, OFFSET playerName
    mov ecx, 49
    call ReadString
    
    call Clrscr
    
    mov dh, 8 ; POSITION COLOR SELECTION TITLE
    mov dl, 15
    call Gotoxy
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov edx, OFFSET colorPrompt
    call WriteString
    call Crlf
    call Crlf
    
    mov dh, 11 ; DISPLAY YELLOW TAXI OPTION
    mov dl, 15
    call Gotoxy
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov edx, OFFSET colorOption1
    call WriteString
    
    mov dh, 12 ; DISPLAY RED TAXI OPTION
    mov dl, 15
    call Gotoxy
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov edx, OFFSET colorOption2
    call WriteString
    
    mov dh, 13 ; DISPLAY RANDOM SELECTION OPTION
    mov dl, 15
    call Gotoxy
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov edx, OFFSET colorOption3
    call WriteString
    
    mov dh, 16 ; DISPLAY INPUT PROMPT
    mov dl, 20
    call Gotoxy
    mov eax, white + (black * 16)
    call SetTextColor
    mov edx, OFFSET colorPrompt
    call WriteString
    mov al, ' '
    call WriteChar
    
GetColorChoice:
    call ReadChar ; WAIT FOR VALID COLOR SELECTION (1-3)
    
    cmp al, '1'
    je SetYellow
    cmp al, '2'
    je SetRed
    cmp al, '3'
    je SetRandom
    jmp GetColorChoice
    
SetRandom:
    mov eax, 2 ; GENERATE 0 OR 1 FOR RANDOM COLOR
    call RandomRange
    cmp eax, 0
    je RandomYellow
    jmp RandomRed
    
RandomYellow:
    mov dh, 18 ; DISPLAY "YELLOW SELECTED!" MESSAGE
    mov dl, 20
    call Gotoxy
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov edx, OFFSET colorPrompt
    mov BYTE PTR [edx], 'Y' ; MANUALLY BUILD "YELLOW SELECTED!" STRING
    mov BYTE PTR [edx+1], 'e'
    mov BYTE PTR [edx+2], 'l'
    mov BYTE PTR [edx+3], 'l'
    mov BYTE PTR [edx+4], 'o'
    mov BYTE PTR [edx+5], 'w'
    mov BYTE PTR [edx+6], ' '
    mov BYTE PTR [edx+7], 'S'
    mov BYTE PTR [edx+8], 'e'
    mov BYTE PTR [edx+9], 'l'
    mov BYTE PTR [edx+10], 'e'
    mov BYTE PTR [edx+11], 'c'
    mov BYTE PTR [edx+12], 't'
    mov BYTE PTR [edx+13], 'e'
    mov BYTE PTR [edx+14], 'd'
    mov BYTE PTR [edx+15], '!'
    mov BYTE PTR [edx+16], 0
    call WriteString
    
    mov eax, 1000 ; BRIEF DELAY TO SHOW MESSAGE
    call Delay
    jmp SetYellow
    
RandomRed:
    mov dh, 18 ; DISPLAY "RED SELECTED!" MESSAGE
    mov dl, 20
    call Gotoxy
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov edx, OFFSET colorPrompt
    mov BYTE PTR [edx], 'R' ; MANUALLY BUILD "RED SELECTED!" STRING
    mov BYTE PTR [edx+1], 'e'
    mov BYTE PTR [edx+2], 'd'
    mov BYTE PTR [edx+3], ' '
    mov BYTE PTR [edx+4], 'S'
    mov BYTE PTR [edx+5], 'e'
    mov BYTE PTR [edx+6], 'l'
    mov BYTE PTR [edx+7], 'e'
    mov BYTE PTR [edx+8], 'c'
    mov BYTE PTR [edx+9], 't'
    mov BYTE PTR [edx+10], 'e'
    mov BYTE PTR [edx+11], 'd'
    mov BYTE PTR [edx+12], '!'
    mov BYTE PTR [edx+13], 0
    call WriteString
    
    mov eax, 1000 ; BRIEF DELAY TO SHOW MESSAGE
    call Delay
    jmp SetRed

ContinueGame:
    call Clrscr ; PLACEHOLDER FOR FUTURE SAVE/LOAD FEATURE
    mov dh, 10
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET continueMsg
    call WriteString
    call ReadChar
    jmp ShowMainMenu

ChangeDifficulty:
    call DisplayDifficultyMenu ; SHOW DIFFICULTY SELECTION SCREEN
    call GetDifficultyChoice
    call ApplyDifficulty ; UPDATE GAME PARAMETERS BASED ON DIFFICULTY
    jmp ShowMainMenu

ViewLeaderboard:
    call Clrscr ; PLACEHOLDER FOR FUTURE LEADERBOARD FEATURE
    mov dh, 10
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET leaderboardMsg
    call WriteString
    call ReadChar
    jmp ShowMainMenu

ReadInstructions:
    call DisplayInstructions ; SHOW GAME INSTRUCTIONS SCREEN
    jmp ShowMainMenu

ExitProgram:
    call Clrscr
    jmp EndGame

SetYellow:
    mov taxiColor, 14 ; SET TAXI COLOR TO YELLOW (14)
    jmp ColorSet

SetRed:
    mov taxiColor, 4 ; SET TAXI COLOR TO RED (4)

ColorSet:
    call Clrscr
    call ApplyDifficulty ; APPLY DIFFICULTY SETTINGS
    call InitializeGrid ; CREATE BUILDING LAYOUT

    mov gameRunning, 1 ; RESET ALL GAME STATE VARIABLES
    mov dropCounter, 0
    mov speedLevel, 1
    mov showCollision, 0
    mov collisionTimer, 0
    mov activePassengerCount, 0
    mov gamePaused, 0
    mov moveCounter, 0
    
    mov taxiRow, 0 ; SPAWN TAXI AT TOP-LEFT CORNER
    mov taxiCol, 0
    mov hasPassenger, 0
    mov currentPassenger, 0

    call InitializeObstacles ; SPAWN ALL GAME OBJECTS
    call InitializeBonusItems
    call InitializeNPCCars
    call InitializePassengers
    call StartBackgroundMusic ; BEGIN BACKGROUND MUSIC LOOP
    
GameLoop:
    cmp gameRunning, 0 ; CHECK IF GAME SHOULD CONTINUE
    je CheckIfMenu
    jmp ContGame
    
CheckIfMenu:
    movzx eax, inMainMenu ; DETERMINE WHERE TO RETURN AFTER GAME ENDS
    cmp eax, 1
    je ShowMainMenu
    jmp EndGame
    
ContGame:
    movzx eax, gameMode ; BRANCH TO MODE-SPECIFIC WIN/LOSE CHECKS
    cmp eax, 1
    je CheckCareerMode
    cmp eax, 2
    je CheckTimeMode
    jmp CheckEndlessMode
    
CheckCareerMode:
    mov eax, dropCounter ; CHECK IF PLAYER REACHED DROP GOAL
    movzx ebx, careerTarget
    cmp eax, ebx
    jge CareerWin
    
    mov eax, score ; CHECK IF SCORE DROPPED TO ZERO OR BELOW
    cmp eax, 0
    jle GameOver
    jmp CntinueGame
    
CheckTimeMode:
    mov eax, timeRemaining ; CHECK IF TIME EXPIRED
    cmp eax, 0
    jle TimeUp
    
    mov eax, score ; ALSO CHECK SCORE IN TIME MODE
    cmp eax, 0
    jle GameOver
    jmp CntinueGame
    
CheckEndlessMode:
    mov eax, score ; ONLY WIN CONDITION IS SCORE <= 0
    cmp eax, 0
    jle GameOver

CntinueGame:
    inc moveCounter ; INCREMENT FRAME COUNTER FOR NPC TIMING
    
CheckSpeed1Move:
    mov eax, moveCounter ; SPEED LEVEL 1: MOVE NPC EVERY 3RD FRAME
    mov edx, 0
    mov ebx, 3
    div ebx
    cmp edx, 0
    jne SkipNPCMove
    call MoveNPCCars
    jmp SkipNPCMove
    
CheckSpeed2Move:
    mov eax, moveCounter ; SPEED LEVEL 2: MOVE NPC EVERY 2ND FRAME
    mov edx, 0
    mov ebx, 2
    div ebx
    cmp edx, 0
    jne SkipNPCMove
    call MoveNPCCars
    jmp SkipNPCMove
    
AlwaysMove:
    call MoveNPCCars ; SPEED LEVEL 3+: MOVE NPC EVERY FRAME
    
SkipNPCMove:
    call CheckNPCHitsTaxi ; CHECK FOR NPC CAR COLLISIONS
    movzx eax, taxiColor ; ADJUST GAME SPEED BASED ON TAXI COLOR
    cmp eax, 14
    je YellowSpeed
    
    mov eax, 120 ; RED TAXI MOVES SLOWER
    call Delay
    jmp AfterDelay
    
YellowSpeed:
    mov eax, 80 ; YELLOW TAXI MOVES FASTER
    call Delay
    
AfterDelay:
    mov eax, collisionTimer ; DECREMENT COLLISION MESSAGE TIMER
    cmp eax, 0
    je NoCollisionDisplay
    
    dec collisionTimer
    
    cmp collisionTimer, 0 ; HIDE MESSAGE WHEN TIMER REACHES ZERO
    jne NoCollisionDisplay
    mov showCollision, 0

NoCollisionDisplay:
    call EnsureMinimumPassengers ; MAINTAIN 3-5 ACTIVE PASSENGERS

    call Clrscr ; RENDER ALL GAME ELEMENTS
    call DisplayGr
    call DrawGrid
    call DrawObstacles
    call DrawBonusItems
    call DrawNPCCars
    call DrawPassengers
    call DrawDestination
    call DrawTaxi
    
    call GetInput ; PROCESS PLAYER INPUT
    jmp GameLoop

CareerWin:
    call StopBackgroundMusic ; STOP MUSIC AND PLAY WIN SOUND
    
    push edx
    mov edx, OFFSET soundWin
    call PlaySoundEffect
    pop edx

    call Clrscr
    
    mov dh, 10 ; CENTER VICTORY MESSAGE ON SCREEN
    mov dl, 18
    call Gotoxy
    
    mov eax, lightGreen + (black * 16) ; DISPLAY CAREER COMPLETE TITLE
    call SetTextColor
    mov edx, OFFSET careerWinMsg
    call WriteString
    call Crlf
    call Crlf
    
    mov dh, 12 ; DISPLAY CONGRATULATIONS MESSAGE
    mov dl, 15
    call Gotoxy
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov edx, OFFSET congratsMsg
    call WriteString
    call Crlf
    call Crlf
    
    mov dh, 14 ; DISPLAY FINAL SCORE
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET finalScoreMsg
    call WriteString
    mov eax, score
    call WriteDec
    call Crlf
    call Crlf
    
    mov dh, 16 ; DISPLAY RESTART/QUIT OPTIONS
    mov dl, 18
    call Gotoxy
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov edx, OFFSET restartMsg
    call WriteString
    jmp GameOverInput

TimeUp:
    call Clrscr
    
    mov dh, 10 ; CENTER TIME'S UP MESSAGE
    mov dl, 22
    call Gotoxy
    
    mov eax, lightCyan + (black * 16) ; DISPLAY TIME EXPIRED TITLE
    call SetTextColor
    mov edx, OFFSET timeUpMsg
    call WriteString
    call Crlf
    call Crlf
    
    mov dh, 12 ; DISPLAY FINAL TIME MODE SCORE
    mov dl, 20
    call Gotoxy
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov edx, OFFSET timeScoreMsg
    call WriteString
    mov eax, score
    call WriteDec
    call Crlf
    call Crlf
    
    mov dh, 14 ; DISPLAY TOTAL DROPS COMPLETED
    mov dl, 25
    call Gotoxy
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov edx, OFFSET dropCountText
    call WriteString
    mov eax, dropCounter
    call WriteDec
    call Crlf
    call Crlf
    
    mov dh, 16 ; DISPLAY RESTART/QUIT OPTIONS
    mov dl, 18
    call Gotoxy
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov edx, OFFSET restartMsg
    call WriteString
    jmp GameOverInput

GameOver:
    call StopBackgroundMusic ; STOP MUSIC AND PLAY GAME OVER SOUND
    
    push edx
    mov edx, OFFSET soundGameOver
    call PlaySoundEffect
    pop edx

    call Clrscr
    
    mov dh, 10 ; CENTER GAME OVER MESSAGE
    mov dl, 20
    call Gotoxy
    
    mov eax, lightRed + (black * 16) ; DISPLAY GAME OVER TITLE
    call SetTextColor
    mov edx, OFFSET gameOverMsg
    call WriteString
    call Crlf
    call Crlf
    
    mov dh, 12 ; DISPLAY FINAL SCORE (SUPPORTS NEGATIVE)
    mov dl, 25
    call Gotoxy
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov edx, OFFSET finalScoreMsg
    call WriteString
    mov eax, score
    call WriteInt
    call Crlf
    call Crlf
    
    mov dh, 14 ; DISPLAY RESTART/QUIT OPTIONS
    mov dl, 18
    call Gotoxy
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov edx, OFFSET restartMsg
    call WriteString
    
GameOverInput:
    call ReadChar ; WAIT FOR R (RESTART) OR Q (QUIT)
    
    cmp al, 'r'
    je RestrtGme
    cmp al, 'R'
    je RestrtGme
    cmp al, 'q'
    je EndGame
    cmp al, 'Q'
    je EndGame
    jmp GameOverInput

RestrtGme:
    call GetMseconds ; GENERATE NEW RANDOM SEED
    mov seed, eax
    
    mov eax, currentStartScore ; RESET SCORE TO STARTING VALUE
    mov score, eax
    
    mov dropCounter, 0 ; RESET GAME COUNTERS AND FLAGS
    mov speedLevel, 1
    mov showCollision, 0
    mov collisionTimer, 0
    mov activePassengerCount, 0

    mov taxiRow, 0 ; RESET TAXI TO STARTING POSITION
    mov taxiCol, 0
    
    mov gameRunning, 1 ; RESET GAME STATE
    mov hasPassenger, 0
    mov currentPassenger, 0

    movzx eax, gameMode ; RESET TIME MODE IF APPLICABLE
    cmp eax, 2
    jne SkipTimeReset
    
    mov timeRemaining, 60
    call GetMseconds
    mov startTime, eax
    
SkipTimeReset:
    mov ecx, MAX_PASSENGERS ; CLEAR ALL PASSENGER DATA
    mov esi, 0
ClearPassengers:
    mov passengerActive[esi], 0
    mov passengerRow[esi], 0
    mov passengerCol[esi], 0
    mov destRow[esi], 0
    mov destCol[esi], 0
    inc esi
    loop ClearPassengers
    
    mov ecx, MAX_OBSTACLES ; CLEAR ALL OBSTACLE DATA
    mov esi, 0
ClearObstacles:
    mov obstacleActive[esi], 0
    mov obstacleRow[esi], 0
    mov obstacleCol[esi], 0
    mov obstacleType[esi], 0
    inc esi
    loop ClearObstacles
    
    mov ecx, MAX_BONUS ; CLEAR ALL BONUS ITEM DATA
    mov esi, 0
ClearBonus:
    mov bonusActive[esi], 0
    mov bonusRow[esi], 0
    mov bonusCol[esi], 0
    inc esi
    loop ClearBonus
    
    movzx ecx, currentMaxNPCCars ; CLEAR ALL NPC CAR DATA
    mov esi, 0
ClearNPCCars:
    mov npcCarActive[esi], 0
    mov npcCarRow[esi], 0
    mov npcCarCol[esi], 0
    inc esi
    loop ClearNPCCars
    
    mov moveCounter, 0 ; RESET FRAME COUNTER
    mov ecx, GRID_SIZE * GRID_SIZE ; CLEAR ENTIRE GRID
    mov esi, 0

ClearGrid:
    mov grid[esi], 0
    inc esi
    loop ClearGrid
    
    call Clrscr
    
    call InitializeGrid ; REINITIALIZE ALL GAME ELEMENTS
    call InitializePassengers
    call InitializeObstacles
    call InitializeBonusItems
    call InitializeNPCCars
    
    mov dh, 16 ; PROMPT FOR MENU OR RESTART
    mov dl, 15
    call Gotoxy
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov edx, OFFSET returnMenuMsg
    call WriteString

    call ReadChar ; WAIT FOR M (MENU) OR ANY KEY (PLAY)
    cmp al, 'm'
    je BackToMenu
    cmp al, 'M'
    je BackToMenu
    jmp GameLoop

BackToMenu:
    mov inMainMenu, 1 ; FLAG RETURNING TO MAIN MENU
    jmp ShowMainMenu
    
EndGame:
    call StopBackgroundMusic ; CLEANUP AND EXIT
    call ReadChar
    exit
main ENDP

DisplayMainMenu PROC
    push eax
    push edx
    
    call Clrscr
    
    mov dh, 5 ; POSITION AND DISPLAY MENU TITLE BORDER
    mov dl, 20
    call Gotoxy
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov edx, OFFSET menuTitle1
    call WriteString
    
    mov dh, 6 ; DISPLAY GAME TITLE
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET menuTitle2
    call WriteString
    
    mov dh, 7 ; DISPLAY BOTTOM BORDER
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET menuTitle3
    call WriteString
    call Crlf
    call Crlf
    
    mov eax, lightCyan + (black * 16) ; SET COLOR FOR MENU OPTIONS
    call SetTextColor
    
    mov dh, 10 ; DISPLAY EACH MENU OPTION
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET menu1
    call WriteString
    
    mov dh, 11
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET menu2
    call WriteString
    
    mov dh, 12
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET menu3
    call WriteString
    
    mov dh, 13
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET menu4
    call WriteString
    
    mov dh, 14
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET menu5
    call WriteString
    
    mov dh, 15 ; DISPLAY EXIT OPTION IN RED
    mov dl, 25
    call Gotoxy
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov edx, OFFSET menu6
    call WriteString
    
    mov dh, 18 ; DISPLAY SELECTION PROMPT
    mov dl, 25
    call Gotoxy
    mov eax, white + (black * 16)
    call SetTextColor
    mov edx, OFFSET menuPrompt
    call WriteString
    
    pop edx
    pop eax
    ret
DisplayMainMenu ENDP

GetMenuChoice PROC
    push eax
    
GetChoice:
    call ReadChar ; WAIT FOR VALID INPUT (1-6)
    
    cmp al, '1'
    jl GetChoice
    cmp al, '6'
    jg GetChoice

    push edx ; PLAY MENU CLICK SOUND
    mov edx, OFFSET soundClick
    call PlaySoundEffect
    pop edx
    
    sub al, '0' ; CONVERT ASCII TO NUMERIC VALUE
    mov menuChoice, al
    
    pop eax
    ret
GetMenuChoice ENDP

DisplayInstructions PROC
    push eax
    push edx
    
    call Clrscr
    
    mov dh, 3 ; POSITION AND DISPLAY INSTRUCTIONS TITLE
    mov dl, 15
    call Gotoxy
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov edx, OFFSET instTitle
    call WriteString
    call Crlf
    call Crlf
    
    mov eax, lightGray + (black * 16) ; SET COLOR FOR INSTRUCTION TEXT
    call SetTextColor
    
    mov dh, 6 ; DISPLAY EACH INSTRUCTION LINE
    mov dl, 10
    call Gotoxy
    mov edx, OFFSET inst1
    call WriteString
    
    mov dh, 7
    mov dl, 10
    call Gotoxy
    mov edx, OFFSET inst2
    call WriteString
    
    mov dh, 8
    mov dl, 10
    call Gotoxy
    mov edx, OFFSET inst3
    call WriteString
    
    mov dh, 9
    mov dl, 10
    call Gotoxy
    mov edx, OFFSET inst4
    call WriteString
    
    mov dh, 10
    mov dl, 10
    call Gotoxy
    mov edx, OFFSET inst5
    call WriteString
    
    mov dh, 11
    mov dl, 10
    call Gotoxy
    mov edx, OFFSET inst6
    call WriteString
    
    mov dh, 13 ; DISPLAY YELLOW TAXI PENALTIES
    mov dl, 10
    call Gotoxy
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov edx, OFFSET inst7
    call WriteString
    
    mov dh, 14 ; DISPLAY RED TAXI PENALTIES
    mov dl, 10
    call Gotoxy
    mov edx, OFFSET inst8
    call WriteString
    
    mov dh, 16 ; DISPLAY GENERAL PENALTIES
    mov dl, 10
    call Gotoxy
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov edx, OFFSET inst9
    call WriteString
    
    mov dh, 17 ; DISPLAY DESTINATION INFO
    mov dl, 10
    call Gotoxy
    mov edx, OFFSET inst10
    call WriteString
    
    mov dh, 20 ; DISPLAY RETURN PROMPT
    mov dl, 20
    call Gotoxy
    mov eax, white + (black * 16)
    call SetTextColor
    mov edx, OFFSET instBack
    call WriteString
    
    call ReadChar ; WAIT FOR ANY KEY
    
    pop edx
    pop eax
    ret
DisplayInstructions ENDP

InitializeGrid PROC
    push eax
    push ebx
    push ecx
    push edx
    push edi
    
    mov ebx, 1 ; BUILD STRUCTURE #1: 3x4 BUILDING
    mov ecx, 3
L1:
    push ecx
    mov ecx, 4
    mov edi, 1
L2:
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, edi
    mov BYTE PTR [grid + eax], 1
    inc edi
    loop L2
    pop ecx
    inc ebx
    loop L1
    
    mov ebx, 1 ; BUILD STRUCTURE #2: 2x3 BUILDING
    mov ecx, 2
L3:
    push ecx
    mov ecx, 3
    mov edi, 8
L4:
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, edi
    mov BYTE PTR [grid + eax], 1
    inc edi
    loop L4
    pop ecx
    inc ebx
    loop L3
    
    mov ebx, 1 ; BUILD STRUCTURE #3: 4x3 BUILDING
    mov ecx, 4
L5:
    push ecx
    mov ecx, 3
    mov edi, 16
L6:
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, edi
    mov BYTE PTR [grid + eax], 1
    inc edi
    loop L6
    pop ecx
    inc ebx
    loop L5
    
    mov ebx, 6 ; BUILD STRUCTURE #4: 3x2 BUILDING
    mov ecx, 3
L7:
    push ecx
    mov ecx, 2
    mov edi, 2
L8:
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, edi
    mov BYTE PTR [grid + eax], 1
    inc edi
    loop L8
    pop ecx
    inc ebx
    loop L7
    
    mov ebx, 8 ; BUILD STRUCTURE #5: 4x4 BUILDING
    mov ecx, 4
L9:
    push ecx
    mov ecx, 4
    mov edi, 7
L10:
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, edi
    mov BYTE PTR [grid + eax], 1
    inc edi
    loop L10
    pop ecx
    inc ebx
    loop L9
    
    mov ebx, 7 ; BUILD STRUCTURE #6: 3x3 BUILDING
    mov ecx, 3
L11:
    push ecx
    mov ecx, 3
    mov edi, 15
L12:
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, edi
    mov BYTE PTR [grid + eax], 1
    inc edi
    loop L12
    pop ecx
    inc ebx
    loop L11
    
    mov ebx, 13 ; BUILD STRUCTURE #7: 3x4 BUILDING
    mov ecx, 3
L13:
    push ecx
    mov ecx, 4
    mov edi, 1
L14:
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, edi
    mov BYTE PTR [grid + eax], 1
    inc edi
    loop L14
    pop ecx
    inc ebx
    loop L13
    
    mov ebx, 14 ; BUILD STRUCTURE #8: 2x3 BUILDING
    mov ecx, 2
L15:
    push ecx
    mov ecx, 3
    mov edi, 8
L16:
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, edi
    mov BYTE PTR [grid + eax], 1
    inc edi
    loop L16
    pop ecx
    inc ebx
    loop L15
    
    mov ebx, 15 ; BUILD STRUCTURE #9: 3x3 BUILDING
    mov ecx, 3
L17:
    push ecx
    mov ecx, 3
    mov edi, 16
L18:
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, edi
    mov BYTE PTR [grid + eax], 1
    inc edi
    loop L18
    pop ecx
    inc ebx
    loop L17
    
    mov ebx, 4 ; BUILD STRUCTURE #10: 2x2 BUILDING
    mov ecx, 2
L19:
    push ecx
    mov ecx, 2
    mov edi, 13
L20:
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, edi
    mov BYTE PTR [grid + eax], 1
    inc edi
    loop L20
    pop ecx
    inc ebx
    loop L19
    
    mov ebx, 17 ; BUILD STRUCTURE #11: 2x2 BUILDING
    mov ecx, 2
L21:
    push ecx
    mov ecx, 2
    mov edi, 5
L22:
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, edi
    mov BYTE PTR [grid + eax], 1
    inc edi
    loop L22
    pop ecx
    inc ebx
    loop L21
    
    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
InitializeGrid ENDP

DisplayGr PROC
    push eax
    push edx
    push ebx
    
    mov dh, 0 ; POSITION CURSOR AT TOP-LEFT
    mov dl, 0
    call Gotoxy
    
    mov eax, yellow + (black * 16) ; DISPLAY GAME TITLE
    call SetTextColor
    mov edx, OFFSET gameTitle
    call WriteString
    call Crlf
    call Crlf
    
    mov eax, lightCyan + (black * 16) ; DISPLAY PLAYER NAME
    call SetTextColor
    mov edx, OFFSET playerName
    call WriteString
    
    mov dh, 2 ; MOVE TO SCORE LINE
    mov dl, 0
    call Gotoxy
    
    mov edx, OFFSET scoreText ; DISPLAY CURRENT SCORE
    call WriteString
    mov eax, score
    call WriteDec
    call Crlf
    call Crlf

    movzx eax, gameMode ; DETERMINE WHICH MODE INFO TO DISPLAY
    cmp eax, 1
    je DisplayCareerInfo
    cmp eax, 2
    je DisplayTimeInfo
    jmp DisplayEndlessInfo
    
DisplayCareerInfo:
    mov dh, 3 ; SHOW CAREER MODE PROGRESS (X/5)
    mov dl, 0
    call Gotoxy
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov edx, OFFSET careerGoalText
    call WriteString
    mov eax, dropCounter
    call WriteDec
    mov edx, OFFSET careerSlashText
    call WriteString
    movzx eax, careerTarget
    call WriteDec
    call Crlf
    jmp DisplayCommonInfo
    
DisplayTimeInfo:
    call GetMseconds ; CALCULATE TIME REMAINING
    mov ebx, eax
    sub ebx, startTime
    mov eax, ebx
    mov edx, 0
    mov ecx, 1000
    div ecx
    
    mov ebx, 60 ; COMPUTE SECONDS REMAINING
    sub ebx, eax
    cmp ebx, 0
    jge TimePositive
    mov ebx, 0
    
TimePositive:
    mov timeRemaining, ebx
    
    mov dh, 3 ; DISPLAY TIME REMAINING
    mov dl, 0
    call Gotoxy
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov edx, OFFSET timeText
    call WriteString
    mov eax, timeRemaining
    call WriteDec
    mov edx, OFFSET secondsText
    call WriteString
    call Crlf
    jmp DisplayCommonInfo
    
DisplayEndlessInfo:
    mov dh, 3 ; SHOW DROPS AND SPEED LEVEL
    mov dl, 0
    call Gotoxy
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov edx, OFFSET dropCountText
    call WriteString
    mov eax, dropCounter
    call WriteDec
    
    mov edx, OFFSET speedLevelText
    call WriteString
    mov eax, speedLevel
    call WriteDec
    call Crlf

DisplayCommonInfo:
    movzx eax, showCollision ; CHECK IF COLLISION MESSAGE ACTIVE
    cmp eax, 0
    je NoCollisionMsg
    
    mov eax, collisionTimer ; VERIFY TIMER HASN'T EXPIRED
    cmp eax, 0
    je NoCollisionMsg
    
    mov eax, lightRed + (black * 16) ; DISPLAY COLLISION MESSAGE
    call SetTextColor
    mov edx, OFFSET collisionMsg
    call WriteString
    mov edx, OFFSET collisionType
    call WriteString
    call Crlf
    
NoCollisionMsg:
    pop ebx
    pop edx
    pop eax
    ret
DisplayGr ENDP


DrawGrid PROC
    push eax
    push ebx
    push ecx
    push edx
    
    mov ebx, 0              ;COUNTER FOR R
    
DrawRows:
    cmp ebx, GRID_SIZE
    jge EndDrawGrid
    
    mov eax, ebx    ;CURSOR POS
    mov dh, al
    add dh, 5               ;R=5
    mov dl, 10              
    call Gotoxy
    
    mov ecx, 0              ;COUNTER FOR COL
    
DrawCols:
    cmp ecx, GRID_SIZE
    jge NextRow
    
    mov eax, ebx                  ;grid index= row * GRID_SIZE + col
    imul eax, GRID_SIZE
    add eax, ecx
    
    movzx eax, BYTE PTR [grid + eax]       ;BUILDING DRAW
    cmp eax, 1
    je DrawBuilding
    
    mov eax, black + (white * 16)       ;ROAD DRAW
    call SetTextColor
    mov al, ' '
    call WriteChar
    call WriteChar         
    jmp ContinueDrawing
    
DrawBuilding:
    mov eax, (black * 16)
    call SetTextColor
    mov al, 219            
    call WriteChar
    call WriteChar
    
ContinueDrawing:
    inc ecx
    jmp DrawCols
    
NextRow:
    inc ebx
    jmp DrawRows
    
EndDrawGrid:
    mov eax, lightGray + (black * 16)      ;RESET COLOR
    call SetTextColor
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DrawGrid ENDP

DrawTaxi PROC
    push eax
    push edx
 
    movzx eax, taxiRow      ;SCREEN POS
    add eax, 5                
    mov dh, al
    
    movzx eax, taxiCol
    imul eax, 2               
    add eax, 10                
    mov dl, al
    
    call Gotoxy
    
    movzx eax, taxiColor
    imul eax, 16                
    add eax, black              
    call SetTextColor
    
    mov al, 'T'
    call WriteChar
    call WriteChar
    
    mov eax, lightGray + (black * 16)       ;RESET COLOR
    call SetTextColor
    
    pop edx
    pop eax
    ret
DrawTaxi ENDP

InitializePassengers PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    mov eax, seed          ;DET NUM PASSEN
    call RandomRange
    mov eax, 3
    add eax, seed
    and eax, 3
    add eax, 3
    mov ecx, eax
    
    mov esi, 0
    
SpawnLoop:
    cmp esi, ecx
    jge DoneSpawning
    
FindValidPos:
    mov eax, GRID_SIZE     ;RAND ROW
    call RandomRange
    mov bl, al
    
    mov eax, GRID_SIZE     ;RAND COL
    call RandomRange
    mov bh, al
    
    movzx eax, bl                    ;CHECK FOR ROAD
    imul eax, GRID_SIZE
    movzx edx, bh
    add eax, edx
    movzx eax, BYTE PTR [grid + eax]
    cmp eax, 1                  
    je FindValidPos             ;BUILDING AGAIN KARO
    
    ; Check not taxi position (0,0)
    cmp bl, 0
    jne CheckObstacles
    cmp bh, 0
    je FindValidPos
    
CheckObstacles:
    mov edi, 0          ;OBST CHECK
CheckObsLoop:
    cmp edi, MAX_OBSTACLES
    jge CheckBonus
    
    movzx eax, obstacleActive[edi]
    cmp eax, 0
    je NextObs
    
    movzx eax, obstacleRow[edi]
    cmp al, bl
    jne NextObs
    movzx eax, obstacleCol[edi]
    cmp al, bh
    je FindValidPos         ;OBSTACLE, AGAIN KARO
    
NextObs:
    inc edi
    jmp CheckObsLoop
    
CheckBonus:
    mov edi, 0
CheckBonusLoop:
    cmp edi, MAX_BONUS
    jge CheckNPCCars
    
    movzx eax, bonusActive[edi]
    cmp eax, 0
    je NextBonus
    
    movzx eax, bonusRow[edi]
    cmp al, bl
    jne NextBonus
    movzx eax, bonusCol[edi]
    cmp al, bh
    je FindValidPos         ;BONUS, AGAIN KARO
    
NextBonus:
    inc edi
    jmp CheckBonusLoop

CheckNPCCars:
    mov edi, 0
CheckNPCLoop:
    cmp edi, MAX_NPC_CARS
    jge FinalValidation
    
    movzx eax, npcCarActive[edi]
    cmp eax, 0
    je NextNPC
    
    movzx eax, npcCarRow[edi]
    cmp al, bl
    jne NextNPC
    movzx eax, npcCarCol[edi]
    cmp al, bh
    je FindValidPos         ;NPC, AGAIN KARO
    
NextNPC:
    inc edi
    jmp CheckNPCLoop

FinalValidation:
    movzx eax, bl
    imul eax, GRID_SIZE
    movzx edx, bh
    add eax, edx
    movzx eax, BYTE PTR [grid + eax]
    cmp eax, 1
    je FindValidPos         ;ON BUILDING, AGAIN KARO
    
PosOK:
    mov passengerRow[esi], bl         ;STORE PASS POS
    mov passengerCol[esi], bh
    mov passengerActive[esi], 1
    
    inc esi
    jmp SpawnLoop
    
DoneSpawning:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
InitializePassengers ENDP

; Input: esi = PASS IND
GenerateDestination PROC
    push eax
    push ebx
    push edx
    
FindValidDest:
    mov eax, GRID_SIZE       ;RAND ROW
    call RandomRange
    mov bl, al
    
    mov eax, GRID_SIZE        ;RAND COL
    call RandomRange
    mov bh, al
    
    movzx eax, bl
    imul eax, GRID_SIZE
    movzx edx, bh
    add eax, edx
    movzx eax, BYTE PTR [grid + eax]
    cmp eax, 1
    je FindValidDest
    
    mov al, passengerRow[esi]
    cmp al, bl
    jne DestOK
    mov al, passengerCol[esi]
    cmp al, bh
    je FindValidDest        ;SAME AS PICKUP, AGAIN KARO
    
DestOK:
    ; Store destination
    mov destRow[esi], bl
    mov destCol[esi], bh
    
    pop edx
    pop ebx
    pop eax
    ret
GenerateDestination ENDP

DrawPassengers PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov esi, 0
    
DrawPassLoop:
    cmp esi, MAX_PASSENGERS
    jge EndDrawPass
    
    movzx eax, passengerActive[esi]          ;IS PASS ACTIVE
    cmp eax, 0
    je NextPass
    
    movzx eax, passengerRow[esi]      ;SCREEN POS
    add eax, 5 
    mov dh, al
    
    movzx eax, passengerCol[esi]
    imul eax, 2
    add eax, 10
    mov dl, al
    
    call Gotoxy
    
    mov eax, yellow + (blue * 16)
    call SetTextColor
    
    mov al, 'P'
    call WriteChar
    call WriteChar
    
NextPass:
    inc esi
    jmp DrawPassLoop
    
EndDrawPass:
    mov eax, lightGray + (black * 16)       ;RESET COLOR
    call SetTextColor
    
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DrawPassengers ENDP

DrawDestination PROC
    push eax
    push ebx
    push edx
    
    movzx eax, hasPassenger        ;CHECK IF PASSENGER IN TAXI
    cmp eax, 0
    je NoDestination
    
    movzx ebx, currentPassenger        ;POS OF DEST
    
    movzx eax, destRow[ebx]           ;CALCULATE SCREEN POS
    add eax, 5
    mov dh, al
    
    movzx eax, destCol[ebx]
    imul eax, 2
    add eax, 10
    mov dl, al
    
    call Gotoxy
    
    mov eax, black + (green * 16)
    call SetTextColor
    
    mov al, 'D'           ;DRAW DESTINATION
    call WriteChar
    call WriteChar
    
NoDestination:
    mov eax, lightGray + (black * 16)     ;RESET COOLOR
    call SetTextColor
    
    pop edx
    pop ebx
    pop eax
    ret
DrawDestination ENDP

TryPickup PROC
    push eax
    push ebx
    push ecx
    push esi
    
    mov esi, 0
    
CheckPassengers:
    cmp esi, MAX_PASSENGERS
    jge NoPickup
    
    movzx eax, passengerActive[esi]        ;CHECKING IF PASSENGER IS ACTIVE
    cmp eax, 0
    je NextCheck
    
    movzx eax, taxiRow              ;CHECING IF TAXI NEXT TO IT
    movzx ebx, passengerRow[esi]
    sub eax, ebx
    cmp eax, -1           ;CHECKING IF DIFF -1,0,1
    jl NextCheck
    cmp eax, 1
    jg NextCheck
    
    movzx eax, taxiCol
    movzx ebx, passengerCol[esi]
    sub eax, ebx
    cmp eax, -1
    jl NextCheck
    cmp eax, 1
    jg NextCheck
    
    mov passengerActive[esi], 0       ;PICKUP PASSENGER
    mov hasPassenger, 1
    mov eax, esi
    mov cl, al
    mov currentPassenger, cl

    push edx
    mov edx, OFFSET soundPickup
    call PlaySoundEffect
    pop edx
    
    push esi           ;GENERATE DEST ONLY WHEN PASSEN IS PICKED UP
    call GenerateDestination
    pop esi
    
    jmp NoPickup
    
NextCheck:
    inc esi
    jmp CheckPassengers
    
NoPickup:
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret
TryPickup ENDP

TryDropoff PROC
    push eax
    push ebx
    
    movzx ebx, currentPassenger    ;CURR PASSENGER'S DEST
    
    movzx eax, taxiRow             ;CHECKING IF AT DEST
    cmp al, destRow[ebx]
    jne NoDropoff
    
    movzx eax, taxiCol
    cmp al, destCol[ebx]
    jne NoDropoff
    
    mov hasPassenger, 0        ;SUCCESSFUL DROP
    add score, 10         

    push edx
    mov edx, OFFSET soundDrop
    call PlaySoundEffect
    pop edx
    
    inc dropCounter
    
    mov eax, dropCounter            ;INC SPEED IF 2 DROPS SUCCESSFULLY
    mov edx, 0
    mov ebx, 2
    div ebx
    cmp edx, 0              ;CHECKING IF DIVISIBLE BY 2
    jne SkipSpeedIncrease
    
    inc speedLevel                 ;INC SPEED
     
SkipSpeedIncrease:
    call SpawnNewPassenger
    
    call UpdatePassengerCount       ;UPDATING PASSENGER COUNT
    
NoDropoff:
    pop ebx
    pop eax
    ret
TryDropoff ENDP

SpawnNewPassenger PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov esi, 0       ;FINDING NEW PASSENGER SLOT
FindSlot:
    cmp esi, MAX_PASSENGERS
    jge NoSpawn
    
    movzx eax, passengerActive[esi]
    cmp eax, 0
    je FoundSlot
    
    inc esi
    jmp FindSlot
    
FoundSlot:

FindPos:
    mov eax, GRID_SIZE
    call RandomRange
    mov bl, al
    
    mov eax, GRID_SIZE
    call RandomRange
    mov bh, al
    
    movzx eax, bl               ;CHECK FOR ROAD
    imul eax, GRID_SIZE
    movzx edx, bh
    add eax, edx
    movzx eax, BYTE PTR [grid + eax]
    cmp eax, 1              ; 1->BUILDING
    je FindPos             ;AGAIN
    
    movzx eax, taxiRow
    cmp al, bl
    jne CheckNotOnObstacle
    movzx eax, taxiCol
    cmp al, bh
    je FindPos              ;ON TAXI, AGAIN KARO
    
CheckNotOnObstacle:
    push edi
    mov edi, 0
CheckObstacleInSpawn:
    cmp edi, MAX_OBSTACLES
    jge DoneCheckingObstacles
    
    movzx eax, obstacleActive[edi]
    cmp eax, 0
    je NextObstacleInSpawn
    
    movzx eax, obstacleRow[edi]
    cmp al, bl
    jne NextObstacleInSpawn
    movzx eax, obstacleCol[edi]
    cmp al, bh
    je ObstacleFoundInSpawn
    
NextObstacleInSpawn:
    inc edi
    jmp CheckObstacleInSpawn
    
ObstacleFoundInSpawn:
    pop edi
    jmp FindPos             
    
DoneCheckingObstacles:
    pop edi
    mov passengerRow[esi], bl       ;STORING PASSEN POS
    mov passengerCol[esi], bh
    mov passengerActive[esi], 1
    
NoSpawn:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
SpawnNewPassenger ENDP

InitializeObstacles PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov esi, 0
    
ObstacleLoop:
    movzx eax, currentMaxObstacles
    cmp esi, eax
    jge DoneObstacles
    
FindObstaclePos:
    mov eax, GRID_SIZE        ;RANDOM ROW
    call RandomRange
    mov bl, al
    
    mov eax, GRID_SIZE        ;RANDOM COL
    call RandomRange
    mov bh, al
    
    cmp bl, 0              ; NOT AT(0,0)
    jne CheckIfRoad
    cmp bh, 0
    je FindObstaclePos      ;IF BOTH 0, AGAIN KARO
    
CheckIfRoad:
    movzx eax, bl         ;CHECKING IF VALID POS
    imul eax, GRID_SIZE
    movzx edx, bh
    add eax, edx
    movzx eax, BYTE PTR [grid + eax]
    cmp eax, 1
    je FindObstaclePos      ;ON BUILDING AGAIN KARO
    
    cmp bl, 0                       ;NOT AT (0,0)
    jne CheckExistingObstacles
    cmp bh, 0
    je FindObstaclePos
    
CheckExistingObstacles:
    ;CHECKING NO OBST AT THIS POS
    push esi                ;SAVING CURR INDEX
    mov edi, 0
CheckObsOverlap:
    cmp edi, esi           
    jge NoOverlap
    
    movzx eax, obstacleActive[edi]
    cmp eax, 0
    je NextObsCheck
    
    movzx eax, obstacleRow[edi]
    cmp al, bl
    jne NextObsCheck
    movzx eax, obstacleCol[edi]
    cmp al, bh
    je ObstacleOverlap      ;OBST OVERLAP, AGAIN KARO
    
NextObsCheck:
    inc edi
    jmp CheckObsOverlap
    
ObstacleOverlap:
    pop esi                
    jmp FindObstaclePos    
    
NoOverlap:
    pop esi                 ;RESTORING INDEX
    
ObsPosOK:
    mov obstacleRow[esi], bl          ;STROING OBST POS
    mov obstacleCol[esi], bh
    mov obstacleType[esi], 0
    mov obstacleActive[esi], 1
    
    inc esi
    jmp ObstacleLoop
    
DoneObstacles:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
InitializeObstacles ENDP

InitializeBonusItems PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov esi, 0
    
BonusLoop:
    cmp esi, MAX_BONUS
    jge DoneBonus
    
FindBonusPos:
    mov eax, GRID_SIZE         ;RANDOM ROW
    call RandomRange
    mov bl, al
    
    mov eax, GRID_SIZE         ;RANDOM COL
    call RandomRange
    mov bh, al
    
    movzx eax, bl
    imul eax, GRID_SIZE
    movzx edx, bh
    add eax, edx
    movzx eax, BYTE PTR [grid + eax]
    cmp eax, 1
    je FindBonusPos
    
    cmp bl, 0              ;CHECKING NOT AT 0,0
    jne BonusPosOK
    cmp bh, 0
    je FindBonusPos
    
BonusPosOK:
    mov bonusRow[esi], bl          ;STORING BONUS POS
    mov bonusCol[esi], bh
    mov bonusActive[esi], 1
    
    inc esi
    jmp BonusLoop
    
DoneBonus:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
InitializeBonusItems ENDP

InitializeNPCCars PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    mov esi, 0
    
NPCCarLoop:
    movzx eax, currentMaxNPCCars
    cmp esi, eax
    jge DoneNPCCars

FindNPCPos:
    mov eax, GRID_SIZE        ;RAND ROW
    call RandomRange
    mov bl, al
    
    mov eax, GRID_SIZE       ;RAND COL
    call RandomRange
    mov bh, al
    
    movzx eax, bl          ;CHECKING FOR VALID POS
    imul eax, GRID_SIZE
    movzx edx, bh
    add eax, edx
    movzx eax, BYTE PTR [grid + eax]
    cmp eax, 1
    je FindNPCPos        ;ON BUILDING, AGAIN KARO
    
    cmp bl, 0           ;CHECKING IF AT (0,0)
    jne CheckNotOnObstacles
    cmp bh, 0
    je FindNPCPos

CheckNotOnObstacles:
    mov edi, 0
CheckObsNPC:
    cmp edi, MAX_OBSTACLES
    jge CheckNotOnPassengers
    
    movzx eax, obstacleActive[edi]
    cmp eax, 0
    je NextObsNPC
    
    movzx eax, obstacleRow[edi]
    cmp al, bl
    jne NextObsNPC
    movzx eax, obstacleCol[edi]
    cmp al, bh
    je FindNPCPos        ;ON OBSTACLE, AGAIN KARO
    
NextObsNPC:
    inc edi
    jmp CheckObsNPC

CheckNotOnPassengers:
    mov edi, 0
CheckPassNPC:
    cmp edi, MAX_PASSENGERS
    jge CheckNotOnOtherNPCs
    
    movzx eax, passengerActive[edi]
    cmp eax, 0
    je NextPassNPC
    
    movzx eax, passengerRow[edi]
    cmp al, bl
    jne NextPassNPC
    movzx eax, passengerCol[edi]
    cmp al, bh
    je FindNPCPos                ;ON PASSENGER, AGAIN KARO
    
NextPassNPC:
    inc edi
    jmp CheckPassNPC

CheckNotOnOtherNPCs:
    mov edi, 0
CheckOtherNPCs:
    cmp edi, esi        
    jge NPCPosOK
    
    movzx eax, npcCarActive[edi]
    cmp eax, 0
    je NextNPCCheck
    
    movzx eax, npcCarRow[edi]
    cmp al, bl
    jne NextNPCCheck
    movzx eax, npcCarCol[edi]
    cmp al, bh
    je FindNPCPos        ;ON ANOTHER NPC , AGAIN KARO
    
NextNPCCheck:
    inc edi
    jmp CheckOtherNPCs

NPCPosOK:
    mov npcCarRow[esi], bl          ;STORING NPC CAR'S POS
    mov npcCarCol[esi], bh
    mov npcCarActive[esi], 1
    
    mov eax, 4
    call RandomRange
    mov npcCarDirection[esi], al
    
    ;Colors: blue=1, green=2, cyan=3, magenta=5, lightBlue=9, lightGreen=10
    mov eax, esi            ;CYCLING THROUGH COLORS FOR VARIETY 
    mov edx, 0
    mov ebx, 6
    div ebx              ; edx = REMAINDER(0-5)
    
    cmp edx, 0
    je UseBlue
    cmp edx, 1
    je UseGreen
    cmp edx, 2
    je UseCyan
    cmp edx, 3
    je UseMagenta
    cmp edx, 4
    je UseLightBlue
    jmp UseLightGreen

UseBlue:
    mov npcCarColor[esi], 1
    jmp DoneColor
UseGreen:
    mov npcCarColor[esi], 2
    jmp DoneColor
UseCyan:
    mov npcCarColor[esi], 3
    jmp DoneColor
UseMagenta:
    mov npcCarColor[esi], 5
    jmp DoneColor
UseLightBlue:
    mov npcCarColor[esi], 9
    jmp DoneColor
UseLightGreen:
    mov npcCarColor[esi], 10

DoneColor:
    inc esi
    jmp NPCCarLoop

DoneNPCCars:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
InitializeNPCCars ENDP

DrawObstacles PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov esi, 0
    
DrawObsLoop:
    cmp esi, MAX_OBSTACLES
    jge EndDrawObs
    
    movzx eax, obstacleActive[esi]        ;CHECKING IF OBSTACLE IS ACTIVE
    cmp eax, 0
    je NextObs

    movzx eax, obstacleRow[esi]
    cmp al, 0
    jne DrawThisObstacle
    movzx eax, obstacleCol[esi]
    cmp al, 0
    je NextObs              ;SKIPPING IF OBST AT (0,0)
    
DrawThisObstacle:
    movzx eax, obstacleRow[esi]           ;SCREEN POS
    add eax, 5
    mov dh, al
    
    movzx eax, obstacleCol[esi]
    imul eax, 2
    add eax, 10
    mov dl, al
    
    call Gotoxy
    
    mov eax, brown + (green * 16)           ;DRAWING TREE
    call SetTextColor
    mov al, 'T'
    call WriteChar
    mov al, 'r'
    call WriteChar
    
NextObs:
    inc esi
    jmp DrawObsLoop
    
EndDrawObs:
    mov eax, lightGray + (black * 16)      ;RESET COLOR
    call SetTextColor
    
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DrawObstacles ENDP

DrawBonusItems PROC
    push eax
    push ebx
    push edx
    push esi
    
    mov esi, 0
    
DrawBonusLoop:
    cmp esi, MAX_BONUS
    jge EndDrawBonus
    
    movzx eax, bonusActive[esi]      ;CHECKING 
    cmp eax, 0
    je NextBonus
    
    movzx eax, bonusRow[esi]         ;SCREEN POSITION
    add eax, 5
    mov dh, al
    
    movzx eax, bonusCol[esi]
    imul eax, 2
    add eax, 10
    mov dl, al
    
    call Gotoxy

    mov eax, black + (yellow * 16)
    call SetTextColor
    mov al, '$'           
    call WriteChar
    call WriteChar
    
NextBonus:
    inc esi
    jmp DrawBonusLoop
    
EndDrawBonus:
    mov eax, lightGray + (black * 16)        ;RESET COLOR
    call SetTextColor
    
    pop esi
    pop edx
    pop ebx
    pop eax
    ret
DrawBonusItems ENDP

DrawNPCCars PROC
    push eax
    push ebx
    push edx
    push esi
    
    mov esi, 0
    
DrawNPCLoop:
    movzx eax, currentMaxNPCCars
    cmp esi, eax
    jge EndDrawNPC
    
    movzx eax, npcCarActive[esi]
    cmp eax, 0
    je NextNPC
    
    movzx eax, npcCarRow[esi]         ;NPC CAR POSITION
    add eax, 5
    mov dh, al
    
    movzx eax, npcCarCol[esi]
    imul eax, 2
    add eax, 10
    mov dl, al
    
    call Gotoxy
    
    movzx eax, npcCarColor[esi]
    imul eax, 16
    add eax, black
    call SetTextColor
    
    mov al, 'C'
    call WriteChar
    call WriteChar

NextNPC:
    inc esi
    jmp DrawNPCLoop

EndDrawNPC:
    mov eax, lightGray + (black * 16)           ;RESET COLOR
    call SetTextColor
    
    pop esi
    pop edx
    pop ebx
    pop eax
    ret
DrawNPCCars ENDP

MoveNPCCars PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov esi, 0
    
MoveNPCLoop:
    movzx eax, currentMaxNPCCars
    cmp esi, eax
    jge EndMoveNPC
    
    movzx eax, npcCarActive[esi]            ;CHECKING NPC CAR IS ACTIVE
    cmp eax, 0
    je NextNPCMove
    
    movzx eax, npcCarDirection[esi]          ;DRXN
    cmp eax, 0
    je MoveNPCUp
    cmp eax, 1
    je MoveNPCDown
    cmp eax, 2
    je MoveNPCLeft
    cmp eax, 3
    je MoveNPCRight
    jmp NextNPCMove

MoveNPCUp:
    movzx ebx, npcCarRow[esi]
    cmp ebx, 0
    jle ReverseToDown
    dec ebx
    movzx ecx, npcCarCol[esi]
    push esi
    call CheckNPCValidMove
    pop esi
    cmp eax, 1
    jne ReverseToDown
    dec npcCarRow[esi]
    
    push esi                           ;CHECKING COLLISION
    call CheckIfNPCHitTaxi
    pop esi
    jmp NextNPCMove

ReverseToDown:
    mov npcCarDirection[esi], 1
    jmp NextNPCMove

MoveNPCDown:
    movzx ebx, npcCarRow[esi]
    cmp ebx, GRID_SIZE - 1
    jge ReverseToUp
    inc ebx
    movzx ecx, npcCarCol[esi]
    push esi
    call CheckNPCValidMove
    pop esi
    cmp eax, 1
    jne ReverseToUp
    inc npcCarRow[esi]
    
    push esi                               ;CHECKING COLLISION
    call CheckIfNPCHitTaxi
    pop esi
    jmp NextNPCMove

ReverseToUp:
    mov npcCarDirection[esi], 0
    jmp NextNPCMove

MoveNPCLeft:
    movzx ecx, npcCarCol[esi]
    cmp ecx, 0
    jle ReverseToRight
    dec ecx
    movzx ebx, npcCarRow[esi]
    push esi
    call CheckNPCValidMove
    pop esi
    cmp eax, 1
    jne ReverseToRight
    dec npcCarCol[esi]
    
    push esi                    ;CHECKING COLLISION
    call CheckIfNPCHitTaxi
    pop esi
    jmp NextNPCMove

ReverseToRight:
    mov npcCarDirection[esi], 3
    jmp NextNPCMove

MoveNPCRight:
    movzx ecx, npcCarCol[esi]
    cmp ecx, GRID_SIZE - 1
    jge ReverseToLeft
    inc ecx
    movzx ebx, npcCarRow[esi]
    push esi
    call CheckNPCValidMove
    pop esi
    cmp eax, 1
    jne ReverseToLeft
    inc npcCarCol[esi]
    
    push esi                 ;CHECKING COLLISION
    call CheckIfNPCHitTaxi
    pop esi
    jmp NextNPCMove

ReverseToLeft:
    mov npcCarDirection[esi], 2

NextNPCMove:
    inc esi
    jmp MoveNPCLoop

EndMoveNPC:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
MoveNPCCars ENDP

;INPUT: esi = CURR NPC CAR IND
CheckIfNPCHitTaxi PROC
    push eax
    push ebx
    push ecx
    push edx
    
    movzx eax, npcCarRow[esi]   ;NPC POSITION
    movzx ebx, npcCarCol[esi]
    
    movzx ecx, taxiRow        ;TEAXI POSITION
    movzx edx, taxiCol
    
    cmp eax, ecx       ;CHECKING FOR SAME POSITION
    jne NoHit
    cmp ebx, edx
    jne NoHit
    
    ;HIT DETECTED!!!!!!!
    push edx
    mov edx, OFFSET soundCrashCar
    call PlaySoundEffect
    pop edx
    
    movzx eax, taxiColor
    cmp eax, 14                ;YELLOW TAXI
    je YellowCarPenalty
    
    sub score, 3            ;RED TAXI
    
    mov showCollision, 1
    mov collisionTimer, 12
    
    ;COPY "Hit Car -3!" TO collisionType
    mov al, 'H'
    mov collisionType[0], al
    mov al, 'i'
    mov collisionType[1], al
    mov al, 't'
    mov collisionType[2], al
    mov al, ' '
    mov collisionType[3], al
    mov al, 'C'
    mov collisionType[4], al
    mov al, 'a'
    mov collisionType[5], al
    mov al, 'r'
    mov collisionType[6], al
    mov al, ' '
    mov collisionType[7], al
    mov al, '-'
    mov collisionType[8], al
    mov al, '3'
    mov collisionType[9], al
    mov al, '!'
    mov collisionType[10], al
    mov al, 0
    mov collisionType[11], al
    
    jmp NoHit
    
YellowCarPenalty:
    sub score, 2
   
    mov showCollision, 1
    mov collisionTimer, 12
    
    ;COPY "Hit Car -2!" TO collisionType
    mov al, 'H'
    mov collisionType[0], al
    mov al, 'i'
    mov collisionType[1], al
    mov al, 't'
    mov collisionType[2], al
    mov al, ' '
    mov collisionType[3], al
    mov al, 'C'
    mov collisionType[4], al
    mov al, 'a'
    mov collisionType[5], al
    mov al, 'r'
    mov collisionType[6], al
    mov al, ' '
    mov collisionType[7], al
    mov al, '-'
    mov collisionType[8], al
    mov al, '2'
    mov collisionType[9], al
    mov al, '!'
    mov collisionType[10], al
    mov al, 0
    mov collisionType[11], al

NoHit:
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
CheckIfNPCHitTaxi ENDP

;INPUT: ebx = r, ecx = c
;OUTPUT: eax = 1 IF VALID, 0 IF INVALID
CheckNPCValidMove PROC
    push ebx
    push ecx
    push esi
    push edi
    
    movzx eax, taxiRow
    cmp al, bl
    jne NotTaxiPosition
    movzx eax, taxiCol
    cmp al, cl
    je NPCInvalidMove          ;IF TAXI, THEN BLOCK MOVEMENT
    
NotTaxiPosition:
    mov eax, ebx                ;CHECKING BUILDING
    imul eax, GRID_SIZE
    add eax, ecx
    movzx eax, BYTE PTR [grid + eax]
    cmp eax, 1
    je NPCInvalidMove
    
    mov esi, 0           ;CHECKING TREES
NPCCheckObsLoop:
    cmp esi, MAX_OBSTACLES
    jge NPCCheckPassengers
    
    movzx eax, obstacleActive[esi]
    cmp eax, 0
    je NPCNextObs
    
    movzx eax, obstacleRow[esi]
    cmp eax, ebx
    jne NPCNextObs
    movzx eax, obstacleCol[esi]
    cmp eax, ecx
    je NPCInvalidMove
    
NPCNextObs:
    inc esi
    jmp NPCCheckObsLoop
    
NPCCheckPassengers:
    mov esi, 0
NPCCheckPassLoop:
    cmp esi, MAX_PASSENGERS
    jge NPCCheckOtherCars
    
    movzx eax, passengerActive[esi]
    cmp eax, 0
    je NPCNextPass
    
    movzx eax, passengerRow[esi]
    cmp eax, ebx
    jne NPCNextPass
    movzx eax, passengerCol[esi]
    cmp eax, ecx
    je NPCInvalidMove
    
NPCNextPass:
    inc esi
    jmp NPCCheckPassLoop
    
NPCCheckOtherCars:
    mov edi, 0

NPCCheckCarLoop:
    cmp edi, MAX_NPC_CARS
    jge NPCValidMove
    
    movzx eax, npcCarActive[edi]
    cmp eax, 0
    je NPCNextCar
    
    movzx eax, npcCarRow[edi]
    cmp eax, ebx
    jne NPCNextCar
    movzx eax, npcCarCol[edi]
    cmp eax, ecx
    je NPCInvalidMove
    
NPCNextCar:
    inc edi
    jmp NPCCheckCarLoop
    
NPCValidMove:
    mov eax, 1
    jmp NPCEndCheck
    
NPCInvalidMove:
    mov eax, 0
    
NPCEndCheck:
    pop edi
    pop esi
    pop ecx
    pop ebx
    ret
CheckNPCValidMove ENDP

CheckBonusCollection PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    movzx ebx, taxiRow          ;TAXI POSITION
    movzx ecx, taxiCol
    
    mov esi, 0
CheckBonusLoop:
    cmp esi, MAX_BONUS
    jge NoBonusCollected
    
    movzx eax, bonusActive[esi]      ;CHECKING IF BONUS IS ACTIVE
    cmp eax, 0
    je NextBonus
    
    movzx eax, bonusRow[esi]          ;CHECKING IF TAXI IS AT BONUS POSITION
    cmp al, bl
    jne NextBonus
    
    movzx eax, bonusCol[esi]
    cmp al, cl
    jne NextBonus
    
    ;BONUS COLLECTED!!!!!!!!!!!!
    push edx
    mov edx, OFFSET soundBonus
    call PlaySoundEffect
    pop edx
    
    mov bonusActive[esi], 0          ;BONUS ITEM->EATED
    
    add score, 10
    
    mov showCollision, 1
    mov collisionTimer, 12
    
    ;COPY "Bonus +10!" TO collisionType
    mov al, 'B'
    mov collisionType[0], al
    mov al, 'o'
    mov collisionType[1], al
    mov al, 'n'
    mov collisionType[2], al
    mov al, 'u'
    mov collisionType[3], al
    mov al, 's'
    mov collisionType[4], al
    mov al, ' '
    mov collisionType[5], al
    mov al, '+'
    mov collisionType[6], al
    mov al, '1'
    mov collisionType[7], al
    mov al, '0'
    mov collisionType[8], al
    mov al, '!'
    mov collisionType[9], al
    mov al, 0
    mov collisionType[10], al
    
    jmp NoBonusCollected

NextBonus:
    inc esi
    jmp CheckBonusLoop

NoBonusCollected:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
CheckBonusCollection ENDP

GetInput PROC
    push eax
    push ebx
    push ecx
    push edx             
    
    mov eax, 80
    call Delay
    
    call ReadKey
    jz NoInput
    
    cmp al, ' '          ;SPACEBAR FOR PICKUP
    je HandleSpace

    cmp al, 0              ;ARROX KEYS RETURN 0 IN AL
    jne CheckWASD           
    
    cmp ah, 48h           ;UP
    je MoveUp
    cmp ah, 50h           ;DOWN
    je MoveDown
    cmp ah, 4Bh           ;LEFT
    je MoveLeft
    cmp ah, 4Dh           ;RIGHT
    je MoveRight
    jmp NoInput

CheckWASD:
    cmp al, 'w'
    je MoveUp
    cmp al, 'W'
    je MoveUp
    
    cmp al, 's'
    je MoveDown
    cmp al, 'S'
    je MoveDown
    
    cmp al, 'a'
    je MoveLeft
    cmp al, 'A'
    je MoveLeft
    
    cmp al, 'd'
    je MoveRight
    cmp al, 'D'
    je MoveRight
    
    ;p for pause
    cmp al, 'p'
    je PauseGame
    cmp al, 'P'
    je PauseGame
    
    jmp NoInput
    
HandleSpace:
    movzx eax, hasPassenger
    cmp eax, 1
    je DropOff
    call TryPickup
    jmp NoInput
    
DropOff:
    call TryDropoff
    jmp NoInput

MoveUp:
    movzx ebx, taxiRow
    cmp ebx, 0
    je NoInput
    dec ebx
    movzx ecx, taxiCol
    call CheckValidMove
    cmp eax, 1
    jne NoInput
    dec taxiRow
    call CheckBonusCollection
    ;call CheckNPCCarCollision
    jmp NoInput
    
MoveDown:
    movzx ebx, taxiRow
    cmp ebx, GRID_SIZE - 1
    je NoInput
    inc ebx
    movzx ecx, taxiCol
    call CheckValidMove
    cmp eax, 1
    jne NoInput
    inc taxiRow
    call CheckBonusCollection
    ;call CheckNPCCarCollision
    jmp NoInput
    
MoveLeft:
    movzx ecx, taxiCol
    cmp ecx, 0
    je NoInput
    dec ecx
    movzx ebx, taxiRow
    call CheckValidMove
    cmp eax, 1
    jne NoInput
    dec taxiCol 
    call CheckBonusCollection
    ;call CheckNPCCarCollision
    jmp NoInput
    
MoveRight:
    movzx ecx, taxiCol
    cmp ecx, GRID_SIZE - 1
    je NoInput
    inc ecx
    movzx ebx, taxiRow
    call CheckValidMove
    cmp eax, 1
    jne NoInput
    inc taxiCol   
    call CheckBonusCollection
    jmp NoInput
    
ExitGame:
    mov gameRunning, 0

PauseGame:
    push edx
    mov edx, OFFSET soundPause
    call PlaySoundEffect
    pop edx
    
    mov gamePaused, 1
    call ShowPauseMenu
    mov gamePaused, 1
    call ShowPauseMenu
    
    movzx eax, pauseChoice      ;PAUSE CHOICES
    cmp eax, 1
    je ResumeGame
    cmp eax, 2
    je SaveAndQuit
    cmp eax, 3
    je RestartFromPause
    cmp eax, 4
    je BackToMainMenu

ResumeGame:
    mov gamePaused, 0
    jmp NoInput

SaveAndQuit:
    mov gamePaused, 0
    mov gameRunning, 0
    mov inMainMenu, 1               
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

RestartFromPause:
    mov gamePaused, 0
    call GetMseconds                    ;RESETTING GAME STATE
    mov seed, eax
    
    mov eax, currentStartScore        ;RESETTING SCORE ON THE BASIS OF DIFFICULTY
    mov score, eax
    
    mov dropCounter, 0                 ;RESETTING DROPCOUNT AND AND SPEED
    mov speedLevel, 1
    mov showCollision, 0
    mov collisionTimer, 0
    mov activePassengerCount, 0
    
    mov taxiRow, 0               ;RESETTING TAXI POS
    mov taxiCol, 0
    
    mov gameRunning, 1           ;RESETTING GAME STATE
    mov hasPassenger, 0
    mov currentPassenger, 0
    
    movzx eax, gameMode           ;RESETTING TIMER
    cmp eax, 2
    jne SkipTimeResetPause
    mov timeRemaining, 60
    call GetMseconds
    mov startTime, eax
SkipTimeResetPause:
    push esi          ;CLEARING ALL ARRAYS
    mov ecx, MAX_PASSENGERS
    mov esi, 0
ClearPassFromPause:
    mov passengerActive[esi], 0
    mov passengerRow[esi], 0
    mov passengerCol[esi], 0
    mov destRow[esi], 0
    mov destCol[esi], 0
    inc esi
    loop ClearPassFromPause
    
    mov ecx, MAX_OBSTACLES
    mov esi, 0

ClearObsFromPause:
    mov obstacleActive[esi], 0
    mov obstacleRow[esi], 0
    mov obstacleCol[esi], 0
    mov obstacleType[esi], 0
    inc esi
    loop ClearObsFromPause
    
    mov ecx, MAX_BONUS
    mov esi, 0

ClearBonusFromPause:
    mov bonusActive[esi], 0
    mov bonusRow[esi], 0
    mov bonusCol[esi], 0
    inc esi
    loop ClearBonusFromPause
    
    movzx ecx, currentMaxNPCCars
    mov esi, 0

ClearNPCFromPause:
    mov npcCarActive[esi], 0
    mov npcCarRow[esi], 0
    mov npcCarCol[esi], 0
    inc esi
    loop ClearNPCFromPause
    
    mov moveCounter, 0
    mov ecx, GRID_SIZE * GRID_SIZE
    mov esi, 0

ClearGridFromPause:
    mov grid[esi], 0
    inc esi
    loop ClearGridFromPause
    pop esi
    
    call InitializeGrid            ;REINITIALIZING EVERYTHING
    call InitializePassengers
    call InitializeObstacles
    call InitializeBonusItems
    call InitializeNPCCars
    
    jmp NoInput

BackToMainMenu:
    mov gamePaused, 0
    mov gameRunning, 0
    mov inMainMenu, 1           
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
    
NoInput:
    pop edx                 
    pop ecx
    pop ebx
    pop eax
    ret
GetInput ENDP

;IN: ebx = r, ecx = c
;OUT: eax = 1 IF VALID, 0 IF INVALID
CheckValidMove PROC
    push ebx
    push ecx
    push edx
    push esi
    
    ;CHECKING BOUNDARIES
    cmp ebx, 0
    jl InvalidMove
    cmp ebx, GRID_SIZE
    jge InvalidMove
    cmp ecx, 0
    jl InvalidMove
    cmp ecx, GRID_SIZE
    jge InvalidMove
    
    ;CHECKS FOR BUILDING
    mov eax, ebx
    imul eax, GRID_SIZE
    add eax, ecx
    movzx eax, BYTE PTR grid[eax]
    cmp eax, 1
    cmp eax, 1
    jne NotBuilding   
    
    ;HIT BUILDING!!!!!!!!!!!!!!!!
    push edx
    mov edx, OFFSET soundCrashObstacle
    call PlaySoundEffect
    pop edx
    
    movzx eax, taxiColor
    cmp eax, 14                 ;YELLOW TAXI
    je YellowBuildingPenalty
    
    sub score, 2             ;RED TAXI
    
    mov showCollision, 1
    mov collisionTimer, 12
    
    ; COPY "Hit Building -2!" TO collisionType
    mov al, 'H'
    mov collisionType[0], al
    mov al, 'i'
    mov collisionType[1], al
    mov al, 't'
    mov collisionType[2], al
    mov al, ' '
    mov collisionType[3], al
    mov al, 'B'
    mov collisionType[4], al
    mov al, 'u'
    mov collisionType[5], al
    mov al, 'i'
    mov collisionType[6], al
    mov al, 'l'
    mov collisionType[7], al
    mov al, 'd'
    mov collisionType[8], al
    mov al, 'i'
    mov collisionType[9], al
    mov al, 'n'
    mov collisionType[10], al
    mov al, 'g'
    mov collisionType[11], al
    mov al, ' '
    mov collisionType[12], al
    mov al, '-'
    mov collisionType[13], al
    mov al, '2'
    mov collisionType[14], al
    mov al, '!'
    mov collisionType[15], al
    mov al, 0
    mov collisionType[16], al
    
    jmp InvalidMove
    
YellowBuildingPenalty:
    sub score, 4
    
    mov showCollision, 1
    mov collisionTimer, 12
    
    ; COPY "Hit Building -4!" TO collisionType
    mov al, 'H'
    mov collisionType[0], al
    mov al, 'i'
    mov collisionType[1], al
    mov al, 't'
    mov collisionType[2], al
    mov al, ' '
    mov collisionType[3], al
    mov al, 'B'
    mov collisionType[4], al
    mov al, 'u'
    mov collisionType[5], al
    mov al, 'i'
    mov collisionType[6], al
    mov al, 'l'
    mov collisionType[7], al
    mov al, 'd'
    mov collisionType[8], al
    mov al, 'i'
    mov collisionType[9], al
    mov al, 'n'
    mov collisionType[10], al
    mov al, 'g'
    mov collisionType[11], al
    mov al, ' '
    mov collisionType[12], al
    mov al, '-'
    mov collisionType[13], al
    mov al, '4'
    mov collisionType[14], al
    mov al, '!'
    mov collisionType[15], al
    mov al, 0
    mov collisionType[16], al
    
    jmp InvalidMove

NotBuilding:
    mov esi, 0

CheckObstacleLoop:
    cmp esi, MAX_OBSTACLES
    jge CheckPassengersCollision
    
    movzx eax, obstacleActive[esi]
    cmp eax, 0
    je NextObstacle
    
    movzx eax, obstacleRow[esi]
    cmp al, bl
    jne NextObstacle
    
    movzx eax, obstacleCol[esi]
    cmp al, cl
    jne NextObstacle
    
    ;HIT OBSTACLE!!!!!!!!!!!!
    push edx
    mov edx, OFFSET soundCrashObstacle
    call PlaySoundEffect
    pop edx
    
    movzx eax, taxiColor
    cmp eax, 14                   ;YELLOW TAXI
    je YellowObstaclePenalty
    
    sub score, 2          ;RED TAXI

    mov showCollision, 1
    mov collisionTimer, 12
    
    ; COPY "Hit Obstacle -2!" TO collisionType
    mov al, 'H'
    mov collisionType[0], al
    mov al, 'i'
    mov collisionType[1], al
    mov al, 't'
    mov collisionType[2], al
    mov al, ' '
    mov collisionType[3], al
    mov al, 'O'
    mov collisionType[4], al
    mov al, 'b'
    mov collisionType[5], al
    mov al, 's'
    mov collisionType[6], al
    mov al, 't'
    mov collisionType[7], al
    mov al, 'a'
    mov collisionType[8], al
    mov al, 'c'
    mov collisionType[9], al
    mov al, 'l'
    mov collisionType[10], al
    mov al, 'e'
    mov collisionType[11], al
    mov al, ' '
    mov collisionType[12], al
    mov al, '-'
    mov collisionType[13], al
    mov al, '2'
    mov collisionType[14], al
    mov al, '!'
    mov collisionType[15], al
    mov al, 0
    mov collisionType[16], al
    
    jmp InvalidMove
    
YellowObstaclePenalty:
    sub score, 4
    
    mov showCollision, 1
    mov collisionTimer, 12
    
    ; COPY "Hit Obstacle -4!" TO collisionType
    mov al, 'H'
    mov collisionType[0], al
    mov al, 'i'
    mov collisionType[1], al
    mov al, 't'
    mov collisionType[2], al
    mov al, ' '
    mov collisionType[3], al
    mov al, 'O'
    mov collisionType[4], al
    mov al, 'b'
    mov collisionType[5], al
    mov al, 's'
    mov collisionType[6], al
    mov al, 't'
    mov collisionType[7], al
    mov al, 'a'
    mov collisionType[8], al
    mov al, 'c'
    mov collisionType[9], al
    mov al, 'l'
    mov collisionType[10], al
    mov al, 'e'
    mov collisionType[11], al
    mov al, ' '
    mov collisionType[12], al
    mov al, '-'
    mov collisionType[13], al
    mov al, '4'
    mov collisionType[14], al
    mov al, '!'
    mov collisionType[15], al
    mov al, 0
    mov collisionType[16], al
    
    jmp InvalidMove

NextObstacle:
    inc esi
    jmp CheckObstacleLoop

CheckPassengersCollision:
    mov esi, 0
CheckPassengerLoop:
    cmp esi, MAXPASSENGERS
    jge ValidMove
    
    movzx eax, passengerActive[esi]
    cmp eax, 0
    je NextPassenger
    
    movzx eax, passengerRow[esi]
    cmp al, bl
    jne NextPassenger
    
    movzx eax, passengerCol[esi]
    cmp al, cl
    jne NextPassenger
    
    ;PASSENEGER GOT HIT !!!!!!!!!!!!!!!!!
    push edx
    mov edx, OFFSET soundCrashPassenger
    call PlaySoundEffect
    pop edx
    
    mov passengerActive[esi], 0        ;PASSENGER->BOOM!!!!!!!!!1
    
    sub score, 5
    
    mov showCollision, 1
    mov collisionTimer, 12
    
    ; COPYING "Hit Passenger -5!" TO collisionType
    mov al, 'H'
    mov collisionType[0], al
    mov al, 'i'
    mov collisionType[1], al
    mov al, 't'
    mov collisionType[2], al
    mov al, ' '
    mov collisionType[3], al
    mov al, 'P'
    mov collisionType[4], al
    mov al, 'a'
    mov collisionType[5], al
    mov al, 's'
    mov collisionType[6], al
    mov al, 's'
    mov collisionType[7], al
    mov al, 'e'
    mov collisionType[8], al
    mov al, 'n'
    mov collisionType[9], al
    mov al, 'g'
    mov collisionType[10], al
    mov al, 'e'
    mov collisionType[11], al
    mov al, 'r'
    mov collisionType[12], al
    mov al, ' '
    mov collisionType[13], al
    mov al, '-'
    mov collisionType[14], al
    mov al, '5'
    mov collisionType[15], al
    mov al, '!'
    mov collisionType[16], al
    mov al, 0
    mov collisionType[17], al
    
    jmp ValidMove

NextPassenger:
    inc esi
    jmp CheckPassengerLoop

ValidMove:
    mov eax, 1
    jmp EndCheck

InvalidMove:
    mov eax, 0

EndCheck:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
CheckValidMove ENDP

CheckNPCCarCollision PROC
    push eax
    push ebx
    push esi
    
    mov esi, 0
    
CheckNPCCollisionLoop:
    cmp esi, MAX_NPC_CARS
    jge NoNPCCollision
    
    ; Check if NPC car is active
    movzx eax, npcCarActive[esi]
    cmp eax, 0
    je NextNPCCollisionCheck
    
    movzx eax, taxiRow               ;CHECKING IF TAXI IS AT NPC POSITION
    movzx ebx, npcCarRow[esi]
    cmp eax, ebx
    jne NextNPCCollisionCheck
    
    movzx eax, taxiCol
    movzx ebx, npcCarCol[esi]
    cmp eax, ebx
    jne NextNPCCollisionCheck
  
    movzx eax, taxiColor        ;C0LLISION->SCORE DEDUCTION ON COLOR BASIS
    cmp eax, 4                  ;RED TAXI
    je RedHitsNPCCar
    
    sub score, 2
    jmp NoNPCCollision
    
RedHitsNPCCar:
    sub score, 3
    jmp NoNPCCollision
    
NextNPCCollisionCheck:
    inc esi
    jmp CheckNPCCollisionLoop
    
NoNPCCollision:
    pop esi
    pop ebx
    pop eax
    ret
CheckNPCCarCollision ENDP

ShowPauseMenu PROC
    push eax
    push edx
    
    call Clrscr
    
    mov dh, 8
    mov dl, 18
    call Gotoxy
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov edx, OFFSET pauseTitle
    call WriteString
    call Crlf
    call Crlf
    
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    
    mov dh, 11
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET pauseOption1
    call WriteString
    
    mov dh, 12
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET pauseOption2
    call WriteString
    
    mov dh, 13
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET pauseOption3
    call WriteString
    
    mov dh, 14
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET pauseOption4
    call WriteString
    
    mov dh, 17
    mov dl, 23
    call Gotoxy
    mov eax, white + (black * 16)
    call SetTextColor
    mov edx, OFFSET pausePrompt
    call WriteString
    
    call GetPauseChoice
    
    pop edx
    pop eax
    ret
ShowPauseMenu ENDP

GetPauseChoice PROC
    push eax
    
GetPChoice:
    call ReadChar
    cmp al, '1'
    jl GetPChoice
    cmp al, '4'
    jg GetPChoice
    
    sub al, '0'         ;STORING CHOICE
    mov pauseChoice, al
    
    pop eax
    ret
GetPauseChoice ENDP

UpdatePassengerCount PROC
    push eax
    push esi
    
    mov esi, 0
    mov al, 0          
    
CountLoop:
    cmp esi, MAX_PASSENGERS
    jge DoneCounting
    
    movzx eax, passengerActive[esi]
    cmp eax, 1
    jne SkipCount
    
    inc al
    
SkipCount:
    inc esi
    jmp CountLoop
    
DoneCounting:
    mov activePassengerCount, al
    
    cmp al, minPassengers           ;IF PASSEN LESS THAN MIN THEN GENERATING MORE
    jge EnoughPassengers
    
SpawnMoreLoop:
    movzx eax, activePassengerCount
    cmp al, minPassengers
    jge EnoughPassengers
    
    call SpawnNewPassenger
    inc activePassengerCount
    jmp SpawnMoreLoop
    
EnoughPassengers:
    pop esi
    pop eax
    ret
UpdatePassengerCount ENDP

EnsureMinimumPassengers PROC
    push eax
    
    call UpdatePassengerCount
    
    movzx eax, activePassengerCount            ;COUNTING CUR ACTIVE PASSEN
    cmp al, minPassengers
    jge HasEnough
    
    call SpawnNewPassenger    ;NEED TO GENERATE MORE
    
HasEnough:
    pop eax
    ret
EnsureMinimumPassengers ENDP

DisplayDifficultyMenu PROC
    push eax
    push edx
    
    call Clrscr
    
    mov dh, 8
    mov dl, 20
    call Gotoxy
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov edx, OFFSET diffTitle
    call WriteString
    call Crlf
    call Crlf
    
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    
    mov dh, 11
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET diff1
    call WriteString
    
    mov dh, 12
    mov dl, 20
    call Gotoxy
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov edx, OFFSET diff2
    call WriteString
    
    mov dh, 13
    mov dl, 20
    call Gotoxy
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mov edx, OFFSET diff3
    call WriteString
    
    mov dh, 16
    mov dl, 22
    call Gotoxy
    mov eax, white + (black * 16)
    call SetTextColor
    mov edx, OFFSET diffPrompt
    call WriteString
    
    pop edx
    pop eax
    ret
DisplayDifficultyMenu ENDP

GetDifficultyChoice PROC
    push eax
    
GetDiffChoice:
    call ReadChar
    
    cmp al, '1'
    jl GetDiffChoice
    cmp al, '3'
    jg GetDiffChoice
    
    sub al, '0'                ;STORING CHOICE
    mov difficultyLevel, al
    
    pop eax
    ret
GetDifficultyChoice ENDP

ApplyDifficulty PROC
    push eax
    
    movzx eax, difficultyLevel
    
    cmp eax, 1
    je SetEasy
    cmp eax, 2
    je SetMedium
    cmp eax, 3
    je SetHard
    
    jmp SetMedium        ;DEFAULT

SetEasy:
    ;EASY
    mov currentMaxObstacles, 4
    mov currentMaxNPCCars, 6    
    mov currentStartScore, 20
    mov score, 20
    jmp DoneApply

SetMedium:
    ;MEDIUM
    mov currentMaxObstacles, 8
    mov currentMaxNPCCars, 8    
    mov currentStartScore, 10
    mov score, 10
    jmp DoneApply

SetHard:
    ;HARD MODE
    mov currentMaxObstacles, 12
    mov currentMaxNPCCars, 10     
    mov currentStartScore, 5
    mov score, 5

DoneApply:
    pop eax
    ret
ApplyDifficulty ENDP

CheckNPCHitsTaxi PROC
    push eax
    push esi
    
    mov esi, 0
CheckAllNPCs:
    movzx eax, currentMaxNPCCars
    cmp esi, eax
    jge DoneCheckingNPCs
    
    movzx eax, npcCarActive[esi]      ;CHECKING WETHER THE NPC IS ACTIVE OR NOT
    cmp eax, 0
    je NextNPCCheck
    
    push esi                    ;CHECKING COLLISION FOR THE NPC
    call CheckIfNPCHitTaxi
    pop esi

NextNPCCheck:
    inc esi
    jmp CheckAllNPCs

DoneCheckingNPCs:
    pop esi
    pop eax
    ret
CheckNPCHitsTaxi ENDP

DisplayGameModeMenu PROC
    push eax
    push edx
    
    call Clrscr
    
    mov dh, 8
    mov dl, 20
    call Gotoxy
    mov eax, yellow + (black * 16)
    call SetTextColor
    mov edx, OFFSET modeTitle
    call WriteString
    call Crlf
    call Crlf
    
    ;CAREER MODE
    mov dh, 11
    mov dl, 18
    call Gotoxy
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    mov edx, OFFSET mode1
    call WriteString
    
    ;TIME MODE
    mov dh, 12
    mov dl, 18
    call Gotoxy
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mov edx, OFFSET mode2
    call WriteString
    
    ;ENDLESS MODE
    mov dh, 13
    mov dl, 18
    call Gotoxy
    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    mov edx, OFFSET mode3
    call WriteString
    
    mov dh, 16
    mov dl, 25
    call Gotoxy
    mov eax, white + (black * 16)
    call SetTextColor
    mov edx, OFFSET modePrompt
    call WriteString
    
    pop edx
    pop eax
    ret
DisplayGameModeMenu ENDP

GetGameModeChoice PROC
    push eax
    push ebx
    
GetModeChoice:
    call ReadChar
    
    cmp al, '1'
    jl GetModeChoice
    cmp al, '3'
    jg GetModeChoice

    sub al, '0'            ;storing choice
    mov gameMode, al
    
    cmp al, 1
    je InitCareerMode
    cmp al, 2
    je InitTimeMode
    jmp InitEndlessMode
    
InitCareerMode:
    mov dropCounter, 0
    jmp DoneInit
    
InitTimeMode:
    mov timeRemaining, 60         ; 1 min time mode
    call GetMseconds
    mov startTime, eax
    jmp DoneInit
    
InitEndlessMode:
    mov dropCounter, 0
    
DoneInit:
    pop ebx
    pop eax
    ret
GetGameModeChoice ENDP

PlaySoundEffect PROC
    push eax
    push edx
   
    mov eax, SND_FILENAME               ; PlaySound(filename, NULL, SND_FILENAME | SND_ASYNC)
    or eax, SND_ASYNC
    
    INVOKE PlaySound, edx, 0, eax
    
    pop edx
    pop eax
    ret
PlaySoundEffect ENDP

StartBackgroundMusic PROC
    push eax
    push edx
  
    INVOKE mciSendStringA, OFFSET bgMusicStart, 0, 0, 0          ;open file
    INVOKE mciSendStringA, OFFSET bgMusicCommand, 0, 0, 0        ;play on repeat
    
    pop edx
    pop eax
    ret
StartBackgroundMusic ENDP

StopBackgroundMusic PROC
    push eax
    push edx
    INVOKE mciSendStringA, OFFSET bgMusicStop, 0, 0, 0
    
    pop edx
    pop eax
    ret
StopBackgroundMusic ENDP

END main