# alphaspell
A small utility program for the command line to spell out characters in words when making a phone call.

## Translations
A translation a is spelled out character for example ``A`` for ``Alfa``.
They are located here: [translations](translations)
and currently supported translations are English, German and Italian. 

## Usage
The program reads from stdin. Therefore you can pipe or redirect files as input to it.
When no argument for the language is given the translation defaults to english.
```bash
Usage: alphaspell [options] stdin
Spells out characters in words to standard output.
  -l, --lang=<lang>
                 de, en, it [default: en]
  -h, --help     Display this help and exit
  -V, --version  Output version information and exit
```

An example using the default english translations
```bash
echo "hello world" | alphaspell
h | Hotel
e | Echo
l | Lima
l | Lima
o | Oscar
 
w | Whiskey
o | Oscar
r | Romeo
l | Lima
d | Delta
```

An example using the german translations
```bash
echo "hallo welt" | alphaspell --lang=de
h | Heinrich
a | Anton
l | Ludwig
l | Ludwig
o | Otto
 
w | Wilhelm
e | Emil
l | Ludwig
t | Theodor
```

### Nim 
For building this project Nim has to be installed.
Visit [Install Nim](https://nim-lang.org/install.html) for further information.

#### Compile and run
```bash
nim c -r alphaspell.nim
# or
nim c alphaspell.nim
./alphaspell
```

#### Invoke it from anywhere
```bash
sudo ln -s $(pwd)/alphaspell /usr/local/bin/alphaspell
```
