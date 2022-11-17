
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
    write(CList),
    code_word(CList, MysteryWord),
    write(MysteryWord).


code_word(CList, MysteryWord) :- 
    maplist(make_mystery, CList, MysteryWordInAscii),
    name(MysteryWord, MysteryWordInAscii).

correct_input(MysteryWord, Letter) :-
    check(MysteryWord, Letter),
    name(MysteryWord, L),
    char_code(Letter,X),
    indexOf(L,  X, I),
    write('Index is '), write(I). 




sub_string(MysteryWord, N, Len, M, Letter).





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
