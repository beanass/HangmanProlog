
start_game(X).

%schwiergekeit %grad 
category(animals, [cat, dog, crocodile]).
category(cities, [cologne, berlin, duesseldorf, bonn, tangier, tokyo]).

getRandomWord(List, Elt) :- 
    length(List, Len),
    random(0, Len, Rnumber),
    nth0(Rnumber, List, Elt).

getRandomWord([], _) :- !.


word_to_guess :- 
    write('Which Category should be the Word: '),
    write(' animals '), write('or cities'), nl,
    read(Guess),
    write(Guess), nl,
    category(Guess, List),
    getRandomWord(List, Elt),
    write(Elt), nl,
    name(Elt, CList),
    write(CList),nl,
    code_word(CList, MysteryWord),
    write(MysteryWord), nl,
    write("###### Game Start ######"),nl,
    write("----------------------------"),
    while_game(6, Elt, MysteryWord).


while_game(N,Elt, MysteryWord) :- 
    N>0, 
    format('You have ~w attempt ~n', [N]), 
    write("----------------------------"),nl,
    write("##### Enter a Character : #####"), nl,
    read(Char),nl,
    correct_input(Elt, Char, MysteryWord, LetterInMystery, N, K),
    /*K is N1-1,*/ 
    while_game(K, Elt, LetterInMystery).

while_game(N,Elt, MysteryWord) :- 
    N<=0, 
    !.


correct_input(MysteryWord, Letter, Lnew, LetterInMystery, M,N) :-
    not(check(MysteryWord, Letter)),
    N is M -1,
    LetterInMystery = Lnew,
    write("Wrong Character"), nl,
    write(LetterInMystery),nl.


correct_input(MysteryWord, Letter, Lnew, LetterInMystery, M,N) :-
    check(MysteryWord, Letter),
    name(MysteryWord, L),
    char_code(Letter,X),
    indexOf(L,  X, I),
    /*write('Index is '), write(I),nl,*/
    replace(I, Lnew, X, Lnew_),
    name(LetterInMystery, Lnew_),
    N = M,
    /*incr(M,N),*/
    write(LetterInMystery),nl.


code_word(CList, MysteryWord) :- 
    maplist(make_mystery, CList, MysteryWordInAscii),
    name(MysteryWord, MysteryWordInAscii).

incr(X, X1) :-
    X1 is X+1.


replace(I, L, E, K) :-
    name(L, InAscii),
    nth0(I, InAscii, _, R),
    nth0(I, K, E, R).


/*
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).
*/

%Index of Element in a List
indexOf([Element|_], Element, 0).

indexOf([_|Tail], Element, Index) :- 
    indexOf(Tail, Element, Index1),
    Index is Index1 + 1. 

check(MysteryWord,Letter):-
    char_code(Letter, X),
    name(MysteryWord, MysteryWordInAscii),
    member(X, MysteryWordInAscii).


make_mystery(Ascii, Asterik) :-
  Asterik = 0'*.
