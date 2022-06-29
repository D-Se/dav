#include <R.h>
#include <Rdefines.h>
#include <string.h>
// SEXP helloC1(SEXP greeting) {
//   int i, vectorLength, stringLength;
//   SEXP result;
//   PROTECT(greeting = AS_CHARACTER(greeting));
//   vectorLength = LENGTH(greeting);
//   PROTECT(result = NEW_INTEGER(vectorLength));
//   for (i=0; i<vectorLength; i++) {
//     stringLength = strlen(CHAR(STRING_ELT(greeting, i)));
//     INTEGER(result)[i] = stringLength;
//   }
//   UNPROTECT(2);
//   return(result);
// }

SEXP doubleme(SEXP x) {
  SEXP result;
  PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = INTEGER(x)[0] *2;
  UNPROTECT(1);
  return result;
}