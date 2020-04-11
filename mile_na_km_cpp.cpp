#include <Rcpp.h>
using namespace Rcpp;
// [[Rcpp::export]]
List mi_do_km3(List odl_mile){
  int odl_mile_len = odl_mile.size();
  List result(odl_mile_len);
  for (int i = 0; i < odl_mile_len; i++){
    result[i] = odl_mile[i] * 1.609;
  }
  return(result);
}