/* this file handles the userinput and verifies them. */

ask_difficulty(Difficulty):-  
    write('Choose the difficulty: '),nl,
    write('0: easy'), nl,
    write('1: medium'), nl,
    write('2: hardcore'), nl,
    read(TempDifficulty),
    (   between(0,2,TempDifficulty)
        ->  Difficulty = TempDifficulty,
            write('Difficulty choosen.'), nl
        ;   write('Input invalid. Enter valid number.'), nl,
            ask_difficulty(Difficulty)
    ).

ask_category(Category):-  
    write('Which Category should be the Word: '),
    write(' animals '), write('or cities'), write(' or fruits'),write(' or pro'), write(' or all'), nl,
    read(TempCategory),
    (   category(TempCategory,_)
        ->  Category = TempCategory
        ;   write('Input invalid. Enter valid category.'), nl,
            ask_category(Category)
    ).

ask_next_char(Char):-  
    write("##### Enter a Character : #####"),nl,
    read(TempChar),
    (   atom_length(TempChar, 1)
        ->
            (char_type(TempChar, alpha)
            ->  Char = TempChar
            ;   writeln('Input invalid, please enter a Char.'), 
            ask_next_char(Char))
        ;   writeln('Input invalid, please enter a Char.'), 
            ask_next_char(Char)
    ).
