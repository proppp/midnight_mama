\version "2.22.1"

rhythmMarkStaffReduce = #-3
rhythmMarkLabelFontSize = #-2

rhythmMark = #(define-music-function (parser location label musicI musicII ) (string? ly:music? ly:music?)
   #{
      \mark \markup {
        \line \general-align #Y #DOWN {
          \combine
            \italic \fontsize #rhythmMarkLabelFontSize $label
            \transparent \italic \fontsize #rhythmMarkLabelFontSize f

          \score {                     % 2nd column in line
            \new Staff \with {
              fontSize = #rhythmMarkStaffReduce
              \override StaffSymbol.staff-space = #(magstep rhythmMarkStaffReduce)
              \override StaffSymbol.line-count = #0
              \override VerticalAxisGroup.Y-extent = #'(-0.85 . 4)
            }

            {
              \relative c' { \stemUp $musicI }

%             \override Score.SpacingSpanner.strict-note-spacing = ##t
              \once \override Score.TextScript.Y-offset = #-0.4
              s4.^\markup{ \halign #-1 \italic "=" }

              \relative c' { \stemUp $musicII }
            }

            \layout {
              ragged-right= ##t
              indent = 0
              \context {
                \Staff
                \remove "Clef_engraver"
                \remove "Time_signature_engraver"
              }
            } % layout end

          } % Score end

        } % line end
      } % markup end
   #})


%%% Function: rhythmMarkC
%%% ============================================================
%%%  Purpose: print a sophisticated rehearsal mark e.g for
%%%           rhythm directives in a column (music on top)
%%%    Usage: \rhythmMarkC label music1 music2
%%% ------------------------------------------------------------
%%% Variable: label (string)
%%% ------------------------------------------------------------
%%% Variable: music1 (ly:music)
%%% ------------------------------------------------------------
%%% Variable: music2 (ly:music)
%%% ------------------------------------------------------------
%%%  Example: \rhythmMarkC #"Swing" \rhyMarkIIEighths
%%%                 \rhyMarkSlurredTriplets
%%% ------------------------------------------------------------
%%% Constants:
%%%           rhythmMarkCStaffReduce = #-4
%%%           rhythmMarkCLabelFontSize = #-2
%%% ------------------------------------------------------------
%%%  Comment: see below for predefined values for music1&2
%%% ============================================================

rhythmMarkCStaffReduce = #-4
rhythmMarkCLabelFontSize = #-2

rhythmMarkC = #(define-music-function (parser location label musicI musicII ) (string? ly:music? ly:music?)
   #{
      \mark \markup
      {
        \combine

          \line {
            \hspace #0
            \translate #'(-0.1 . -3.25) \italic \fontsize #rhythmMarkCLabelFontSize $label
          } % end Line

          \line \vcenter {

              \score {                 % 1st column in line

                \new Staff \with {
                  fontSize = #rhythmMarkCStaffReduce
                  \override StaffSymbol.staff-space = #(magstep rhythmMarkCStaffReduce)
                  \override StaffSymbol.line-count = #0
                  \override VerticalAxisGroup.Y-extent = #'(0 . 0)  % td
                }

                \relative c' { \stemUp $musicI }

                \layout {
                  ragged-right= ##t
                  indent = 0
                  \context {
                    \Staff
                    \remove "Clef_engraver"
                    \remove "Time_signature_engraver" }
                } % layout

              } % 1st score

              \hspace #-0.1            % 2nd column in line

                                       % 3rd column in line
              \italic \fontsize #rhythmMarkCStaffReduce "="

              \score {                 % 4th column in line

                \new Staff \with {
                  fontSize = #rhythmMarkCStaffReduce
                  \override StaffSymbol.staff-space = #(magstep rhythmMarkCStaffReduce)
                  \override StaffSymbol.line-count = #0
                  \override VerticalAxisGroup.Y-extent = #'(0 . 0)  % td
                }

                \relative c' {
                  \stemUp $musicII
                }

                \layout {
                  ragged-right= ##t
                  indent = 0
                  \context {
                    \Staff
                    \remove "Clef_engraver"
                    \remove "Time_signature_engraver" }
                } % layout

              } % 2nd score end

            } % line end
          % end combine
        } % markup end
   #})

%%% predefined ly:music-Variables for use
%%% in function rhythmMark and rhythmMarkC
%%% ============================================================
rhyMarkI = { b'1*1/8 }

rhyMarkII = { b'2*1/4 }

rhyMarkIV = { b'4*1/2 }

rhyMarkEighth = { b'8 }

rhyMarkIIEighths = {
  % \override Score.SpacingSpanner.common-shortest-duration = #(ly:make-moment 1/4) % tight
  \override Score.SpacingSpanner.common-shortest-duration = #(ly:make-moment 3/16) % even
  b'8[ b8]
}
rhyMarkTriplets = {
  % \override Score.SpacingSpanner.common-shortest-duration = #(ly:make-moment 1/2) % super-tight
  % \override Score.SpacingSpanner.common-shortest-duration = #(ly:make-moment 1/4) % tight
  \override Score.SpacingSpanner.common-shortest-duration = #(ly:make-moment 3/16) % even
  \tuplet 3/2 { b'4 b8 }
}
rhyMarkSlurredTriplets = {
  % \override Score.SpacingSpanner.common-shortest-duration = #(ly:make-moment 1/4) % tight
  % \override Score.SpacingSpanner.common-shortest-duration = #(ly:make-moment 5/32) % slighty tighter as even
  \override Score.SpacingSpanner.common-shortest-duration = #(ly:make-moment 1/8) % even
  \tuplet 3/2 { b'8 ~ b8 b8 }
}
rhyMarkDottedEighths = {
  % \override Score.SpacingSpanner.common-shortest-duration = #(ly:make-moment 1/4) % tight
  \override Score.SpacingSpanner.common-shortest-duration = #(ly:make-moment 3/16) % even
  % \override Score.SpacingSpanner.common-shortest-duration = #(ly:make-moment 1/8) % loose
  { b'8.[ b16*2] }
}


\header {
  title = "Midnight Mama"
  composer = "Jelly Roll Morton"
  arranger = "Transcribed by Propp"
}

upper = \relative c'' {
  \clef treble
  \key bes \major
  \time 4/4
  r1
  r8 <bes bes'><a d f a><aes d f aes>4.<aes d f>8 r8
  r8 <bes bes'> <b d aes' b><c d aes' c>4<ees ees'>8<d fis> g  \ottava #1 <fis bes ees fis><g g'><fis bes d fis><g g'><c ees g c><fis fis,><g, bes d g> \ottava #0  <ees g bes ees>~
  <ees g bes ees><ees ees'><c d f aes c><bes bes'><g bes ees g>4<f a c f>8<cis cis'>
 \repeat volta 2 {\bar ".|:" <d f bes d><f f'><g bes d g><bes d f bes>~<bes d f bes><bes bes'><g bes d g>4
  <e bes' c><e bes' d>8<a ees' g>~<a ees' g> g'<f ees a,>4
  r8 <cis, cis'><d f bes d><f f'><g bes d g><bes bes'><g bes d g>4
  <e bes' d>8  <ees a cis> <e bes' c><a ees' g>~<a ees' g> f' <a, ees' g> <cis cis,>
  <d, f bes d><f f'><g bes d g><f aes d f>~<f aes d f>4.<fis fis'>8
  <g bes ees g><bes bes'><c ees g c><des des'><c ees g c><bes bes'><g bes e g><f f'>
  <des f bes des><bes bes'><c d f c'><bes d f bes>~<bes d f bes>4 r4
  <des f bes des>8<bes bes'><c ees a c><bes d f bes>~<bes d f bes><e e'><f aes d f><fis fis'>
  <g bes ees g><bes bes'><c ees g c><bes ees g bes>~<bes ees g bes>4.<fis fis'>8
  <g bes ees g><bes bes'><c ees g c><des des'><c ees g c><bes bes'><g bes e g><f f'>
  <des e bes' des><bes bes'><c ees f c'><bes d f bes>~<bes d f bes> r4 <f' f'>8
  <bes d f bes>4<aes bes d aes'>8<g g'><f bes d f><des f bes des>4<d d'>8
  <c' f>4 e8 f ees c4.
  <<
    \new Voice  {
      \voiceOne
      e,4.
    }
    \new Voice  {
      \voiceOne
     <bes' des>8
   c bes g

    }
  >>
  <<
    \new Voice  {
      \voiceOne
      e4 ees4
    }
    \new Voice  {
      \voiceOne
     <bes' des>8
   c bes g

    }
  >>
  <d bes'>4<f bes>8 fis g <bes ees> g f
  <bes d>4<f a c ees f>
  <<
    \new Voice  {
      \voiceOne
    < bes d f bes>8 r4.
  }
    \new Voice  {
      \voiceTwo
      r8 b, c cis

    }
  >>
  <<
    \new Voice  {
      \voiceTwo
    d r4.
  }
    \new Voice  {
      \voiceOne
      r8 <bes' bes'>< a d f a>< aes d f aes>~< aes d f aes>4<aes d f>8 r

    }
  >>
  \tuplet 3/2 {<bes d f bes>4 <b d aes' b><c d aes' c>}~<c d aes' c>8 <bes bes'><fis bes d fis><g g'>
  <ees g bes ees><bes' bes'><b ees g b>4<c ees g c>8<ees ees'><c ees g c> r
  <fis bes ees fis><g g'><d g bes d><f f'><ees a c ees><d d'><c fis a c> r
  r8 <bes bes'> <a d f a><aes bes d aes'>~<aes bes d aes'>4 <f aes d f>8 r
  r <bes bes'><b d aes' b><c d aes' c>~<c d aes' c><bes bes'><fis bes d fis><g g'>
  <ees g bes ees>8 r8 <bes' ees g bes><g g'><bes ees g bes><c ees g c>~<c ees g c><bes ees g bes>
  <b f' g b> r <g b d g><fis fis'><f b d f>4 <g b d g>
  r8 <c c'><b e g b><bes e g bes>~<bes e g bes><g g'><fis bes e fis><g g'>
  <c e g c>4<b f' aes b>8<bes e g bes>~<bes e g bes>4. aes'8
  <f, aes c f><g g'><aes c f aes><f f'><g c e g><aes f' aes><g c e g><f f'>
  <c' aes'>4<c g'>8<c f>~<c f><c f aes>8<d fis a d><c c'>
  r4 <bes d f bes>8<a a'><aes bes d aes'>4 <<
    \new Voice  {
      \voiceOne
    <bes d f>8 r
    r <bes bes'><b d aes' b><c d aes' c>~<c d aes' c><bes bes'><fis bes d fis><g g'>
  }
    \new Voice  {
      \voiceTwo
      \tuplet 3/4 {r16 c, cis}
     d4
    }
  >>
  <g bes ees>8<g g'><aes aes'><a a'><bes bes'><b b'><c c'><d d'>
  <ees g bes ees> r <c ees g c><des g c>~<des g c> g <des fis> g
  <d bes'> r \ottava #1 <bes' d f bes><a a'><aes bes d aes'>4<f bes d f>8 r
  \ottava #0 \tuplet 3/2 {<bes, d f bes>4 <b d aes' b><c d aes' c>}~<c d aes' c>8 <bes bes'><fis aes d fis><g g'>
  <ees g bes ees> r <a' d fis><bes ees g><a d fis><bes ees g><fis a d><g bes ees >
  <fis a d><g bes ees>~<g bes ees><fis a d><g bes ees> bes <a d><ees a>
  <aes c> r <bes, d f bes><a a'><aes bes d aes'>4<bes d f>
  \tuplet 3/2 {<bes d f bes>4 <b d aes' b><c d aes' c>}~<c d aes' c>8 <ees ees'><fis, aes d fis><g g'>
  <g bes ees>4 \rhythmMark #"Double time" \rhyMarkEighth  \rhyMarkIV<ees' g bes ees><c ees g c>8<ees ees'><c ees g c>4
  <ees g bes ees> r8 <ees g bes ees> r <ees g bes ees> r4
  r8 bes' <c, ees g c> r bes' <c, ees g c> r4
  <c ees g c> r8 <b f' g b> r8 a' <b, f' g b>4
  <c e g c>^"tempo I"<b e g b>8 <bes e g bes>~<bes e g bes> g' fis g
  c4 \grace {g16 aes a b} c8 b bes g e c
  <c f> g' <c, aes'> f <c g'> aes' <c, g'> f
  <c aes'>4 <c g'>8<c f>~<c f><c g'><d fis a d><des des'>
  <c d f aes c> r <bes d f bes ><a a'><aes bes d aes'>4<bes d f>
  \tuplet 3/2 {<bes d f bes>4 <b d aes' b><c d aes' c>}~<c d aes' c>8 <bes bes'><fis aes d fis><g g'>
  <g bes ees>8 ees' <aes, aes'><a a'><bes bes'><b b'><c c'><d d'>
  <ees g bes ees>2 \ottava #1 <ees' g bes ees>8 \ottava #0 r8 <c,, ees c'>4
  <bes ees bes'>8 <c ees a>4<bes d aes'>8~<bes d aes'>4 <aes d f>8 r
  <bes ees bes'>8<b ees a b>4<c ees a c>8~<c ees a c><bes bes'><aes d fis> g'
  <g, bes ees>4 r <a fis'>8<bes g'><a fis'><bes g'>
  <ees bes' d><ees bes' d>4<ees g c>8~<ees g c> bes' <cis, fis> g'
  <d aes' bes>4 <bes d f bes>8<a a'><aes d f aes>4<aes d f>
  <bes ees bes'>8<b ees a b>4<c ees a c>8~<c ees a c>bes'<aes, d fis> g'
  <g, bes ees>8 r8 <bes ees g><bes ees g bes>~<bes ees g bes><bes ees g><bes ees g bes> r
  <b f' g b><b f' g>~<b f' g><b f' a><b f' g> r <b f' g>4
  <c e g c><b d f b>8<bes e g b>~<bes e g b> g' fis g
  c <c, e g c><b d f b><bes c e g bes>~<bes c e g bes>4<g bes c e g>
  <c f>8 g' aes f g aes g f
  aes4 g8 <c, f>~<c f>4 } \alternative {{<ees a d>8 c'
  r <bes, d f bes><a d f a>4 <aes d aes'><aes d f>
  <bes ees g bes>8<b ees a b>4<c ees a c>8~<c ees a c><bes bes'><aes d fis> g'
  <g, ees'>4 r r8 <bes' d f bes><c d fis c'>4 <ees g bes ees>
  r \ottava #1 <ees' g bes ees> \ottava #0 <f,, a c f>8 <cis cis'>
} {<d' fis a d><des des'> <c d aes' c><bes bes'><a d f a><aes d f aes>~<aes d f aes>4<<
    \new Voice  {
      \voiceOne
      <aes d f>r8<bes bes'><b d aes' b><c d aes' c>~<c d aes' c><ees ees'><fis, bes d fis><g g'>    }
    \new Voice  {
      \voiceTwo
      {r8 c,16 cis}
     d4
    }
  >>
  \ottava #1 <fis' bes d fis>8<g g'><fis bes d fis><g g'><ees g c ees><c c'><bes d f bes>4
  <ees g bes ees>8 \ottava #0 <fis, fis'><g bes d g><bes bes'><ees g bes ees>4 r

}


}



}

lower = \relative c, {
  \clef bass
  \key bes \major
  \time 4/4
  r2 r4 <ees ees'>8 <e e'>
  <f f'>4 <a' d f> bes,, <aes'' bes d f>
  \grace {[(fis16 g ] } <f, aes'>4  )<bes' d f> bes,, <bes'' d f aes>
  <ees,, ees'> <d' d,> <c, c'> <bes' bes,>
  <ees ees,><bes bes,><ees, ees,><f f,>
  <bes' bes,><g bes d><f f,><g bes d>
  <c, g'><c aes'><f, c' a'><f a'>8<bes bes'>~
  <bes bes'>4<f' bes><f,><g' bes d>8<fis fis,>
  <g, g'><fis fis'><g g'><aes aes'><a a'><f f'><g g'><a a'>
  <bes bes'>4<g' bes d><bes,,><f'' aes bes d>
  <ees, g'><c'' ees g><ees,, ees'><e e'>8<f f'>~
  <f f'>4<f'><bes ,,><f'' aes bes d>
  <g, g'><f f'><bes bes'><bes aes'>
  <ees, g'><c'' ees g><bes,,><bes'' ees g>
  <ees,, g'><c'' ees g><ees,, ees'><e e'>8<f f'>
  <g g'>4<a a'><bes bes'><f' aes bes d>
  <f,><f' aes bes d><d,><f' bes>
  <c c'><f a ees'><f,><f' a ees'>
  <g g,>2<fis fis,>4<f f,>
  <bes bes,><d,, f'>8 fis' <ees, g'>4<f a'>
  <bes bes'><f f'><bes bes'>8 r8 <fis a'>4
  <f aes'><a' d f>8 aes bes,,4 <aes'' bes d f>
  <f, aes'><b' d f><bes,,><bes'' d>
  <ees,, g'><b'' ees g><bes,,><c'' ees g>
  <g, bes'><bes' d g><fis, a'><c'' ees fis a>
  \grace { d16,[( ees f g] } <f, aes'>4) <a' d f>8 aes bes,,4 <aes'' d>8 r
  \grace { d16[( c bes a] } <f, aes'>4) <b' d f><bes,,><bes'' d>
  <ees,, g'>8 r <bes'' ees g>4 <bes ees g>8<c, a'>~<c a'> <cis bes'>8
  <g d' b'>4<g' b d><g, g'>8<aes aes'><g g'><aes f' b>
  <g e' bes'>4<g' b e> c,, <b'' c e>
  <g, e' bes'><aes f' b><g e' bes'><g' bes c e>
  <aes, aes'>8<bes bes'><c c'><aes aes'><bes bes'><c c'><bes bes'><aes aes'>
  <c c'><b b'><bes bes'><aes aes'>~<aes aes'> r <a fis'>4
  <bes aes'><bes' d f><bes,,><bes'' d f>
  <f, aes'><b' d f><bes,,><bes'' d>
  <ees, ees'>8<ees ees'><d d'><c c'><bes bes'><a a'><aes aes'><f f'>
  <ees ees'> r <ees ees'>4<e e'>8 r8 <e e'>4
  <f f'>8 r 8 <aes' bes d f>4<bes,,><aes'' bes d f>
  <f, aes'><b' d f><bes,,><bes'' d>
  <ees,, g'>8 r8 r4 r2
  r2 r4 <fis a'>
  <f aes'><bes' d f><bes,,><bes'' d f>
  <f, aes'><b' d f><bes,,><bes'' d>
  <ees, ees'><bes' ees g><bes, bes'><c' ees g>
  <ees, ees'><bes' ees g><bes, bes'><bes' ees g>
  <ees, ees'><c' ees g ><bes, bes'><c' ees g>
  <ees, ees'><c' ees g><d, d'><g b d f>
  <c, c'><g' b e><c,,><bes'' c e>
  <g, g'><g' bes c e><c,, e'><g'' bes c e>
  <aes, aes'>8<bes bes'><c c'><aes aes'><bes bes'><c c'><bes bes'><aes aes'>
  <c c'><b b'><bes bes'><aes aes'>~<aes aes'> g' <a, fis'>4
  <bes aes'><bes' d f><bes,,><bes'' d f>
  <f, aes'><b' d f><bes,,><bes'' d>
  <ees, ees'>8<c ees'><b d'><bes des'><aes c'><g bes'><fis a'><f aes'>
  <ees g'>4 \ottava #-1 <ees,> \ottava #0 <ees''' g bes>8 r <aes,, aes'>4
  <g g'>8<fis fis'>4<f f'>8~<f f'>4<bes,>8 r
  <g' g'><fis fis'>4<f f'>8~<f f'>4<bes,>
  <ees> r r2
  g8' g4 g8~g4 e
  f <bes, d f><bes d f><bes d f>
  <g g'>8<fis fis'>4<f f'>8~<f f'>4<bes, bes'>
  <ees bes'> r8 <ees bes'>~<ees bes'><ees bes'><ees bes'> r
  <g d><g d>~<g d><g d><g d> r <g d>4
  <c, c'><c d'>8<c e'>~<c e'> r r4
  r8 <c c'><d d'><e e'>~<e e'>4 <c c'>
  <aes' aes'>8<bes bes'><c c'><aes aes'><bes bes'><c c'><bes bes'><aes aes'>
  <c c'><b b'><bes bes'><aes aes'>~<aes aes'> <g g'> <fis fis'>4
  <f f'>8<bes f'><bes f'>4<bes f'><bes f'>
  <g g'>8<fis fis'>4<f f'>8~<f f'>4<bes,>
  <ees> r r8 <bes' aes' d><bes aes' d>4<ees bes' g'> \ottava #-1 ees,, \ottava #0 <bes''' ees g><f, a'>
  <fis a'> <f aes'><a' d f>8 aes <bes,,>4<aes'' bes d f aes>
  <f, aes'><b' d f><bes,,><bes'' d>
  <ees, ees'><d d'><c c'><bes aes' d>
  <ees, g'><bes' aes'><ees, g'> r \bar "|."

}

\score {
  \new PianoStaff <<
    \set PianoStaff.instrumentName = #"Piano  "
    \new Staff = "upper" \upper
    \new Staff = "lower" \lower
  >>
  \layout { }
  \midi { }
}
