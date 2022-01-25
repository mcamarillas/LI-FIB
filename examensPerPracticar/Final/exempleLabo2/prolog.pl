% An undirected graph is 2-colorable iff it has no odd-length cycle.  
% Note: "odd" = "impar" (castellano) = "senar" (català).
% Given an undirected graph like the one of the example below, complete the following 
% prolog code to either find a two-coloring for it, or detect an odd-length cycle.

%%%====================== EXAMPLE:
numNodes(10).
% This graph is 2-colorable:
edge(10,4).
edge(7,3).
edge(4,3).
edge(3,5).
edge(1,8).
edge(2,6).
edge(4,3).
edge(3,4).
edge(9,5).
edge(9,8).
edge(2,6).
edge(3,8).
edge(9,6).
edge(7,2).
edge(7,8).  % But adding this edge there is an odd-length cycle.
%=========================

main:- twoColorable, oddLengthCycle, halt.

twoColorable:-  numNodes(N), length(L,N), %this creates a list L of N prolog variables
		assignColors(L), \+sameColorsInSomeEdge(L), nl, write('2-coloring: '), write(L),nl,!.
twoColorable:-  nl,write('This graph is not 2-colorable.'), nl,!.

% Assigns colors (black or white) to each prolog variable in the list:
assignColors([]).
assignColors([black|L]):- assignColors(L).
...

% nth1(N,L,E) means: "The N-th element of list L is E"
sameColorsInSomeEdge(L):- nth1(N1,L,Color),  ...



oddLengthCycle:- numNodes(N), between(1,N,Initial), camino( Initial, ... , [], ... ),
		 length(C,Len), 
		 ...
		 nl, write('Odd length cycle: '), reverse(C,C1), write([Initial|C1]), nl, !.
oddLengthCycle:- nl,write('This graph has no odd length cycle.'), nl,!.

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    unPaso( EstadoActual, EstSiguiente ),
    \+member(EstSiguiente,CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

unPaso(A,B):- edge(A,B).
unPaso(A,B):- edge(B,A).

    
