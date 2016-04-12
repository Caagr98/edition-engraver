\version "2.19.37"
\include "edition-engraver.ily"

\addEdition test

\editionMod test 2 0/4 sing.with.bach.along.Voice.B \once \override NoteHead.color = #red

\editionMod test 2 2/4 sing.with.bach.along.Voice.B \override NoteHead.color = #green
\editionMod test 2 3/4 sing.with.bach.along.Voice.B \override NoteHead.color = #blue
\editionMod test 3 1/4 sing.with.bach.along.Voice.B \revert NoteHead.color
% TODO how to enter this?
\editionMod test 5 0/4 sing.with.bach.along.Voice.#(string->symbol "1") \revert NoteHead.color

\editionMod test 13 3/8 sing.with.bach.along.Voice.C \once \override NoteHead.color = #red


\editionModList test sing.with.bach.Score \break #'(5 9 13 17)

\editionMod test 2 2/4 sing.with.bach.along.Staff \clef "alto"
\editionMod test 3 2/4 sing.with.bach.along.Staff \clef "G"
\editionMod test 5 0/4 sing.with.bach.along.Staff \bar ".|:-||"

\editionMod test 5 1/4 sing.with.bach.along.Staff ^"Hallo"

\editionMod test 9 0/4 sing.with.bach.Score \mark \default
\editionMod test 10 0/4 sing.with.bach.Score \mark \markup \bold "Tach"
\editionMod test 11 0/4 sing.with.bach.Score \mark \default
\editionMod test 17 0/4 sing.with.bach.Score \mark 4

\editionModMarked test Tach 6/4 sing.with.bach.along.Staff \once \override NoteHead.color = #(rgb-color .8 .6 .3)
\editionModMarked test 2 3/8 sing.with.bach.along.Staff \once \override NoteHead.color = #(rgb-color .8 .6 .3)
\editionModMarked test 2 4/8 sing.with.bach.along.Staff \once \override NoteHead.color = #(rgb-color .8 .6 .3)
% overrides are not applied on moment 0 after mark! (TODO!)
\editionModMarked test Blupp 0/8 sing.with.bach.along.Staff \once \override NoteHead.color = #(rgb-color .8 .6 .3)

% "Install" the edition-engraver in a number of contexts.
% The order is not relevant,
% Dynamics is not used in this example, Foo triggers an oll:warn
\consistEE Score.Staff.Voice

\layout {
  \context {
    \Score
    \editionID ##f sing.with.bach
    %edition-engraver-log = ##t
  }
  \context {
    \Voice
    %edition-engraver-log = ##t
  }
}

\new Staff = "BACH" \with {
  \editionID along
} \new Voice <<
  % add a meta track like a global variable
  { s1*13 \mark \default s1*4 \mark "Blupp" }
  % some music with instantly created voice
  {
    R1
    <<
      \repeat unfold 10 \relative c'' { bes4 a c b } \\
      \repeat unfold 10 \relative c' { d4. e4 f8 g4 }
    >>
    <<
      \repeat unfold 10 \relative c'' { bes4 a c b } \\
      \repeat unfold 10 \relative c' { d4. e4 f8( g4) } \\
      \repeat unfold 10 \relative c' { f2 a }
    >>
  }
>>
