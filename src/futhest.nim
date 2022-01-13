# import clang

type
  CXIndex = pointer
  CXTranslationUnit = pointer
  CXCursor* {.bycopy.} = object
    kind*: byte
    xdata*: cint
    data*: array[3, pointer]

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


var
  index = createIndex(0, 0)
  unit = parseTranslationUnit(index, "csrc/header.h".cstring, nil, 0, nil, 0, 0)

doAssert not unit.isNil

var cursor = getTranslationUnitCursor(unit) # SIGSEGV

# never reached
disposeTranslationUnit(unit)

echo "END"