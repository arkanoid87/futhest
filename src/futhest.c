#include <assert.h>
#include <stdio.h>
#include "clang-c/Index.h"


enum CXChildVisitResult
visitor(CXCursor cursor, CXCursor parent, CXClientData clientData) {
    CXFile file;
    unsigned int line;
    unsigned int column;
    unsigned int offset;

    CXSourceLocation loc = clang_getCursorLocation(cursor);
    clang_getFileLocation(loc, &file, &line, &column, &offset);

    CXString filename = clang_getFileName(file);   
    printf("%s [%d:%d, %d]\n", clang_getCString(filename), line, column, offset);
    clang_disposeString(filename);

    return CXChildVisit_Continue;
}

int main (void) { 
    CXIndex Idx = clang_createIndex(0, 0);

    CXTranslationUnit TU = clang_parseTranslationUnit(Idx, 
        "src/header.h", NULL, 0, NULL, 0, 0);

    assert(TU != NULL);

    CXCursor cursor = clang_getTranslationUnitCursor(TU);

    clang_visitChildren(cursor, visitor, NULL);

    clang_disposeTranslationUnit(TU);

    printf("END");
}
