
#include <R.h>
#include <Rinternals.h>

extern SEXP xxhash_();


// .C      R_CMethodDef
// .Call   R_CallMethodDef
static const R_CallMethodDef CEntries[] = {
  {"xxhash_"          , (DL_FUNC) &xxhash_          , 2},
  {NULL, NULL, 0}
};


// Register the methods
//
// Change the '_simplecall' suffix to match your package name
void R_init_davhash(DllInfo *info) {
  R_registerRoutines(
    info,      // DllInfo
    NULL,      // .C
    CEntries,  // .Call
    NULL,      // Fortran
    NULL       // External
  );
  R_useDynamicSymbols(info, FALSE);
}
