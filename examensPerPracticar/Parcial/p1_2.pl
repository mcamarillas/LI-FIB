selecti(_,[],[]).
selecti([X,Y], [[X,Y]|L], L):- !.
selecti([X,Y], [[X1,Y1]|L],[[X1,Y1]|R]):- selecti([X,Y], L, R), !.

path(_,N,N):- !.
path(G,N1,N2):- select([N1,X],G,R), path(R,X,N2),!.