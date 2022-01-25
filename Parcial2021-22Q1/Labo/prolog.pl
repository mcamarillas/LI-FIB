
% Complete the following two predicates in prolog.

% 1.
% nthRoot( N, K, R ) === "Given positive integers N and K,  the integer part of the Nth root of K is R".
% Example: the integer part of the 2th root (square root) of 16 is 4.
% Example: the integer part of the 3rd root (cubic root)  of  8 is 2.
% Example: the integer part of the 4th root               of 16 is 2.
% Example: the integer part of the 4th root               of 15 is 1.

nthRoot( N, K, R ):-  between(1, K, R1), X is R1 ** N, X > K, R is R1 - 1, !.
		      



% 2.     
% allSSSS(L) (allSquareSummingSubSequences) ===
%     "Given a sequence of positive integers L, write all non-empty subsequences of L whose sum is a perfect
%     square, in the following format":
% ?-allSSSS([6,3,4,5,6,9,8,5,2,3,4]).
% 9-[6,3]
% 49-[3,4,5,6,9,8,5,2,3,4]
% 4-[4]
% 9-[4,5]
% 9-[9]
% 9-[2,3,4]
% 4-[4]

subcjt([],[]).
subcjt([_|L],S):-subcjt(L,S).
subcjt([X|L],[X|S]):-subcjt(L,S).

subseq([],[]).
subseq([X|L],[X|S]):-subseq(L,S).

isPerfect(N, K):- between(1, K, K1), X is K1 ** N, X = K, !.
perfect(K):- between(2 ,K, N1), isPerfect(N1,K), !.

sumAll([], 0).
sumAll([X|L], P):- sumAll(L,P1), P is P1 + X.

allSSSS(L):-  subcjt(L, SS), sumAll(SS,Sum), perfect(Sum), write(Sum-SS), nl, fail.

