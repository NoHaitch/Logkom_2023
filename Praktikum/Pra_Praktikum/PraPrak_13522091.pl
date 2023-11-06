/*  Nama : Raden Francisco Trianto Bratadiningrat
    NIM : 13522091
*/

/* File .pl */

/* Bagian <X> */
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
saudara(X, Y) :- pria(X), pria(Y), X \= Y, anak(X, Parent), anak(Y, Parent).
saudara(X, Y) :- pria(X), wanita(Y), X \= Y, anak(X, Parent), anak(Y, Parent).
saudara(X, Y) :- wanita(X), pria(Y), X \= Y, anak(X, Parent), anak(Y, Parent).
saudara(X, Y) :- wanita(X), wanita(Y), X \= Y, anak(X, Parent), anak(Y, Parent).
    
/* saudaratiri(X, Y) : X adalah saudara tiri dari Y */
saudaratiri(X, Y) :- pria(X), pria(Y), X \= Y, anak(X, Parent1), anak(Y, Parent2), Parent1 = Parent2, menikah(Parent1, Pasangan1), menikah(Parent1, Pasangan2), Pasangan1 \= Pasangan2, anak(X, Pasangan1), anak(Y, Pasangan2).
saudaratiri(X, Y) :- pria(X), wanita(Y), X \= Y, anak(X, Parent1), anak(Y, Parent2), Parent1 = Parent2, menikah(Parent1, Pasangan1), menikah(Parent1, Pasangan2), Pasangan1 \= Pasangan2, anak(X, Pasangan1), anak(Y, Pasangan2).
saudaratiri(X, Y) :- wanita(X), pria(Y), X \= Y, anak(X, Parent1), anak(Y, Parent2), Parent1 = Parent2, menikah(Parent1, Pasangan1), menikah(Parent1, Pasangan2), Pasangan1 \= Pasangan2, anak(X, Pasangan1), anak(Y, Pasangan2).
saudaratiri(X, Y) :- wanita(X), wanita(Y), X \= Y, anak(X, Parent1), anak(Y, Parent2), Parent1 = Parent2, menikah(Parent1, Pasangan1), menikah(Parent1, Pasangan2), Pasangan1 \= Pasangan2, anak(X, Pasangan1), anak(Y, Pasangan2).
    
/* kakak(X, Y) : X adalah kakak dari Y (kakak kandung maupun tiri) */
kakak(X, Y) :-
    saudara(X, Y),
    usia(X, UsiaX),
    usia(Y, UsiaY),
    UsiaX > UsiaY.

/* keponakan(X, Y) : X adalah keponakan dari Y */
keponakan(X, Y) :- 
    X \= Y, 
    anak(X, Parent1), 
    saudara(Parent1, UncleAunt), 
    anak(Y, UncleAunt).

/* mertua(X, Y) : X adalah mertua dari Y */
mertua(X, Y) :- 
    anak(Y, Parent1),
    anak(Y, Parent2),
    Parent1 \= Parent2,
    menikah(X, Parent1),
    \+ anak(Y, X).

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
    \+ menikah(X, Y),
    \+ menikah(Y, X).
lajang(X) :- 
    wanita(X),
    \+ menikah(X, Y),
    \+ menikah(Y, X).

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