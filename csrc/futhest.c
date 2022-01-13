#include <assert.h>
#include <stdio.h>
#include "clang-c/Index.h"


int main (void) { 
    CXIndex Idx = clang_createIndex(0, 0);

    CXTranslationUnit TU = clang_parseTranslationUnit(Idx, 
        "header.h", NULL, 0, NULL, 0, 0);

    assert(TU != NULL);

    CXCursor cursor = clang_getTranslationUnitCursor(TU);
    
    clang_disposeTranslationUnit(TU);

    printf("END");
}
