<div align="center">

# smt-installer

The NSIS script that builds the `.exe` setup for Schooi's Multitool.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Built with NSIS](https://img.shields.io/badge/built%20with-NSIS-blue.svg)](https://nsis.sourceforge.io/)
[![Parent project](https://img.shields.io/badge/parent%20project-SMT-orange.svg)](https://github.com/SchooiCodes/smt)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](../../pulls)

</div>

## What's here

[Schooi's Multitool (SMT)](https://github.com/SchooiCodes/smt) is a Batch project with well over a hundred tools in it. Nobody wants to install that by hand, file by file, so this repo is just the NSIS script (`setup.nsi`) that packages everything into one installer: Schooi's Multitool Setup.exe.

If you actually want to install SMT, go grab it from the [main repo](https://github.com/SchooiCodes/smt). This repo is for people who want to see how the installer works or who want to steal the setup for their own project.

## What the installer does

It's built with NSIS and the MUI2 interface, and it does a bit more than just dump files onto disk:

- Every file and registry key it writes gets logged, so uninstalling only removes what was actually installed rather than nuking the whole folder.
- If `Files\config\settings.ini` already exists, it gets backed up before the new files are copied in and restored right after, so upgrading doesn't wipe your settings.
- It registers a proper Add/Remove Programs entry, publisher, version, help link, the works, so Windows treats it like a normal app instead of some random exe.
- Silent installs work with `/S`.
- A few extra switches are handled manually in `.onInit`, since NSIS only understands `/S` natively:
  - `/silent`, `/SILENT`, `/Silent`, `-silent`, `--silent` all trigger silent mode too
  - `/NOSHORTCUT` or `/noshortcut` skips the desktop shortcut, even during a silent install
- If SMT is already installed, it checks the version and offers to uninstall the old one first instead of just overwriting it.
- The desktop shortcut can be turned off on the components page.
- It launches SMT when setup finishes, including on silent installs (NSIS's built-in "run on finish" only fires on a page that silent mode skips, so this is handled separately).

## Layout

```
smt-installer/
├── setup.nsi        the installer script itself
├── nsisifier.bat    Schooi's personal build/release script (see below)
├── assets/
│   ├── smt.ico      icon for the installer and shortcut
│   ├── head.bmp     header banner on the wizard pages
│   └── welcome.bmp  sidebar image on welcome/finish pages
├── license.txt      MIT text shown on the installer's license page
└── LICENSE          same MIT text, for GitHub
```

A note on `nsisifier.bat`: that's just Schooi's own build script for his machine. It expects a `Documents\Github\smt` folder, compiles with `makensis.exe`, can bump a version marker, and will even commit and push for you if you let it. It's in the repo so people can see how the release process works, but it's tied to one specific setup and isn't meant to be run as-is. Write your own build step instead.

## Building it

You need [NSIS](https://nsis.sourceforge.io/Download) installed. The script assumes `makensis.exe` is at `C:\Program Files (x86)\NSIS\makensis.exe`, which is the default location.

1. Clone this next to a checkout of [SMT](https://github.com/SchooiCodes/smt). `setup.nsi` expects an `app\` folder beside it with the files to package.
2. Run:
   ```
   makensis.exe setup.nsi
   ```
3. The finished Schooi's Multitool Setup.exe shows up in the output folder.

## Why your antivirus might yell at it

The installer downloads and unpacks a bunch of files when it runs, which looks a lot like what "dropper" malware does, so some AVs (Defender included) flag it on that pattern alone. If that bothers you, the [main SMT repo](https://github.com/SchooiCodes/smt) has plain install commands that skip the exe entirely.

## License

MIT, same as the parent SMT project. See [LICENSE](LICENSE).

## Related

- [SchooiCodes/smt](https://github.com/SchooiCodes/smt) — the multitool this installer packages
- [Schooi's Multitool site](https://schooicodes.github.io/smtweb/) — features and download page
