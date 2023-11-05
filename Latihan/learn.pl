% Basis faktorial
faktorial(0, 1).

% Rules
faktorial(X, Y) :- 
    X > 0,
    Xnew is (X - 1),
    faktorial(Xnew, Res),
    Y is (X * Res).   

p(0, positif).

p(N, positif) :- 
    N > 0,
    N1 is (N - 1),
    p(N1, positif).

p(N, negatif) :-
    \+ (p(N, positif)).

% p gagal karena saat N = -1, maka N1 = (-1 - 1), p(-2, positif)
% tidak pernah berhenti
% untuk menyelesaikan masalah, perlu ditambah persyaratan untuk 
% p(N, positif) :- N > 0

main:-
   open('mahasiswa.txt',read,Str),
   read_mahasiswa(Str,Mahasiswa),
   close(Str),
   write(Mahasiswa), nl.

read_mahasiswa(Stream,[]):-
   at_end_of_stream(Stream).

read_mahasiswa(Stream,[X|L]):-
   \+ at_end_of_stream(Stream),
   read(Stream,X),
   read_mahasiswa(Stream,L).


number_of_parents(adam, Z) :- !, Z=0.
number_of_parents(hawa, Z) :- !, Z=0.
number_of_parents(X, 2).
count(Z,V) :- V is Z. 