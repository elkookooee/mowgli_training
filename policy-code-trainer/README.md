# Policy Code Trainer (wslc container)

A static study site for Skyhigh Policy Code: 9 lessons with exercises and quizzes, plus a spaced-repetition flashcard deck. Served by nginx.

## Requirements

- WSL 2.9.3 or later (`wsl --version`). `wslc` ships with WSL; there is nothing separate to install.
- Update with `wsl --update`. If `wslc` still isn't found, the container feature may only be in a pre-release build on your machine: run `wsl --update --pre-release`, then `wsl --shutdown`, and open a new terminal.
- Check it works: `wslc version`.

## Run it

From PowerShell in this folder:

```powershell
.\start.ps1
```

Then open http://localhost:8080. Use `.\start.ps1 -Port 9090` for a different port, and `.\start.ps1 -Stop` to stop it.

If script execution is blocked, either run `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` once, or run the commands by hand:

```powershell
wslc build -t policy-code-trainer .
wslc run -d --rm -p 8080:80 --name policy-trainer policy-code-trainer
wslc container stop policy-trainer
```

## Useful commands

```powershell
wslc container list             # is it running?
wslc container logs policy-trainer
wslc image list
```

## Notes

- Your quiz scores, flashcard boxes and exercise drafts are saved in your browser's local storage for `localhost:8080`. They survive container restarts, but they are separate from the claude.ai version, and changing the port starts fresh.
- Fonts load from Google Fonts. Offline, the page falls back to system fonts and still works.
- For faster builds, Microsoft recommends keeping the project on the WSL Linux file system rather than a Windows drive.
- To update the content, replace `site/index.html` and run `.\start.ps1` again.
