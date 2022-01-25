:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.

%Some helpful predicates:

word( [b,a,k,e] ).

num(X,N):- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).

main:-
    length(D1,6),
    length(D2,6),
    length(D3,6),
    length(D4,6),
    
    %1. Domain:
    
    D1 ins 1 .. 24,
    D2 ins 1 .. 24,
    D3 ins 1 .. 24,
    D4 ins 1 .. 24,
    append(D1, D2, L1),
    append(L1, D3, L2),
    append(L2, D4, L),
    all_different(L),
    
    %2. Constraints:
    
    findall(W, word(W), Words),
    cumple(Words,D1,D2,D3,D4),
    
    %3. Labeling:
    
    label(L),
    
    
    writeN(D1), 
    writeN(D2), 
    writeN(D3), 
    writeN(D4), halt.
    
notEquals([X|D1],D2,D3,D4):- not(member(X,D1)), not(member(X,D2)), not(member(X,D3)), not(member(X,D4)), notEquals(D1,D2,D3,D4).

notEqualss([]).
notEqualss([X|L]):- not(member(X,L)), notEqualss(L).

cumple([W|Words], D1, D2, D3, D4):-
  correcto(W, D1),
  correcto(W, D2),
  correcto(W, D3),
  correcto(W, D4),
  cumple(Words, D1, D2, D3, D4).
cumple([],_,_,_,_).

correcto([W1, W2, W3, W4], [D1,D2,D3,D4,D5,D6]):-
  num(W1, NW1),
  num(W2, NW2),
  num(W3, NW3),
  num(W4, NW4),
  comparaciones(D1,D2,D3,D4,D5,D6,NW1,NW2,NW3,NW4),!.
  
comparaciones(D1,D2,D3,D4,D5,D6,W1,W2,W3,W4):-
	D1 #= W1 #\/ D1 #= W2 #\/ D1 #= W3 #\/ D1 #= W4 #\/
	D2 #= W1 #\/ D2 #= W2 #\/ D2 #= W3 #\/ D2 #= W4 #\/
	D3 #= W1 #\/ D3 #= W2 #\/ D3 #= W3 #\/ D3 #= W4 #\/
	D4 #= W1 #\/ D4 #= W2 #\/ D4 #= W3 #\/ D4 #= W4 #\/
	D5 #= W1 #\/ D5 #= W2 #\/ D5 #= W3 #\/ D5 #= W4 #\/
	D6 #= W1 #\/ D6 #= W2 #\/ D6 #= W3 #\/ D6 #= W4.
  
writeN(D):- findall(X,(member(N,D),num(X,N)),L), write(L), nl, !.
