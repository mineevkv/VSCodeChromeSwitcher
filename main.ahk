#Requires AutoHotkey v2.0
#SingleInstance Force

; Win+B - switch to Chrome without wrapping
#b::
{
    ; Проверяем, существует ли окно Chrome
    if WinExist("ahk_exe chrome.exe") {
        chromeID := WinExist("ahk_exe chrome.exe")
        
        ; Активируем окно Chrome
        WinActivate chromeID
        
        ; Проверяем состояние окна
        winState := WinGetMinMax(chromeID)
        
        ; -1 = свернуто, 0 = нормальное, 1 = максимизировано
        if winState = -1 {
            ; Если окно свернуто - восстанавливаем
            WinRestore chromeID
            ; Центрируем окно
            CenterWindow(chromeID)
        }
        ; Если окно уже активно и в нормальном состоянии - ничего не делаем
        ; Если окно максимизировано - оставляем как есть
    } else {
        ; Chrome не запущен - запускаем
        try {
            Run "chrome.exe"
        } catch {
            ; Если не сработало через PATH, пробуем стандартные пути
            chromePaths := [
                "C:\Program Files\Google\Chrome\Application\chrome.exe",
                "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
                A_ProgramFiles "\Google\Chrome\Application\chrome.exe"
            ]
            
            for path in chromePaths {
                try {
                    Run path
                    break
                } catch {
                    ; Продолжаем пробовать другие пути
                    continue
                }
            }
        }
    }
}

; Win+V - switch to VS Code without wrapping
#v::
{
    ; Проверяем, существует ли окно VS Code
    if WinExist("ahk_exe Code.exe") {
        vscodeID := WinExist("ahk_exe Code.exe")
        
        ; Активируем окно VS Code
        WinActivate vscodeID
        
        ; Проверяем состояние окна
        winState := WinGetMinMax(vscodeID)
        
        ; -1 = свернуто, 0 = нормальное, 1 = максимизировано
        if winState = -1 {
            ; Если окно свернуто - восстанавливаем
            WinRestore vscodeID
            ; Центрируем окно
            CenterWindow(vscodeID)
        }
        ; Если окно уже активно и в нормальном состоянии - ничего не делаем
        ; Если окно максимизировано - оставляем как есть
    } else {
        ; VS Code не запущен - запускаем
        try {
            Run "code.exe"
        } catch {
            ; Если не сработало через PATH, пробуем стандартные пути
            vscodePaths := [
                "C:\Program Files\Microsoft VS Code\Code.exe",
                "C:\Users\" A_UserName "\AppData\Local\Programs\Microsoft VS Code\Code.exe",
                A_AppData "\..\Local\Programs\Microsoft VS Code\Code.exe",
                A_ProgramFiles "\Microsoft VS Code\Code.exe"
            ]
            
            for path in vscodePaths {
                try {
                    if FileExist(path) {
                        Run path
                        break
                    }
                }
            }
        }
    }
}

; Function to center a window on the screen
CenterWindow(hwnd) {
    WinGetPos &x, &y, &width, &height, hwnd
    
    ; Получаем размеры активного монитора
    activeMon := GetActiveMonitor()
    MonitorGetWorkArea activeMon, &monLeft, &monTop, &monRight, &monBottom
    
    ; Рассчитываем новые координаты для центрирования
    newX := monLeft + ((monRight - monLeft) - width) // 2
    newY := monTop + ((monBottom - monTop) - height) // 2
    
    ; Перемещаем окно
    WinMove newX, newY,,, hwnd
}

; Function to get the active monitor
GetActiveMonitor() {
    ; Используем позицию мыши для определения активного монитора
    CoordMode "Mouse", "Screen"
    MouseGetPos &mouseX, &mouseY
    
    ; Находим монитор, на котором находится мышь
    monitorCount := MonitorGetCount()
    loop monitorCount {
        MonitorGet A_Index, &left, &top, &right, &bottom
        if (mouseX >= left and mouseX <= right and mouseY >= top and mouseY <= bottom) {
            return A_Index
        }
    }
    return 1 ; По умолчанию первый монитор
}

; Additional hotkeys for controlling window size
#+b:: ; Win+Shift+B - развернуть на весь экран
{
    if WinExist("ahk_exe chrome.exe") {
        chromeID := WinExist("ahk_exe chrome.exe")
        WinActivate chromeID
        WinMaximize chromeID
    }
}

#^b:: ; Win+Ctrl+B - restore normal size
{
    if WinExist("ahk_exe chrome.exe") {
        chromeID := WinExist("ahk_exe chrome.exe")
        WinActivate chromeID
        WinRestore chromeID
        CenterWindow(chromeID)
    }
}

#!b:: ; Win+Alt+B - restart Chrome
{
    ; Закрываем все окна Chrome
    try {
        RunWait "taskkill /f /im chrome.exe", , "Hide"
        Sleep 500
    } catch as err {
        ; Игнорируем ошибки при закрытии
    }
    
    ; Запускаем Chrome
    try {
        Run "chrome.exe"
    } catch {
        try {
            Run "C:\Program Files\Google\Chrome\Application\chrome.exe"
        } catch as err {
            MsgBox "Не удалось запустить Chrome: " err.Message
        }
    }
}

#+v:: ; Win+Shift+V - maximize window
{
    if WinExist("ahk_exe Code.exe") {
        vscodeID := WinExist("ahk_exe Code.exe")
        WinActivate vscodeID
        WinMaximize vscodeID
    }
}

#^v:: ; Win+Ctrl+V - restore normal size
{
    if WinExist("ahk_exe Code.exe") {
        vscodeID := WinExist("ahk_exe Code.exe")
        WinActivate vscodeID
        WinRestore vscodeID
        CenterWindow(vscodeID)
    }
}

#!v:: ; Win+Alt+V - restart VS Code
{
    ; Закрываем все окна VS Code
    if WinExist("ahk_exe Code.exe") {
        ; Пытаемся корректно закрыть VS Code
        vscodeID := WinExist("ahk_exe Code.exe")
        WinClose vscodeID
        Sleep 1000
        
        ; Проверяем, закрылся ли процесс
        if ProcessExist("Code.exe") {
            try {
                RunWait "taskkill /f /im Code.exe", , "Hide"
                Sleep 500
            } catch as err {
                ; Игнорируем ошибки при закрытии
            }
        }
    }
    
    ; Запускаем VS Code
    try {
        Run "code.exe"
    } catch {
        try {
            Run "C:\Users\" A_UserName "\AppData\Local\Programs\Microsoft VS Code\Code.exe"
        } catch {
            try {
                Run "C:\Program Files\Microsoft VS Code\Code.exe"
            } catch as err {
                MsgBox "Не удалось запустить VS Code: " err.Message
            }
        }
    }
}

; Additionally: Win+Alt+Shift+V - open VS Code in the current folder of the file explorer
#!+v::
{
    ; Проверяем, активно ли окно проводника
    if WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass") {
        ; Получаем путь из адресной строки проводника
        hwnd := WinExist("A")
        
        ; Для Windows 10/11 используем другой подход
        try {
            ; Пытаемся получить путь через ControlGetText
            folderPath := ControlGetText("Edit1", "ahk_id " hwnd)
            
            if (folderPath != "") {
                ; Запускаем VS Code в этой папке
                Run 'code.exe "' folderPath '"'
                return
            }
        } catch as err {
            ; Обработка ошибки
        }
        
        ; Альтернативный метод для некоторых версий Windows
        try {
            Send "!d" ; Alt+D - выделить адресную строку
            Sleep 100
            Send "^c" ; Ctrl+C - скопировать путь
            Sleep 100
            
            folderPath := A_Clipboard
            if (folderPath != "") {
                Run 'code.exe "' folderPath '"'
                return
            }
        } catch as err {
            ; Обработка ошибки
        }
    }
    
    ; Если не удалось получить путь или проводник не активен, просто открываем VS Code
    try {
        Run "code.exe"
    } catch as err {
        MsgBox "Не удалось запустить VS Code: " err.Message
    }
}