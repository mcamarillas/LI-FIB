/*Dado un natural n > 0, una posici ́on inicial (F ilaI , ColumnaI ), una posici ́on final (F ilaF , ColumnaF ),
y un n ́umero de pasos P , encontrar un camino de (F ilaI , ColumnaI ) a (F ilaF , ColumnaF ), en un
tablero de ajedrez de n × n en exactamente P pasos de caballo. El programa ha de fallar si para la n
en cuesti ́on no existe tal camino.*/

correcto(N,[F2,C2]):-
  F2 < N,
  C2 < N.

%%%%%%%[+-I,+-2J]%%%%%%%%
unPaso([F1,C1],[F2,C2]):- %1o2 misionero lado1->lado2
  member(I,[1,-1]),
  member(J,[2,-2]),
  F2 is F1 + I,
  C2 is C1 + J.

%%%%%%%[+-2I,+-J]%%%%%%%%
unPaso([F1,C1],[F2,C2]):- %1o2 misionero lado1->lado2
  member(I,[2,-2]),
  member(J,[1,-1]),
  F2 is F1 + I,
  C2 is C1 + J.


%camino( Estado Actual, Estado Final, CaminoHastaAhora, CaminoTotal).
camino(1,_,E,E,C,C).
camino(P,N,EstadoActual,EstadoFinal,CaminoHastaAhora,CaminoTotal):-
  unPaso(EstadoActual,EstSiguiente),
  correcto(N,EstSiguiente),
  P1 is P-1,
  P1 > 0,
  camino(P1,N,EstSiguiente,EstadoFinal,[EstSiguiente|CaminoHastaAhora],
  CaminoTotal).


solucionOptima(N,FI,CI,FF,CF,P):-
  P1 is P + 1,
	camino(P1,N,[FI,CI],[FF,CF],[[FI,CI]],C),
	write(C).
