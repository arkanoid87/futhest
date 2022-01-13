import clang

static:
  # any content will fail, including empty file
  writeFile("futhark-includes.h", """
  #include "ldap.h"
""")

var
  commandLineParams = @[
    "-I/usr/lib/clang/10/include",
    "-I/usr/include"]
  fname = "futhark-includes.h"

  index = createIndex(0, 0)
  commandLine = allocCStringArray(commandLineParams)


var unit = parseTranslationUnit(index, fname.cstring,
                              commandLine, commandLineParams.len.cint, nil, 0, CXTranslationUnit_DetailedPreprocessingRecord.cuint or CXTranslationUnit_SkipFunctionBodies.cuint)
deallocCStringArray(commandLine)

block: # testing stuff
    assert not unit.isNil
    assert unit.getNumDiagnostics == 0
    echo unit.getTranslationUnitSpelling
    echo repr unit.getCXTUResourceUsage

discard getTranslationUnitCursor(unit) # SIGSEGV
assert false