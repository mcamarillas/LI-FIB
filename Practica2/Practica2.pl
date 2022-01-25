/* Ejercicio 1 */
prod([], 1).
prod([X|L], P):- prod(L, P1), P is X * P1.

/* Ejercicio 2 */

/* u * v = ux * vx + uy * vy + .. */
pescalar([], [], 0).
pescalar([X|L], [Y|L1], P):- length(L, N), length(L1, N1), 
                           N = N1, 
                           pescalar(L, L1, P1), 
                           P is P1 + X * Y.

/* Ejercicio 3 */

union([], L, L).
union([X|L], L1, L2):- member(X,L1), !, union(L,L1,L2). 
union([X|L], L1, [X|L2]):- union(L,L1,L2).

interseccion([],_,[]).
interseccion([X|L], L1, [X|L2]):- member(X, L1), !, interseccion(L, L1, L2).
interseccion([_|L], L1, L2):- interseccion(L, L1, L2).

/* Ejercicio 4 */

ultimoElemento([X|L], X):- length([X|L], N), N = 1, !.
ultimoElemento([_|L], Y):- ultimoElemento(L,Y).

inverso([],[]).
inverso([X|L],L1):- inverso(L,L2), append(L2,[X],L1).

/* Ejercicio 5 */

fib(1,1):- !.
fib(2,1):- !.
fib(N,F):- N1 is N - 1, N2 is N - 2, 
           fib(N1,F1), fib(N2,F2), 
           F is F1 + F2.

/* Ejercicio 6 */

dados(0, 0, []).
dados(P, N, [X|L]):- N > 0,  member(X, [1,2,3,4,5,6]), N1 is N - 1, P1 is P - X, dados(P1, N1, L). 

/* Ejercicio 7 */

sum([], 0).
sum([X|L], P):- sum(L,P1), P is P1 + X.

sumas_dema(L):- append(L1, [X|L2], L), append(L1, L2, L3), sum(L3, X).

/* Ejercicio 8 */

suma_ants(L):- append(L1, [X|_], L), sum(L1,X), !.

/* Ejercicio 9 */

veces_que_aparece(_,[],0).
veces_que_aparece(X, [X|L], P):- veces_que_aparece(X,L,P1), P is P1 + 1, !.
veces_que_aparece(X, [_|L], P):- veces_que_aparece(X,L,P).
   
card(L):- append(_, [X|_], L), veces_que_aparece(X,L,P), append([X],[P], L2), write(L2).

card_in_list(L, List, FinalL):- append(L1, [L|L2], List),
    						append(L1, L2, FinalL).

/* Ejercicio 10 */

esta_ordenada([]):- !.
esta_ordenada([_]):- !.
esta_ordenada([X,Y|L]):- X < Y, esta_ordenada([Y|L]).

/* Ejercicio 11 */

ord(L1,L2):- permutation(L1,L2), esta_ordenada(L2).

/* Ejercicio 12 */

diccionario([],_).
diccionario(A,N):- palabras(A,N,R), myPrint(R), write(' '), fail. 

palabras(_,0,[]):- !.
palabras(A,N,[X|R]):- member(X,A), N1 is N - 1,
                      palabras(A,N1,R).

myPrint([]).
myPrint([X|L]):- write(X), myPrint(L).

/* Ejercicio 13 */

lastElement([Y],Y).
lastElement([_|L],Y):- lastElement(L,Y).

removeLast(L, R):- append(R, [_], L).

palindromos(L):- setof(L2, (permutation(L, L2), isPal(L2)), Res), write(Res).

isPal([]).
isPal([X|L]):- lastElement(L,Y), removeLast(L,R), X = Y, isPal(R).

/* Ejercicio 14 */

send_more_money:- Letters = [S, E, N, D, M, O, R, Y, _, _],
                  Numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                  permutation(Letters, Numbers),
                  Suma is   S * 1000 + M * 1000
                          + E *  100 + O * 100
                          + N *   10 + R * 10
                          + D        + E,
                  Suma is   M * 10000
                          + O * 1000
                          + N * 100
                          + E * 10 
                          + Y,
                  writeLetters(Letters), write("Suma is: "), write(Suma), nl.
writeLetters([S, E, N, D, M, O, R, Y, _, _]):-
            write('S = '), write(S), nl,
            write('E = '), write(E), nl,
            write('N = '), write(N), nl,
            write('D = '), write(D), nl,
            write('M = '), write(M), nl,
            write('O = '), write(O), nl,                                                 
            write('R = '), write(R), nl,
            write('Y = '), write(Y), nl,
            write(' '),write(S), write(' '), write(E), write(' '),  write(N), write(' '), write(D),nl,
            write('+'),write(M), write(' '), write(O), write(' '),  write(R), write(' '), write(E),nl,
            write("--------------"), nl,
            write(M), write(' '), write(O), write(' '),  write(N), write(' '), write(E),write(' '), write(Y),nl.
    
/* Ejercicio 16 */

% a) Te da la cadena donde X es el primer elemento
p([],[]).
p(L,[X|P]) :- select(X,L,R), p(R,P).

dom(L) :- p(L,R), flip(R,P), ok(P), write(P), nl.
dom(_) :- write("no hay cadena"), nl.


% b)

ok([]).
ok([_]).
ok([[_,Y],[Y,Z]|P]):- ok([[Y,Z]|P]).

% c)

flip([],[]).
flip([[X,Y]|L],[[X,Y]|R]):- flip(L,R).
flip([[X,Y]|L],[[Y,X]|R]):- flip(L,R).

/* Ejercicio 18 */

smokers:- Group1 = [S1, SC1, NS1, NSC1], 
          N is S1 + NS1, SC1 < S1, NSC1 < NS1,
          Group2 = [S2, SC2, NS2, NSC2], 
          N is S2 + NS2, SC2 < S2, NSC2 < NS2,
          S1 \= 0, S2 \= 0, NS1 \= 0, NS2 \= 0,
          PSC1 is SC1/S1, PNSC1 is NSC1/NS1, PSC1 > PNSC1,
          PSC2 is SC2/S2, PNSC2 is NSC2/NS2, PSC2 > PNSC2,
          ST is S1 + S2, SCT is SC1 + SC2, NST is NS1 + NS2, NSCT is NSC1 + NSC2,
          PNSCT is NSCT/NST, PSCT is SCT/ST, PNSCT > PSCT,
          write(S1), write(" "),  write(SC1), write(" "),  write(NS1), write(" "),  write(NSC1), write(" "),nl,
          write(S2), write(" "),  write(SC2), write(" "),  write(NS2), write(" "),  write(NSC2), write(" "),nl.

/* Ejercicio 19 */

maq(_,0,_).
maq([X|L],C,[Y|M]):- C1 is X*Y, C1 < C, C2 is C - C1, maq(L,C2,M), fail.

/* Ejercicio 20 */

flatten([],[]):- !.
flatten(X, [X]):- X \= [_|_].
flatten([X|L],F):- flatten(X,L1), flatten(L,L2), append(L1, L2, F).


/* Ejercicio 21 */

log(B,N,L):- between(1,N,L1),X is B ** L1, X > N, L is L1 - 1, !.
