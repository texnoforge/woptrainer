# Words of Power Trainer

This is a **Godot 3** app to help with gathering training data for
[TexnoMagic](https://texnoforge.github.io/texnomagic/) alphabets, currently
focused on [TexnoLatin](https://github.com/texnoforge/texnolatin) reference alphabet
as a part of [Words of Power](https://texnoforge.dev/words-of-power/) project.

User is tasked with drawing a specific symbol using mouse (or any other
pointing/touch device) and pressing **GOOD** or **BAD** button to submit the
drawing to a [wopvault](https://github.com/texnoforge/wopvault) server for
further processing.

Only drawing data are anonymously sent to the server as a series of points
using HTTP request, nothing else.

The app can be exported into HTML5 for maximum ease of use from any browser.

Godot 3 is used for its wider browser support until Godot 4 gets
single-threaded HTML exports back (expected in 4.3).

You can use this directly from your browser:

[train.texnoforge.dev](https://train.texnoforge.dev/)
