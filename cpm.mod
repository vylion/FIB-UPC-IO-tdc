# CONJUNTOS
set NODOS;
param orig symbolic in NODOS;
param dest symbolic in NODOS, <> orig;

set ARCOS within (NODOS diff {dest}) cross (NODOS diff {orig});

#PARAMETROS
param t {j in NODOS} >= 0;			# momento en que termina el trabajo [i,j]
param tau {(i,j) in ARCOS} >= 0;	# duracion de trabajo [i,j]

#VARIABLES


#FUNCION Y RESTRICCIONES