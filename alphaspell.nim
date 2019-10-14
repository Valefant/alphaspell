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
  quit 0

proc printVersion() =
  echo "alphaspell v.01"
  quit 0

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
        activeLanguage = p.val.toLowerAscii()
  else:
    discard

if activeLanguage notin supportedLanguages:
  quit(&"Language {activeLanguage} is not supported!")

let reads =
  readFile(&"translations/{activeLanguage}.txt")
  .splitLines()
  .filterIt(it.len != 0)
  .mapIt(it.strip())
let translations = zip(toSeq('0' .. '9') & toSeq('a' .. 'z'), reads).toTable

var input = ""
let stream = newFileStream(stdin)
while stream.readLine(input):
  let sanitizedInput = input.strip().toLowerAscii()
  for c in sanitizedInput:
    if translations.hasKey(c):
      echo &"{c} | {translations[c]}"
    else:
      echo &"{c}"
