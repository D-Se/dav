#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export(name = `?`)]]
List maketype(RObject x, RObject y) {
  if(is<LogicalVector>(x) & is<Formula>(y)) {
    // return 5;
    List l;
    List k;
    l = as<List>(y);
    for (int i=1; i<l.size(); i++) {
      Language x = l[i];
      k[i] = x;
    }
    return l;
  } else {
    return 1;
  }
}
