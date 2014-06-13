#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern "C" {
#include "wxc.h"
}

void
initFunc(void* _fun, void* _data, void* _evt) {
    printf("initFunc(fun=%p, data=%p, evt=%p)\n", _fun, _data, _evt);
}

int
main(int argc, char* argv[]) {
    void* init_closure = wxClosure_Create((TClosureFun)initFunc, NULL);
    ELJApp_InitializeC(init_closure, argc, argv);
    return 0;
}
