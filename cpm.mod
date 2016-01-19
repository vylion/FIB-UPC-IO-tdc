# CONJUNTOS
set NODOS;
param orig symbolic in NODOS;
param dest symbolic in NODOS, <> orig;

set ARCOS within (NODOS diff {dest}) cross (NODOS diff {orig});

#PARAMETROS
param tau {(i,j) in ARCOS} >= 0;
# duracion de trabajo [i,j]

#VARIABLES
var t {j in NODOS} default 0; #= max {i in NODOS} tau[i,j]
# momento en que termina el trabajo [i,j]

#FUNCION Y RESTRICCIONES

minimize time: t[dest];
subject to r1 {(i,j) in ARCOS}:
	t[i] + tau[i,j] - t[j] <= 0;
subject to r2 {i in NODOS}:
	t[i] >= 0;
	