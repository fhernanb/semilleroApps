#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
double distan_np(DataFrame df) {
  
  // access the columns
  NumericVector value = df["value"];
  NumericVector weight = df["weight"];
  NumericVector binary = df["binary"];
  
  int i, n = value.length();
  double actecdf = weight[0], otherecdf = 0, actbin = binary[0], dis = 0;
  
  for(i = 1; i < n; i++){
    dis += (value[i] - value[i-1])*(actecdf - otherecdf)*(actecdf - otherecdf);
    if(binary[i] == actbin){actecdf += weight[i];}
    if(binary[i] == 1 - actbin){otherecdf += weight[i];}
  }
  
  // return a distance
  return sqrt(dis);
}


// [[Rcpp::export]]
double EMD(DataFrame df) {
  
  // access the columns
  NumericVector value = df["value"];
  NumericVector weight = df["weight"];
  NumericVector binary = df["binary"];
  
  int i, n = value.length();
  double actecdf = weight[0], otherecdf = 0, actbin = binary[0], dis = 0;
  
  for(i = 1; i < n; i++){
//    dis += (value[i] - value[i-1])*(actecdf - otherecdf)*(actecdf - otherecdf);
    dis += (value[i] - value[i-1])*std::abs(actecdf - otherecdf);
    if(binary[i] == actbin){actecdf += weight[i];}
    if(binary[i] == 1 - actbin){otherecdf += weight[i];}
  }
  
  // return a distance
  return dis;
}

// [[Rcpp::export]]
double corregir(int n_1, int n_2, double d){
  //  return sqrt((d*d*d + fmin(n_1, n_2)*d)/(d*d + 1));
  return fmin(sqrt(d) + 1, sqrt(fmin(n_1, n_2)*d));
}

// [[Rcpp::export]]
double distan_def(DataFrame df) {
  
  // access the columns
  NumericVector value = df["value"];
  NumericVector weight = df["weight"];
  NumericVector binary = df["binary"];
  
  int i, n_act = 0, n_oth = 0, n = value.length();
  double actecdf = weight[0], otherecdf = 0, actbin = binary[0], dis = 0;
  
  for(i = 1; i < n; i++){
    dis += (value[i] - value[i-1])*(actecdf - otherecdf)*(actecdf - otherecdf);
    if(binary[i] == actbin){
      actecdf += weight[i];
      n_act++;
      }
    if(binary[i] == 1 - actbin){
      otherecdf += weight[i];
      n_oth++;
      }
  }
  
  // return a distance
  return corregir(n_act, n_oth, dis);
}

