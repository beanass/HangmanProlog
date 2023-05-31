# Hangman with Prolog
Hangman is a game, where the user has several tries to guess a word letter by letter.

To play hangman:

    - Consult the file "hangmain.pl"
    - Enter "start_game."
    - Choose the difficulty entering an integer according to the output of the console. The Difficulty will influence the ammount of tries.
    - Choose the category of the word entering a string according to the output of the console. The randomly chosen word, needs to be guessed.

To extend the words, add words to the category lists in "hangmain.pl".
To extend the categories, add a new category in "hangmain.pl" and edit the output from "ask_category(Category)" in "input_val.pl"
