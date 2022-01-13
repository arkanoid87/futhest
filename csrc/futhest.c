#include "clang-c/Index.h"


int main (void) { 
    CXIndex Idx = clang_createIndex(0, 0);
    
    const int args = 2;
    const char *commandLineArgs[args];
    commandLineArgs[0] = "-I/usr/lib/clang/10/include";
    commandLineArgs[1] = "-I/usr/include";

    CXTranslationUnit TU = clang_parseTranslationUnit(Idx, 
        "futhark-includes.h", commandLineArgs, args, 0, 0, 0);

    CXCursor cursor = clang_getTranslationUnitCursor(TU);
    
    clang_disposeTranslationUnit(TU);
}
