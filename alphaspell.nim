import parseopt
import sets
import sequtils
import streams
import strformat
import strutils
import system
import tables

proc printHelp() =
  echo """Usage: alphaspell [options] stdin
Spells out characters in words to standard output.
-l, --lang=<lang>
               de, en, it [default: en]
-h, --help     Display this help and exit
-V, --version  Output version information and exit"""
  quit(0)

proc printVersion() =
  echo "alphaspell v.01"
  quit(0)

const supportedLanguages = toHashSet(["de", "en", "it"])
var activeLanguage = "en"

var p = initOptParser()
while true:
  p.next()
  case p.kind
  of cmdEnd: break
  of cmdShortOption, cmdLongOption:
    if p.val == "":
      case p.key
      of "h", "help":
        printHelp()
      of "V", "version":
        printVersion()
    else:
      case p.key
      of "l", "lang":
        activeLanguage = p.val
  else:
    discard

if activeLanguage notin supportedLanguages:
  quit(&"Language {activeLanguage} is not supported!")

let stream = newFileStream(stdin)
let reads = 
  readFile(&"translations/{activeLanguage}.txt")
  .splitLines()
  .filter(proc (line: string): bool = line.len != 0)
  .map(proc (line: string): string = strip(line))
let translations = zip(toSeq('0' .. '9') & toSeq('a' .. 'z'), reads).toTable

var input = ""
while stream.readLine(input):
  let sanitizedInput = toLowerAscii(strip(input))
  for c in sanitizedInput:
    if translations.hasKey(c):
      echo &"{c} | {translations[c]}"
    else:
      echo &"{c}"
      
