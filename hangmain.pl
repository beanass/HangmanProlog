/* this file handles the main- and word- functions and also the words */
:-style_check(-singleton).
:- consult('input_val.pl').
:- consult('hang_the_man.pl').

%schwiergekeit %grad
category(animals, [cat, dog, crocodile, mouse, lion, tiger, eagle, hedgehog, cattle]).
category(fruits, [ananas, banana, apple, strawberry, cherry, peach]).
category(cities, [cologne, berlin, duesseldorf, bonn, tangier, tokyo, seoul]).
category(pro, [attitude, prolog, interdisciplinary, inconsequential]).

category(all, []).
category_(E):-
    findall(List, category(_, List),L),
    flatten(L,E).

getRandomWord(List, Elt) :- 
    length(List, Len),
    random(0, Len, Rnumber),
    nth0(Rnumber, List, Elt).

getRandomWord([], _) :- !.

start_game :- 
    asserta(hangman(6)),
    ask_difficulty(Difficulty),
    more_difficult(Difficulty),
    ask_category(Guess),
    (Guess = all 
    -> category_(List);
    category(Guess, List)),

    getRandomWord(List, Elt),
    name(Elt, CList),
    code_word(CList, MysteryWord),
    write("Word: "), nl,
    write(MysteryWord), nl,
    write("###### Game Start ######"),nl,
    write("----------------------------"),nl,
    hangman(X),
    while_game(X, Elt, MysteryWord).

while_game(N,Elt, MysteryWord) :- 
    N>0, 
    format('You have ~w attempt ~n', [N]), 
    write("----------------------------"),nl,
    ask_next_char(Char),
    correct_input(Elt, Char, MysteryWord, LetterInMystery, N, K),
    win(K, Elt, MysteryWord, LetterInMystery).

while_game(N,Elt, MysteryWord) :- 
    N=<0, 
    !,
    write("You Loose!"), nl,
    write("word: "), write(Elt).

win(K, Elt, MysteryWord, LetterInMystery) :- 
    Elt = LetterInMystery,
    !,
    write("Congratulation, you won!"),nl,
    write('  (_)'), nl,
    write('  \\|/'), nl,
    write('   |'), nl,
    write('  / \\'), nl.

win(K, Elt, MysteryWord, LetterInMystery)  :-     /*K is N1-1,*/ 
    while_game(K, Elt, LetterInMystery).

correct_input(MysteryWord, Letter, Lnew, LetterInMystery, M,N) :-
    not(check(MysteryWord, Letter)),
    N is M -1,
    LetterInMystery = Lnew,
    hang_the_man, nl,
    write(LetterInMystery),nl.

correct_input(MysteryWord, Letter, Lnew, LetterInMystery, M,N) :-
    check(MysteryWord, Letter),
    name(MysteryWord, L),
    char_code(Letter,X),
    word_guess_indexes(L,  X, I),
    call_replace(I, Lnew, X, List, ListA),
    name(LetterInMystery, ListA),
    N = M,
    write(LetterInMystery),nl.

code_word(CList, MysteryWord) :- 
    maplist(make_mystery, CList, MysteryWordInAscii),
    name(MysteryWord, MysteryWordInAscii).

incr(X, X1) :-
    X1 is X+1.

call_replace([], Lnew, Letter, ListA, ListA):-
    string_to_list(Lnew,ListA),
    !,nl.
   
call_replace([H|T], Lnew, Letter, List, ListA):-
    replace(H, Lnew, Letter, List),
    atom_codes(W, List),
    call_replace(T, W, Letter, List2, ListA).

replace(I, L, E, K) :-
    name(L, InAscii),
    nth0(I, InAscii, _, R),
    nth0(I, K, E, R).

word_guess_indexes(List, Letter, Indexes) :-
    findall(Index, 
            (nth0(Index, List, Element), Element = Letter),
            Indexes).

check(MysteryWord,Letter):-
    char_code(Letter, X),
    name(MysteryWord, MysteryWordInAscii),
    member(X, MysteryWordInAscii).

make_mystery(Ascii, Asterik) :-
  Asterik = 0'*.
