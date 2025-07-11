# AutoHotkey Roblox Message Sender
This AutoHotkey (AHK) script automates sending pre-defined messages in Roblox, perfect for instructors, role-players, or anyone needing to deliver sequential chat messages efficiently. It uses a reliable copy/paste method and includes intuitive hotkey controls to start, pause, resume, or even resend the last message, ensuring smooth operation within your Roblox sessions.

# Features
- Automated Message Sending: Sends messages in sequence, either individually or in pairs.
- Copy/Paste Method: Uses the clipboard for sending messages, ensuring compatibility with most in-game chat systems.
- Configurable Messages: Easily edit and add your own messages directly within the script.
- Hotkeys for Control:
  - Numpad1: START / EXIT the script.
  - Numpad2: PAUSE / RESUME message sending.
  - Numpad3: PAUSE / RESEND the last message(s) and then RESUME.
      - Useful when your message is filtered (tagged) so you have to resend your last message.
- Roblox Window Detection: Only sends messages when the Roblox window is active.
- Clipboard Preservation: Saves and restores your clipboard content before and after sending messages.

# Hotkeys
- Numpad1:
  - Press once to START the message sequence.
  - Press again to EXIT the script.
- Numpad2:
  - Press to PAUSE message sending.
  - Press again to RESUME from where it left off.
- Numpad3:
  - If the script is running, this will PAUSE it.
  - If the script is paused, this will RESEND the last message (or pair of messages) that was sent, and then RESUME the sequence.

# How to Use
**Prerequisites**:
- **Download AutoHotkey**: If you don't have it, download and install AutoHotkey v3.3 or later from autohotkey.com.

# Setup
**Save the Script**:
- Create a new text file and paste the entire provided AHK script code into it.
- Save the file with an .ahk extension (e.g., RobloxMessageSender.ahk).

**Edit Your Messages**:
- Open the .ahk file with a text editor (like Notepad).
- Go to the === EDIT YOUR MESSAGES HERE === section.
- Modify the Messages object to include your desired text.
- Each message requires a text property and a type property:
  - Messages[X].text := "Your message here"
  - Messages[X].type := "pair" (for messages that should be immediately followed by the next message in the list, like a two-part sentence)
  - Messages[X].type := "" (for single messages that wait for user input or a delay)
- **Important**: If a message is type := "pair", the next message in the sequence (e.g., Messages[currentIndex + 1]) will be sent immediately after it. Make sure your "paired" messages are always followed by the content you want to send as the second part of the pair.

**Run the Script**:
- Double-click the .ahk file to run it. A green "H" icon will appear in your system tray, showing it's active.

**In-Game Usage**:
- Open Roblox: Make sure the Roblox game window is active.
- Start Sending: Press Numpad1 to begin sending messages.
- Control Flow: Use Numpad2 to pause/resume and Numpad3 to resend the last message(s) and resume, as needed.
- Exit: Press Numpad1 again to exit the script.

# Customization
- Message Content and Type: The most common customization will be adding, removing, or modifying messages in the Messages object. Remember to correctly set the type property for each message.
- Delay Between Messages: The SetTimer, SendMessageRoutine, 15000 line controls the delay between messages (15000 milliseconds = 15 seconds). You can change this value to suit your needs.
- Typing Speed/Delays: Adjust the Sleep values if you experience issues with messages not sending correctly, though the current values are generally reliable:
- Sleep, 200 after Send, / and before Send, ^v allows Roblox to open the chat.
- Sleep, 150 after Send, ^v and before Send, {Enter} gives the game time to register the paste.
- Sleep, 500 is used between sending the first and second part of a "pair" message.
- Target Window: The !WinActive("Roblox") check ensures the script only runs when the Roblox window is active. If you need to use this for a different application, change "Roblox" to the title of the target window.

# License
This project is licensed under MIT License.
