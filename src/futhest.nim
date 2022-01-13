# import clang

type
  CXIndex = pointer
  CXTranslationUnit = pointer
  CXCursor = pointer


#[
CINDEX_LINKAGE CXIndex clang_createIndex(int excludeDeclarationsFromPCH,
                                         int displayDiagnostics);
]#
proc createIndex*(excludeDeclarationsFromPCH: cint; displayDiagnostics: cint): CXIndex {.
    importc: "clang_createIndex", cdecl.}


#[
CINDEX_LINKAGE CXTranslationUnit
clang_parseTranslationUnit(CXIndex CIdx,
                           const char *source_filename,
                           const char *const *command_line_args,
                           int num_command_line_args,
                           struct CXUnsavedFile *unsaved_files,
                           unsigned num_unsaved_files,
                           unsigned options);
]#
proc parseTranslationUnit*(CIdx: CXIndex; source_filename: cstring;
                          command_line_args: cstringArray;
                          num_command_line_args: cint;
                          unsaved_files: pointer;
                          num_unsaved_files: cuint; options: cuint): CXTranslationUnit {.
    importc: "clang_parseTranslationUnit", cdecl.}


#[
  CINDEX_LINKAGE CXCursor clang_getTranslationUnitCursor(CXTranslationUnit);
]#
proc getTranslationUnitCursor*(a1: CXTranslationUnit): CXCursor {.
    importc: "clang_getTranslationUnitCursor", cdecl.}


#[
  CINDEX_LINKAGE void clang_disposeTranslationUnit(CXTranslationUnit);
]#
proc disposeTranslationUnit*(a1: CXTranslationUnit) {.importc: "clang_disposeTranslationUnit", cdecl.}


# ----------------------------------------------------------------------------


static:
  # any content will fail, including empty file
  writeFile("futhark-includes.h", """
  #include "ldap.h"
""")

var
  commandLineParams = @[
    "-I/usr/lib/clang/10/include",
    "-I/usr/include"]
  index = createIndex(0, 0)
  commandLineArgs = allocCStringArray(commandLineParams)


var unit = parseTranslationUnit(index, 
  "futhark-includes.h".cstring,
  commandLineArgs, commandLineParams.len.cint, nil, 0, 0)
deallocCStringArray(commandLineArgs)

var cursor = getTranslationUnitCursor(unit) # SIGSEGV

disposeTranslationUnit(unit)