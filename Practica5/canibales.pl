%Misioneros”: buscamos la manera más rápida para tres misioneros y tres canı́bales de cruzar
%un rı́o, disponiendo de una canoa que puede ser utilizada por 1 o 2 personas (misioneros o canı́bales),
%pero siempre evitando que haya misioneros en minorı́a en cualquier orilla (por razones obvias).
%Usa (es obligatorio) el siguiente esquema Prolog para resolver los dos problemas:


%canoa = 0 esta en el lado1, canoa = 1 esta en el lado 2
%unPaso([clado1,mlado1,clado2,mlado2,canoa],[clado1',mlado1',clado2',mlado2',canoa']).

noComen(_,0).
noComen(C,M):-C=<M.

correcto([C1,M1,C2,M2,_]):-
	M1 >= 0, M1=<3, C1 >= 0, C1=<3,
    M2 >= 0, M2=<3, C2 >= 0, C2=<3,
    noComen(C1, M1),
    noComen(C2, M2),!.

%%%%%%%%%%%%%lado1->lado2
unPaso([C1,M1,C2,M2,0],[C1,M11,C2,M22,1]):- %1o2 misionero lado1->lado2
		member(N, [1,2]),
		M11 is M1-N,
		M22 is M2+N,
		correcto([C1,M11,C2,M22,1]).

unPaso([C1,M1,C2,M2,0],[C11,M1,C22,M2,1]):- %1o2 canibal lado1->lado2
		member(N, [1,2]),
		C11 is C1-N,
		C22 is C2+N,
		correcto([C11,M1,C22,M2,1]).

unPaso([C1,M1,C2,M2,0],[C11,M11,C22,M22,1]):- %1 misionero + 1 canibal lado1->lado2
		M11 is M1-1,
		M22 is M2+1,
		C11 is C1-1,
		C22 is C2+1,
		correcto([C11,M11,C22,M22,1]).


%%%%%%%%%%%%%lado2->lado1
unPaso([C1,M1,C2,M2,1],[C1,M11,C2,M22,0]):- %1o2 misionero lado2->lado1
		member(N, [1,2]),
		M22 is M2-N,
		M11 is M1+N,
		correcto([C1,M11,C2,M22,0]).

unPaso([C1,M1,C2,M2,1],[C11,M1,C22,M2,0]):- %1 canibal lado2->lado1
		member(N, [1,2]),
		C22 is C2-N,
		C11 is C1+N,
		correcto([C11,M1,C22,M2,0]).


unPaso([C1,M1,C2,M2,1],[C11,M11,C22,M22,0]):- %1 misionero + 1 canibal lado1->lado2
		M22 is M2-1,
		M11 is M1+1,
		C22 is C2-1,
		C11 is C1+1,
		correcto([C11,M11,C22,M22,0]).




%camino( Estado Actual, Estado Final, CaminoHastaAhora, CaminoTotal).
camino(E,E,C,C).
camino(EstadoActual,EstadoFinal,CaminoHastaAhora,CaminoTotal):-
unPaso(EstadoActual,EstSiguiente),
\+member(EstSiguiente,CaminoHastaAhora),
camino(EstSiguiente,EstadoFinal,[EstSiguiente|CaminoHastaAhora],
	CaminoTotal).


nat(0).
nat(N):- nat(N1), N is N1 + 1.

solucionOptima:-
	nat(N),

	camino([3,3,0,0,0],[0,0,3,3,1],[[3,3,0,0,0]],C),
	length(C,N),
	write(C).
