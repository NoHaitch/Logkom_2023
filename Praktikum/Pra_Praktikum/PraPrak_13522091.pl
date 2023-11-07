/*  Nama : Raden Francisco Trianto Bratadiningrat
    NIM : 13522091
*/

/* PraPrak_13522091 .pl */

/* Bagian I */
/* Deklarasi Fakta */
    /* Pria */
    pria(athif).
    pria(bagas).
    pria(daniel).
    pria(dillon).
    pria(fio).
    pria(hanif).
    pria(henri).
    pria(michael).
    pria(robert).
    pria(rupert).
 
    /* Wanita */
    wanita(ana).
    wanita(elysia).
    wanita(emma).
    wanita(jena).
    wanita(jeni).
    wanita(joli).
    wanita(margot).

    /* Usia */
    usia(ana, 23).
    usia(athif, 60).
    usia(bagas, 29).
    usia(daniel, 7).
    usia(dillon, 63).
    usia(elysia, 500).
    usia(emma, 6).
    usia(fio, 30).
    usia(hanif, 47).
    usia(henri, 48).
    usia(jena, 27).
    usia(jeni, 28).
    usia(joli, 58).
    usia(margot, 43).
    usia(michael, 28).
    usia(robert, 32).
    usia(rupert, 6).

    /* Menikah */
    menikah(athif, joli).
    menikah(joli, athif).
    menikah(dillon, elysia).
    menikah(elysia, dillon).
    menikah(henri, margot).
    menikah(margot, henri).
    menikah(fio, jena).
    menikah(jena, fio).
    menikah(fio, jeni).
    menikah(jeni, fio).
    
    /* Anak */
    anak(michael, athif).
    anak(michael, joli).
    anak(margot, athif).
    anak(margot, joli).
    anak(robert, henri).
    anak(robert, margot).
    anak(bagas, henri).
    anak(bagas, margot).
    anak(jena, henri).
    anak(jena, margot).
    anak(daniel, fio).
    anak(daniel, jena).
    anak(rupert, fio).
    anak(rupert, jena).
    anak(hanif, dillon).
    anak(hanif, elysia).
    anak(jeni, hanif).
    anak(ana, hanif).
    anak(emma, fio).
    anak(emma, jeni).

/* Deklarasi Rules */
/* saudara(X, Y) : X adalah saudara kandung maupun tiri dari Y */
saudara(X, Y) :- 
    anak(X, Parent), 
    anak(Y, Parent), X \= Y.
    
/* saudaratiri(X, Y) : X adalah saudara tiri dari Y */
saudaratiri(X, Y) :- 
    anak(X, Parent1), 
    anak(Y, Parent2), 
    X \= Y, 
    Parent1 = Parent2, 
    menikah(Parent1, Pasangan1), 
    menikah(Parent1, Pasangan2), 
    Pasangan1 \= Pasangan2, 
    anak(X, Pasangan1), 
    anak(Y, Pasangan2).

/* kakak(X, Y) : X adalah kakak dari Y (kakak kandung maupun tiri) */
kakak(X, Y) :-
    saudara(X, Y),
    usia(X, UsiaX),
    usia(Y, UsiaY),
    UsiaX > UsiaY.

/* keponakan(X, Y) : X adalah keponakan dari Y */
keponakan(X, Y) :- 
    anak(X, Z),
    saudara(Z, Y).

/* mertua(X, Y) : X adalah mertua dari Y */
mertua(X, Y) :- 
    menikah(Y, Pasangan1),
    anak(Pasangan1, X).

/* nenek(X, Y) : X adalah nenek dari Y */
nenek(X, Y) :- 
    wanita(X), 
    anak(Parent, X),
    anak(Y, Parent).

/* keturunan(X, Y) : X adalah keturunan dari Y (anak, cucu, dan seterusnya) */
keturunan(X, Y) :- 
    anak(X, Y).
keturunan(X, Y) :-
    anak(X, Parent),
    keturunan(Parent, Y).

/* lajang(X) : X adalah orang yang tidak menikah */
lajang(X) :- 
    pria(X),
    \+ menikah(X, _).
lajang(X) :- 
    wanita(X),
    \+ menikah(X, _).

/* anakbungsu(X) : X adalah anak paling muda */
anakbungsu(X) :- pria(X), \+ saudara(X, _).
anakbungsu(X) :- wanita(X), \+ saudara(X, _).
anakbungsu(X) :- saudara(X, _), \+ (saudara(Y, _), \+ (X = Y, kakak(Y, X))).

/* yatimpiatu(X) : X adalah orang yang orang tuanya tidak terdefinisi */
yatimpiatu(X) :- 
    pria(X),
    \+ anak(X, _).
yatimpiatu(X) :- 
    wanita(X),
    \+ anak(X, _).


/* Bagian II : Rekursivitas */

/* Exponent */
% basis
exponent(A, 0, X) :-
    A > 0,
    X is 1.
% aturan
exponent(A, B, X) :-
    B > 0,
    B1 is (B - 1),
    exponent(A, B1, X1),
    X is (A * X1).

/* Population */
population(P, R, T, C, Result) :-
    InitialC is (T),
    populationRecursion(P, R, T, C, InitialC, Result).
% dibutuhkan parameter tambahan yaitu InitialC
populationRecursion(P, _, 0, _, _, P).
populationRecursion(P, R, T, C, InitialC, Result) :- 
    T > 0,
    NextT is (T - 1),
    NextC is (C - 1),
    populationRecursion(P, R, NextT, NextC, InitialC, X),
    (0 is (T mod 2) -> Result is ((X * R) - (InitialC + C)); Result is ((X * R) + (InitialC + C))).

/* Perrin */
% basis
perrin(0, X) :- X is 3.
perrin(1, X) :- X is 0.
perrin(2, X) :- X is 2.

% aturan
perrin(N, X) :- 
    N > 2,
    N1 is (N - 2),
    N2 is (N - 3),
    perrin(N1, X1),
    perrin(N2, X2),
    X is (X1 + X2).

/* HCF */
% basis
hcf(A, 0, X) :- A > 0, X is A.

% aturan
hcf(A, B, X) :- 
    B > 0,
    X1 is (A mod B),
    hcf(B, X1, X).
    
/* Make Pattern */
makePattern(N) :-
    between(1, N, I), % for i in range(1, N+1)
    makeRow(I, N),
    nl, % new line for every row
    flush_output, % flush output so nl works
    fail. % force backtrack
makePattern(_). % terminasi fungsi

makeRow(I, N) :-
    between(1, N, J), % for j in range(1, N+1)
    Depth is (min(min(I, J), min(N - I + 1, N - J + 1)) - 1), % pola tulisan
    write(Depth), % tampilkan ke layar
    fail. % force backtrack
makeRow(_, _). % terminasi fungsi


/* Bagian III : List */
/* note : H = Head */
/*        T = Tail */

/* List Statistic */
/* comparison */
lessthan(A, B, A) :- A =< B.
lessthan(A, B, B) :- A > B.
greaterthan(A, B, A) :- A >= B.
greaterthan(A, B, B) :- A < B.

/* min */
% basis
min([Min], Min).
% aturan
min([H | T], Min) :- 
    min(T, Tmp),
    lessthan(H, Tmp, Min).

/* max */
% basis
max([Max], Max).
% aturan
max([H | T], Max) :- 
    max(T, Tmp),
    greaterthan(H, Tmp, Max).

/* range */
% basis
range([Range], Range).
% aturan
range([H | T], Range) :- 
    min([H | T], Min),
    max([H | T], Max),
    Range is Max - Min.

/* count */
% basis
count([], 0).
% aturan
count([_ | T], Count) :- 
    count(T, Tmp),
    Count is Tmp + 1.

/* sum */
% basis
sum([], 0).
% aturan
sum([H | T], Sum) :- 
    sum(T, Tmp),
    Sum is Tmp + H.

/* List Manipulation */
/* get index */
% basis
getIndex([H | _], H, 1).
% aturan
getIndex([_ | T], Elmt, Result) :- 
    getIndex(T, Elmt, Tmp),
    Result is Tmp + 1.

/* get element */
% basis
getElement([H | _], 1, H).
% aturan
getElement([_ | T], Idx, Result) :- 
    Idx > 1,
    Idx1 is Idx - 1,
    getElement(T, Idx1, Result).

/* swap */
% basis
setElement([_ | T], 1, Elmt, [Elmt | T]).
% aturan
setElement([H | T], Idx, Elmt, [H | Result]) :- 
    Idx > 1,
    Idx1 is Idx - 1,
    setElement(T, Idx1, Elmt, Result).

swap(List, Idx1, Idx2, Result) :- 
    getElement(List, Idx1, Tmp1),
    getElement(List, Idx2, Tmp2),
    setElement(List, Idx1, Tmp2, Tmp),
    setElement(Tmp, Idx2, Tmp1, Result).

/* slice */
% basis
slice(_, Start, End, []) :- 
    Start >= End.

slice([], _, _, []).

slice([H | T], 1, End, [H | Result]) :- 
    End > 0,
    NewIdx is End - 1,
    slice(T, 1, NewIdx, Result).


slice([_ | T], Start, End, Result) :- Start > 1,
    End1 is End - 1,
    Start1 is Start - 1,
    slice(T, Start1, End1, Result).

/* sort */
/* find minimum of list, add to last position of Result*/
% basis
sortList([LastElmt], LastElmt).

% aturan
sortList([H | T], Result) :- 
    min(T, Min), 
    H =< Min,
    sortList(T, Tmp),
    Result = [H | Tmp].

sortList([H | T], Result) :- 
    min(T, Min),
    H > Min,
    getIndex(T, Min, Index),
    setElmt(T, Index, H, Tmp),
    sortList(Tmp, Result1),
    Result = [Min | Result1].


/* Bonus */
start :- 
    retractall(secret_number(_)),
    retractall(score(_)),
    asserta(score(0)),
    generateSecretNumber,
    write('Welcome to Number Guesser Prolog!'), nl,
    write('Guess a Number between 1 to 100.'), nl,
    displayScore.

generateSecretNumber :-
    random(1, 101, Secret),
    asserta(secret_number(Secret)).
    
displayScore :-
    score(CurrentScore),
    write('Score: '), write(CurrentScore), nl.

scorePlus :-
    score(CurrentScore),
    NewScore is (CurrentScore + 10),
    retractall(score(_)),
    asserta(score(NewScore)).

scoreMinus :-
    score(CurrentScore),
    NewScore is (CurrentScore - 1),
    retractall(score(_)),
    asserta(score(NewScore)).

guess(X) :-
    clause(secret_number(_), _),
    secret_number(Secret),
    X = Secret,
    write('Correct.'), nl,
    scorePlus,
    displayScore.

guess(X) :-
    X > 0, X < 101,
    clause(secret_number(_), _),
    secret_number(Secret),
    X > Secret,
    write('Too Large.'), nl,
    scoreMinus,
    displayScore.

guess(X) :-
    X > 0, X < 101,
    clause(secret_number(_), _),
    secret_number(Secret),
    X < Secret,
    write('Too Small.'), nl,
    scoreMinus,
    displayScore.

guess(X) :-
    X < 1,
    clause(secret_number(_), _),
    write('Guess a Number between 1 to 100!').

guess(X) :-
    X > 100,
    clause(secret_number(_), _),
    write('Guess a Number between 1 to 100!').

reset :-
    clause(secret_number(_), _),
    secret_number(Secret),
    score(CurrentScore),
    write('Secret Number is '), write(Secret), nl,
    write('Score: '), write(CurrentScore), nl,
    write('resetting the game..'), nl, nl,
    start.

exit :-
    clause(secret_number(_), _),
    write('Thank you for Playing!'), nl,
    retractall(secret_number(_)),
    retractall(score(_)).