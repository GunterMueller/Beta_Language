include(gbetastd.m4)dnl
begin_page(`Bugs and Inconveniences')

<P>
This is a list of known bugs and inconveniences.  New information will
be added here as it arises.
</P>

<H3>Bugs</H3>
<P>
<UL>

<LI>Repetition assignments are not fully implemented.  Note that it is
  always possible to obtain the same effect by writing a <TT>for</TT>
  statement that assigns the elements in the repetition
  one-by-one.</LI> 

<LI>The type checks associated with lower bounds on virtuals are
  incomplete, so it is possible to write a program that violates the
  lower bound and still not get an error message during type
  analysis.</LI>

<LI>Adding arguments or return values to virtuals is bad style and
  should give a warning; the semantics of such additions is
  well-defined but confusing and rarely useful, so it should not pass
  without notice.</LI> 

<LI>_gbeta does not handle the situation gracefully if a SLOT
  declaration and a SLOT application do not match the actual syntactic
  category, i.e. the following program will be accepted even though it
  is not well-formed (there is a syntax category mismatch for
  <CODE>"p"</CODE>): 

program_box(cq[[
-- betaenv:descriptor --
(# p: &lt;&lt;SLOT p:descriptor>> #)

-- p:staticitem --
@(# do 'Hello again, world!'->stdio #)]]nq)

  When executing the _gbeta syntax version of that program, the
  problem is detected but the error handling is not graceful:

program_box(cq[[
-- betaenv:descriptor:gbeta --
(# p: &lt;&lt;SLOT p:descriptor>> #)

-- p:staticitem:gbeta --
@(# do 'Hello again, world!'->stdio #)]]nq)

leads to:
program_box(cq[[<SMALL>
...
@66
          (StaticItem=25:1@64
           (Merge=30:1@54
            (ObjectDescriptor=4:3[0][0][0][0][0][0][0][0]@2##[11]@4##[5]@52
             (LongMainPart=8:2@8
              (Attributes=10:1@6##[15])@50
              (ActionPart=33:3@10##[34]@44
               (DoPart=38:1[0][0]@42
                (Imperatives=40:1@40
                 (AssignmentEvaluation=62:2@20
                  (TextConst=115:1@12^Hello again, world!)@36
                  (ObjectDenotation=66:1[0][0]@34
                   (Merge=30:1@28
                    (NameApl=113:1[0][0][0][0]@22^stdio))))))@48##[36])))))
**** Exception processing
Found AST node which is neither a SLOT nor as expected by the grammar
<SMALL>]]nq)
</LI>
<LI>At some point, _gbeta will be able to mix program elements written
  in BETA syntax (<CODE>*.bet</CODE> files) with elements written in
  the slightly richer _gbeta syntax (<CODE>*.gb</CODE> files); for
  now, keep them strictly separate.  
</UL>
</P>

<H3>Inconveniences</H3>
<P>
<UL>
<LI>_gbeta will not discover if one or more of the source code files
  for the currently executing program changes on disk; <CODE>quit</CODE>
  and restart to refresh the information inside _gbeta about the
  program</LI>
<LI>In Emacs, starting _gbeta on a new program as long as another
  _gbeta program is running will not work.  The Emacs framework will
  try to persuade _gbeta to switch to running the new program, but
  _gbeta doesn't understand this, and the result is that the new
  program you are trying to start is ignored by _gbeta.  Quit the
  first session, or run another Emacs.
</UL>
</P>

<H3>How to Report a Bug</H3>
<P>
Send an <A HREF="mailto:eernst@cs.auc.dk">email to me</A>
describing the problem.  Please provide me with a small
program and and a series of actions which causes the problem to
occur.  Also mention the precise release of _gbeta you are using, and
tell me if it is a customized version in any way.
</P>

end_page

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
