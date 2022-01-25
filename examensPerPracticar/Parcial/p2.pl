ok([]).
ok([_]).
ok([[_,Y],[Y,Z]|S]):- ok([[Y,Z]|S]).

flip([],[]).
flip([[X,Y]|L],[[X,Y]|R]):- flip(L,R).
flip([[X,Y]|L],[[Y,X]|R]):- flip(L,R).

subsett([],[]).
subsett([_|L],S):- subsett(L,S).
subsett([X|L],[X|S]):- subsett(L,S).

all_chains(L):- subsett(L,T), permutation(T,S),  flip(S,R),  ok(R), write(R).