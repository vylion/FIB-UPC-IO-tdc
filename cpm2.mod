# CONJUNTOS
set NODOS;
param orig symbolic in NODOS;
param dest symbolic in NODOS, <> orig;

set ARCOS within (NODOS diff {dest}) cross (NODOS diff {orig});

#PARAMETROS
param tau_worst {(i,j) in ARCOS} >= 0;
# duracion de trabajo de menor coste [i,j]
param tau_best {(i,j) in ARCOS} >= 0;
# duracion mejorada de trabajo [i,j]
param cost {(i,j) in ARCOS} >= 0;
#coste monetario de los trabajos
param alpha;

#VARIABLES
var t {j in NODOS} default 0;
# momento en que termina el trabajo [i,j]
var tau {(i,j) in ARCOS};
# duracion de trabajo [i,j]

#FUNCION Y RESTRICCIONES

minimize time :
	alpha*(t[dest]) + (1-alpha)*(sum {(i,j) in ARCOS} (tau_worst[i,j] - tau[i,j])*cost[i,j]);
subject to r1 {(i,j) in ARCOS}:
	t[i] + tau[i,j] - t[j] <= 0;
subject to r2 {i in NODOS}:
	t[i] >= 0;
subject to r3 {(i,j) in ARCOS}:
	tau_best[i,j] <= tau[i,j];
subject to r4 {(i,j) in ARCOS}:
	tau_worst[i,j] >= tau[i,j];

