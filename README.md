# Reponere (Still a WIP, nothing works yet)
A snippet system... in Racket! :D

## Getting started

### Creating snippets
Create your snippets under `~/.config/reponere/`.

Creating a snippet in here will allow it to be expanded. For example, if we
create a snippet called `email` with the contents `myrealemailaddress@gmail.com`,
whenever we type `email<ctrl><space>` it will be replaced with the contents of that file.

The placeholder trigger is <ctr><space>.

### Running it  

Once a snippet is created, you can run the following

```
cd ./src
racket reponere.rkt
```

Now Reponere will begin listening to your key presses.

### Caveats

Because `xinput` doesn't differentiate key codes when the shift key is pressed,
it's a good idea to only name your snippets with lower case [a-z].

i.e. Snippet filenames are case-insensitive.

## Dependencies

It uses X server for all input
(though if there's enough demand I'll probably look at supporting others)

You need:

- `xdotool` - Sends keystrokes to a given window
- `xinput`  - Tracks keypresses (Usually already installed on Debian distros)

## Tests

There are some. 
To run them, cd into the `tests` directory and run `racket tests.rkt`.

