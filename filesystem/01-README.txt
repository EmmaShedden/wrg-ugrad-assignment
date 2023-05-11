                         Micro Filesystem Assignment

(0) This is set up so that there are a number of read-along explanatory demos
    at the beginning that introduce you to a bunch of tools, and then a number
    of challenge problems at the end that use the tools together.

(1) The random/ folder contains a randomly generated set of datafiles.

(2) Shell commands.

        find /path/to/some-directory

    Try "find random" and "find .". This will list all files (recursively) to
    stdout, one file per line.

(3) Shell numeric for loop.

        for ((i=0;i<=100;i++)) ; do echo $i ; done

    Try listing all even numbers between 0 and 200.

(3) Shell string-valued for loop.

        for i in cat dog rat ; do echo $i ; done

(4) Trick:

        for i in random/* ; do echo $i ; done

    Here the shell does "globbing" to expand the wildcard "random/*" into all
    of the relevant files.

(5) The Pipe

    Let's find all filenames in "random" that contain the substrain "ace".

        find random | grep -i ace

    Hyphen i means "case insensitive" -- I recommend using I by default unless
    you're sure you really only want case sensitive. There should be 15
    answers. How can we find that?

(6) The Pipeline

        find random | grep -i ace | wc -l

    wc -l counts the number of lines passed to it. "wc" is wordcount. Other
    options include -c for characters and -w for words. 

(7) Backtick Substitution

    Try these two commands:

        for ((i=0; i<= 15 ; i++)) ; do echo $i ; done

        for ((i=0; i<= `find random | grep -i ace | wc -l` ; i++)) ; do echo $i ; done

    Whenever you have `command-in-backticks`, the shell executes it (right
    now) and then replaces the `command-in-backticks` with the result of
    executing that command. Above we say that "find random | grep -i ace | wc
    -l" prints out the string 15, and here we're using that to get a for-loop
    from 0 to 15.

(8) For Loops On Filesystems

    Suppose I want you to count how big all of these "ace" files are. Let's
    iterate through all of the "ace" files and apply "wc" to them.

        for i in `find random/ | grep -i ace` ; do wc $i ; done

    Note that we could also have done

        wc `find random/ | grep -i ace`

    Notice that one of the files is actually a directory and not a textfile.

(9) Finding All Files With An Extension

    Suppose we want to find all 8 files that end with the ".ac" extension.
    Note that we only want extensions -- not the 105 files that contain "ac"
    somewhere in their filepath.

        find random | grep -i \\.ac

    We can't just say ".ac" because "." has special meaning in regular
    expressions: it means "any character except a newline". So we want to
    escape the dot with a backslash. But because the shell will see it once
    and then grep will see it, we double-escape it. This is a very common
    pattern.

(10) Basename

    Suppose I want to find all the "*.ac" files and copy them into the current
    directory.

        $ basename path/to/a.b
        a.b
        $ dirname path/to/a.b
        path/to

      for i in `find random/ | grep -i \\.ac` ; do cp $i `basename $i`.backup ; done
      ls

    The opposite of basename is dirname. Remove all those ".backup" copies.

(11) Renaming Exetensions with Basename

    Suppose we want to take all of those ".ac" files and move them to the
    current directory, but rename them to ".wes".

        $ basename path/file.ext .ext
        file

    for i in `find random/ | grep -i \\.ac` ; do cp $i `basename $i .ac`.wes ;
    done

(12) "cut"

    Suppose we want to get a column out of a textual data file:

        $ cat random/1948483d.f6
        97,89,99,18,54,1,51,9,68
        97,21,17,95,90,18,58,30,192
        3,60,78,96,46,12,22,40,161
        90,40,33,19,18,26,52,77,19
        28,12,88,33,34,28,74,10,126
        63,0,32,9,76,26,70,8,7
        65,19,29,60,8,70,10,46,103
        94,25,74,36,23,2,82,91,40
        20,53,46,80,59,22,20,7,116
        87,36,48,40,60,13,55,12,185
        89,38,58,91,27,35,2,86,9
        4,45,67,48,5,29,72,26,143
        29,85,2,45,47,44,18,50,82

        $ cut -d , --fields=1-3 random/1948483d.f6
        97,89,99
        97,21,17
        3,60,78
        90,40,33
        28,12,88
        63,0,32
        65,19,29
        94,25,74
        20,53,46
        87,36,48
        89,38,58
        4,45,67
        29,85,2

        $ cut -d , --fields=2 random/1948483d.f6
        89
        21
        60
        40
        12
        0
        19
        25
        53
        36
        38
        45
        85

(13) [ removed, not helpful ]

(14) shell if --- file exists

        $ if [ -f 01-README.txt ] ; then echo yes ; else echo no ; fi
        yes

    General syntactical form:  

        if [ -f __FILE__ ] ; then __COMMANDS__ ; else __COMMANDS__ ; fi

    You can also do -d for "directory exists":

        $ if [ -d 01-README.txt ] ; then echo yes ; else echo no ; fi
        no
        $ if [ -d random ] ; then echo yes ; else echo no ; fi
        yes

    "[" is actually a synonym for "test". type

        $ help test

    To see a list of things you can check for.

(15) shell if --- arbitrary predicates

    Officially, in shell "if", if the predicate returns 0 we execute the then
    branch. If the predicate returns anything else (typically 1), we execute
    the else branch.

    Unix shell utilities have a standard: on success they return zero and on
    failure they return something else. You can inspect the last return value
    in the variable $?.

    $ wc 01-README.txt
    246  935 6301 01-README.txt
    $ echo $?
    0                   // (success)

    $ wc random/
    wc: random/: Is a directory
    0       0       0 random/
    $ echo $?
    1                   // (failure )

    So you can do something like

    $ if wc random ; then echo yes ; else echo no fi ;
    wc: random: Is a directory
    0       0       0 random
    no

    Note that we saw the output of wc, which is potentially annoying, but this
    general form will allow us to use things like "grep" as a predicate.

(16) output redirection

    Unix commands output normal results to "standard output" and warnings to
    "standard error output". These are typically just called "stdout" and
    "stderr". You can redirect those to go to files instead of the screen.
   

    $ wc random > normal-output-file 2> error-output-file
    $ ls *output-file*
    error-output-file  normal-output-file
    $ cat normal-output-file
    0       0       0 random
    $ cat error-output-file
    wc: random: Is a directory

    You can also redirect both stdout and stderr to the same file:

    $ wc random >& both-output
    $ cat both-output
    wc: random: Is a directory
    0       0       0 random

    There is a special file, called /dev/null, that is a sink for
    data. Redirecting something to /dev/null means "throw it away".

    $ grep shell 01-README.txt > /dev/null
    $ echo $?
    0                   // (success: we found the string "shell")

(17) >>append

        $ cat some-file
        cat: some-file: No such file or directory
        $ echo line-1 >> some-file
        $ echo line-2 >> some-file
        $ cat some-file
        line-1
        line-2

    "foo > my-file" executes foo and overwrites "my-file" with its stdout. By
    contrast, >> appends to an existing file.

(18) sort and uniq

    sort exists. You can either pipe things to it or give it the name of a
    file as its argument. "sort" for alpha-sort, "sort -g" for general
    numeric.  You can also tell sort to sort on another column (you give it
    the column separator character, etc.) -- $ man sort for details.

        $ cat random/1948483d.f6
        97,89,99,18,54,1,51,9,68
        97,21,17,95,90,18,58,30,192
        3,60,78,96,46,12,22,40,161
        90,40,33,19,18,26,52,77,19
        28,12,88,33,34,28,74,10,126
        63,0,32,9,76,26,70,8,7
        65,19,29,60,8,70,10,46,103
        94,25,74,36,23,2,82,91,40
        20,53,46,80,59,22,20,7,116
        87,36,48,40,60,13,55,12,185
        89,38,58,91,27,35,2,86,9
        4,45,67,48,5,29,72,26,143
        29,85,2,45,47,44,18,50,82

        $ sort random/1948483d.f6
        20,53,46,80,59,22,20,7,116
        28,12,88,33,34,28,74,10,126
        29,85,2,45,47,44,18,50,82
        3,60,78,96,46,12,22,40,161
        4,45,67,48,5,29,72,26,143
        63,0,32,9,76,26,70,8,7
        65,19,29,60,8,70,10,46,103
        87,36,48,40,60,13,55,12,185
        89,38,58,91,27,35,2,86,9
        90,40,33,19,18,26,52,77,19
        94,25,74,36,23,2,82,91,40
        97,21,17,95,90,18,58,30,192
        97,89,99,18,54,1,51,9,68

        $ sort -g random/1948483d.f6
        3,60,78,96,46,12,22,40,161
        4,45,67,48,5,29,72,26,143
        20,53,46,80,59,22,20,7,116
        28,12,88,33,34,28,74,10,126
        29,85,2,45,47,44,18,50,82
        63,0,32,9,76,26,70,8,7
        65,19,29,60,8,70,10,46,103
        87,36,48,40,60,13,55,12,185
        89,38,58,91,27,35,2,86,9
        90,40,33,19,18,26,52,77,19
        94,25,74,36,23,2,82,91,40
        97,21,17,95,90,18,58,30,192
        97,89,99,18,54,1,51,9,68

    If you have a sorted file, "uniq" will filter out duplicates:

        $ cat some-file
        1
        1
        2
        3
        3
        3
        4
        $ uniq some-file
        1
        2
        3
        4




                              Now It's Your Turn

    Time to do these exercises. Write down the commands you used. In each of
    these, one line may be more than 80 characters, but should not be more
    than 160 characters. You're welcome to create temporary files.

(1)  (one line)

        How many lines, total, are in all (text) files in the random/
        filesystem?

(2)  (one line)

        How many characters, total, are in all text files under
        random/ca0255e/

(3) (one line)

        Output to the screen the names of all files in the random/ filesystem
        that contain (inside them, not in their names) the string "190".

(4) (one line)

        Make a text file called "unique-first-column-values" such that each
        line in it corresponds to a value that occurs in the first column
        position in one of the files in random/.
       
        For example, if the only file in random looked like this:

        89,38,58,91,27,35,2,86,9
        97,21,17,95,90,18,58,30,192
        63,0,32,9,76,26,70,8,7
        29,85,2,45,47,44,18,50,82
        94,25,74,36,23,2,82,91,40
        90,40,33,19,18,26,52,77,19
        20,53,46,80,59,22,20,7,116
        65,19,29,60,8,70,10,46,103
        97,89,99,18,54,1,51,9,68
        28,12,88,33,34,28,74,10,126
        4,45,67,48,5,29,72,26,143
        87,36,48,40,60,13,55,12,185
        3,60,78,96,46,12,22,40,161

        The output might be
        3
        4
        20
        28
        29
        63
        65
        87
        79
        90
        94
        97

        (note 97 only appears once)

(5) (one line)

        How many files in the random/ filesystem contain the string "54,1" ?

(6) (one line)

        Make a text file called "unique-first-column-values-if-54,1" such that
        each line in it corresponds to a value that occurs in the first column
        position in of a files in random/ *that contains 51,4*.
       
        This is just like (18), but only inclue first column values from file
        contents that contain the substring 51,4.

(7) (one line)

        How many characters (bytes) total are taken up by files in the random/
        filesystem that have an extension between .30 and .39 (i.e.,
         \\.3[0-9] ) and that also contain the substring 51,4 ?

(8) (one line)

        Make a file called "big-1,2,3" that contains all text lines
        containing the substring "1,2,3" inside all files in the random/
        filesystem.

        Hint: this line will appear in big-1,2,3:
        39,11,4,22,31,71,2,36,170
        ... it originally comes from random/ca0255e/2436c0e6.8d .

(9) (thought question -- prepare for in-person meeting)

        How would you compute the *AVERAGE* first-column value in the set of
        all files in the random/ filesystem?

(10) (thought question -- prepare for in-person meeting)

        How would you emit a *RANKED* list of files in the random/
        filesystem, ordered by the numerical value of the first column
        in the first line?

(11) Ask in person about: 

        fork, wait, nice, time, top, ...
