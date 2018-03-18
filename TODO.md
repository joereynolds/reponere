# TODO
- Kill the process when we stop the program
  (we get a pid from starting xinput so just kill that)

# Caveats
- The keymap is mapped for British keyboards, no idea
  if this will be a problem on american keyboards.
  Definitely a problem on chinese keyboards...

# Ramblings

- There are 2 log files (so far)
  - The raw keypress log file generated from xinput 
  - A prettier version which reponere will read from.
    The prettier version is created by reponere from    
    converting the keycodes into letters.

# Troubleshooting

- Multiple keypresses in the log    
  - Make sure only one instance of xinput is running otherwise janky stuff will happen.
    kill <tab> (filter by xinput)
