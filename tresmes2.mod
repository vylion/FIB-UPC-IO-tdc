set FACT;									# Factorias
set MERC;									# Mercados
set ARCTR within (FACT cross MERC);			# Arcos de transporte
set ORIGEN;									# Nodo origen
set ARC_FACT within (ORIGEN cross FACT);	# Arcos de produccion
set ARC_EXC within (ORIGEN cross MERC);		# Arcos de exceso de demanda
param CTRANS {(i,j) in ARCTR} >=0;			# Costes de transporte
param a {(i,j) in ARC_EXC}>=0;				# Precio base fijo en mercado j cuando el producto cubre la demanda
param b {(i,j) in ARC_EXC};					# Coeficiente de subida de precio en mercado j por exceso de demanda (falta de productos)
param dmax {j in MERC}>0;					# Demanda maxima (absorbida por el mercado + exceso de producto)
param alfa {(i,j) in ARC_FACT}>0;			# Coste base fijo de produccion en factoria j
param beta {(i,j) in ARC_FACT};				# Coeficiente de coste de produccion por unidad en factoria j
param dtotal>0;								# demanda total entre todos los mercados
param theta {i in FACT}>=0;					# objetivos de produccion
var thtotal = sum {i in FACT} theta[i];		# objetivo total

node O_R {l in ORIGEN}: net_out = dtotal - thtotal;
# flow out (suma de demandas maximas) - flow in (0)
node P {i in FACT};							# Nodos de factorias
node PO {i in FACT};						# Nodos objetivo
node MR {j in MERC}: net_in = dmax[j];		# Nodos de mercados
arc fict {(l,j) in ARC_EXC} >= 0,
     from O_R[l], to MR[j];					# Arcos ficticios de exceso de demanda
arc xij {(i,j) in ARCTR} >= 0,
     from P[i], to MR[j];					# Arcos de transporte entre los nodos factorias y mercados
arc s_i {i in FACT} >=0,
     from PO[i], to P[i];					# Arcos de produccion entre los nodos objetivos y sus factorias
arc sigma_pos_i {(i,j) in ARC_FACT} >=0,
     from O_R[i], to PO[j];					# Arcos de produccion entre los nodos origen y objetivos de factorias
arc sigma_neg_i {(i,j) in ARC_FACT} >=0,
     from PO[j], to O_R[i];					# Arcos de produccion entre los nodos objetivos de factorias y origen
	 
minimize FF:
  (sum {(i,j) in ARC_FACT} (alfa[i,j]*s_i[i,j]+0.5*beta[i,j]*s_i[i,j]^2)) + 
  (sum {(p,q) in ARCTR} CTRANS[p,q]*xij[p,q])+
  (sum {(r,s) in ARC_EXC} (a[r,s]*fict[r,s] + 0.5*b[r,s]*fict[r,s]^2));

