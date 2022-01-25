flip([],[]).
flip([[X,Y]|L],[[X,Y]|R]):-flip(L,R).
flip([[X,Y]|L],[[Y,X]|R]):-flip(L,R).

ok([]).
ok([_]).
ok([[_,Y],[Y,X]|L]):-ok([[Y,X]|L]).

chain(L,R):- flip(L,R), ok(R).
