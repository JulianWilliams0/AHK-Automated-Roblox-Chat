; ====================================================================================
; AHK Script (v3.3 - Copy/Paste Method)
;
; --- DESCRIPTION ---
; This version has been updated to copy messages to the clipboard and paste them,
; rather than typing them out. This can be faster and more reliable.
; All other functionality (hotkeys, single/pair messages) remains the same.
;
; --- HOTKEYS ---
; Numpad1: START / EXIT script
; Numpad2: PAUSE / RESUME script
; Numpad3: PAUSE / RESEND last message(s) and RESUME
; ====================================================================================

; --- Initial Configuration ---
#SingleInstance, Force
SendMode, Input
SetWorkingDir, %A_ScriptDir%

; --- Global Variables ---
global isActive := false
global isPaused := false
global currentIndex := 1
global lastActionSize := 0 ; Tracks if the last action was a single (1) or pair (2)
global Messages

; ====================================================================================
; === EDIT YOUR MESSAGES HERE ===
; ====================================================================================
; This section uses a classic, highly compatible syntax.
; - For each message, define its 'text' and 'type' on separate lines.
; - Type can be 'single' or 'pair'.
; - A 'pair' message MUST be followed by another message.

Messages := Object()

Messages[1] := Object()
Messages[1].text := "First Message - Not Pair!"
Messages[1].type := "single"

Messages[2] := Object()
Messages[2].text := "Second Message (A) - Pair."
Messages[2].type := "pair"

Messages[3] := Object()
Messages[3].text := "Second Message (B) - Pair."
Messages[3].type := "" ; Type for the 2nd part of a pair doesn't matter; leave it blank if using pair.
; ====================================================================================

; ====================================================================================
; === HOTKEY DEFINITIONS ===
; ====================================================================================

; --- Numpad1: Start / Exit ---
Numpad1::
    isActive := !isActive
    if (isActive)
    {
        isPaused := false
        currentIndex := 1
        GoSub, SendMessageRoutine
    }
    else
    {
        ExitApp
    }
return

; --- Numpad2: Pause / Resume ---
Numpad2::
    if !isActive
        return

    isPaused := !isPaused
    if (isPaused)
    {
        SetTimer, SendMessageRoutine, Off
    }
    else
    {
        GoSub, SendMessageRoutine
    }
return

; --- Numpad3: Pause / Resend and Resume ---
Numpad3::
    if !isActive
        return

    if (!isPaused)
    {
        isPaused := true
        SetTimer, SendMessageRoutine, Off
    }
    else
    {
        isPaused := false
        ; Rewind the index by the size of the last action (1 for single, 2 for pair)
        if (currentIndex > 1)
        {
            currentIndex -= lastActionSize
        }
        GoSub, SendMessageRoutine
    }
return

; ====================================================================================
; === SCRIPT LOGIC ===
; ====================================================================================

SendMessageRoutine:
    if (isPaused or !isActive or !WinActive("Roblox"))
        return

    if (currentIndex > Messages.MaxIndex())
    {
        SetTimer, SendMessageRoutine, Off
        return
    }

    ; --- Save the current clipboard to restore it later ---
    ClipboardSaved := ClipboardAll

    ; --- Get the current message object ---
    currentMsg := Messages[currentIndex]

    ; --- Send the first message via copy-paste ---
    Clipboard := currentMsg.text
    ClipWait, 1 ; Wait up to 1 sec for clipboard to be ready
    Send, /
    Sleep, 200
    Send, ^v ; Paste
    Sleep, 150
    Send, {Enter}

    ; --- Check if it's a pair and send the second message ---
    if (currentMsg.type = "pair")
    {
        lastActionSize := 2 ; The last action was a pair
        if (currentIndex < Messages.MaxIndex())
        {
            nextMsg := Messages[currentIndex + 1]
            Sleep, 500
            ; --- Send the second message of the pair via copy-paste ---
            Clipboard := nextMsg.text
            ClipWait, 1
            Send, /
            Sleep, 200
            Send, ^v ; Paste
            Sleep, 150
            Send, {Enter}
            currentIndex += 2
        }
        else
        {
            ; It was the last message, so just advance by 1
            currentIndex += 1
        }
    }
    else ; It's a single message
    {
        lastActionSize := 1 ; The last action was a single
        currentIndex += 1
    }

    ; --- Restore the original clipboard content ---
    Clipboard := ClipboardSaved
    
    ; --- Set the timer for the next message(s) ---
    SetTimer, SendMessageRoutine, 15000
return
