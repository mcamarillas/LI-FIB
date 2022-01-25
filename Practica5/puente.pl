%Misioneros”: buscamos la manera más rápida para tres misioneros y tres canı́bales de cruzar
%un rı́o, disponiendo de una canoa que puede ser utilizada por 1 o 2 personas (misioneros o canı́bales),
%pero siempre evitando que haya misioneros en minorı́a en cualquier orilla (por razones obvias).
%Usa (es obligatorio) el siguiente esquema Prolog para resolver los dos problemas:


%canoa = 0 esta en el lado1, canoa = 1 esta en el lado 2
%unPaso([clado1,mlado1,clado2,mlado2,canoa],[clado1',mlado1',clado2',mlado2',canoa']).

coste(1,2,2).
coste(2,1,2).
coste(1,5,5).
coste(5,1,5).
coste(1,8,8).
coste(8,1,8).
coste(2,5,5).
coste(5,2,5).
coste(2,8,8).
coste(8,2,8).
coste(5,8,8).
coste(8,5,8).


unPaso(C1,[L1,L2,1],[LL1,LL2,2]):- %CRUZA 1 DEL LADO 1 AL LADO 2
		member(C1, L1),
    write([L1,L2,1]),
    nl,
		delete(L1,C1,LL1),
		append(L2,C1,LL2),
    write([LL1,LL2,2]),
    nl, nl, nl.

unPaso(M,[L1,L2,1],[LL1,LL2,2]):- %CRUZAN 2 DEL LADO 1 AL LADO 2
		member(C1, L1),
		member(C2, L1),
		C1 \= C2,
		delete(L1,C1,LL1),
    delete(L1,C2,LL1),
		append(L2,[C1,C2],LL2),
		coste(C1,C2,M).

unPaso(C1,[L1,L2,2],[LL1,LL2,1]):- %CRUZA 1 DEL LADO 2 AL LADO 1
		member(C1, L2),
		delete(L2,C1,LL2),
		append(L1,C1,LL1).


%%%%%%%%%%%%%lado2->lado1
unPaso(M,[L1,L2,2],[LL1,LL2,1]):- %CRUZAN 2 DEL LADO 2 AL LADO 1
		member(C1, L2),
		member(C2, L2),
		C1 \= C2,
		delete(L2,C1,LL2),
    delete(L2,C2,LL2),
		append(L1,[C1,C2],LL1),
		coste(C1,C2,M).



%camino( Estado Actual, Estado Final, CaminoHastaAhora, CaminoTotal).
camino(_,E,E,C,C).
camino(P,EstadoActual,EstadoFinal,CaminoHastaAhora,CaminoTotal):-
unPaso(M,EstadoActual,EstSiguiente),
\+member(EstSiguiente,CaminoHastaAhora),
P1 is P+M,
camino(P1,EstSiguiente,EstadoFinal,[EstSiguiente|CaminoHastaAhora],
	CaminoTotal), write(CaminoHastaAhora), nl.


nat(0).
nat(N):- nat(N1), N is N1 + 1.

solucionOptima:-
	nat(N),
	R is 0,
	camino(R,[[1,2,5,8],[],1],[[],[1,2,5,8],2],[[[1,2,5,8],[],1]],C),
	length(R,N),
	write(C).
