# Chrome & VS Code Window Manager for AutoHotkey v2

This AutoHotkey v2 script provides powerful window management hotkeys for Google Chrome and Visual Studio Code, allowing you to quickly switch, restore, maximize, restart, and open these applications with keyboard shortcuts.

## Features

### Chrome Hotkeys (`Win + B` family)
- **`Win + B`**: Switch to Chrome (activate if open, launch if not)
- **`Win + Shift + B`**: Maximize Chrome window
- **`Win + Ctrl + B`**: Restore Chrome to normal size and center it
- **`Win + Alt + B`**: Restart Chrome (close all windows and relaunch)

### VS Code Hotkeys (`Win + V` family)
- **`Win + V`**: Switch to VS Code (activate if open, launch if not)
- **`Win + Shift + V`**: Maximize VS Code window
- **`Win + Ctrl + V`**: Restore VS Code to normal size and center it
- **`Win + Alt + V`**: Restart VS Code (close properly and relaunch)
- **`Win + Alt + Shift + V`**: Open VS Code in the current folder of Windows File Explorer

## Smart Window Management

When activating a window with the main hotkeys (`Win+B` or `Win+V`), the script intelligently handles window states:
- If minimized: restores and centers the window
- If normal: just activates it
- If maximized: leaves it maximized
- If not running: launches the application

## Installation

1. Install [AutoHotkey v2](https://www.autohotkey.com/)
2. Save the script as `main.ahk`
3. Double-click to run
4. (Optional) Add to startup folder for automatic execution

## Requirements

- Windows 10/11
- AutoHotkey v2.0+
- Chrome and/or VS Code installed (the script will try multiple installation paths)

## Customization

You can modify the hotkeys by changing the key combinations at the beginning of each hotkey section. For example:
- Change `#b::` to `#c::` to use `Win+C` for Chrome
- Change `#v::` to `#s::` to use `Win+S` for VS Code

## Notes

- The script centers windows based on the monitor where your mouse cursor is located
- Multiple Chrome/VS Code installation paths are tried for compatibility
- The script includes error handling for cases where applications are not in PATH
- File Explorer integration works with both classic and modern Windows Explorer windows

## Troubleshooting

If hotkeys don't work:
1. Ensure AutoHotkey v2 is installed
2. Check if Chrome/VS Code executable names match (default: `chrome.exe` and `Code.exe`)
3. Run as administrator if needed
4. Check for conflicts with other hotkey software

## License

Free to use and modify.