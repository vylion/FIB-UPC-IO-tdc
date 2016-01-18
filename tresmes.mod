set FACT;
set MERC;
set ARCTR within (FACT cross MERC);
set ORIGEN;
set ARC_FACT within (ORIGEN cross FACT);
set ARC_EXC within (ORIGEN cross MERC);
param CTRANS {(i,j) in ARCTR} >=0;
param a {(i,j) in ARC_EXC}>=0;
param b {(i,j) in ARC_EXC};
param dmax {j in MERC}>0;
param alfa {(i,j) in ARC_FACT}>0;
param beta {(i,j) in ARC_FACT};
param dtotal>0;

node O_R {l in ORIGEN}: net_out = dtotal;
node P {i in FACT};
node MR {j in MERC}: net_in = dmax[j];
arc fict {(l,j) in ARC_EXC} >= 0,
     from O_R[l], to MR[j];
arc xij {(i,j) in ARCTR} >= 0,
     from P[i], to MR[j];
arc s_i {(i,j) in ARC_FACT} >=0,
     from O_R[i], to P[j];
minimize FF:
  (sum {(i,j) in ARC_FACT} (alfa[i,j]*s_i[i,j]+0.5*beta[i,j]*s_i[i,j]^2)) + 
  (sum {(p,q) in ARCTR} CTRANS[p,q]*xij[p,q])+
  (sum {(r,s) in ARC_EXC} (a[r,s]*fict[r,s] + 0.5*b[r,s]*fict[r,s]^2));

