include(tutorialstd.m4)dnl
_deflr(10,12)dnl
begin_tut(`Concurrency')

<P>
Concurrency is a large and interesting topic, so this will only
scratch the surface.
</P>

<H3>How does it look?</H3>
<P>
Concurrency is based on <EM>components</EM>, as introduced in the
section about _tutref(10,co-routines), but
we need to use one of the _tutref(16,`built-in attributes')
of <CODE>component</CODE> in order to start a thread concurrently with
respect to the rest of the program execution:

  code_box(`fork')

It looks like e.g. <CODE>aCmp.fork</CODE>, where <CODE>aCmp</CODE>
must be some specialization of the <CODE>component</CODE>
_tutref(16,`basic pattern').  Similarly, to kill a running thread which
is associated with a particular component, use: 

  code_box(`kill')

like in <CODE>aCmp.kill</CODE>.  There ought to have been a similar
command <CODE>suspend</CODE>, but since (for historical reasons) there
is a special imperative <CODE>SUSPEND</CODE>, the grammar does not
allow this.  Instead, temporarily, the following command has been 
defined on components:

  code_box(`_suspend (* NB: partially implemented *)')

The effect of <CODE>aCmp._suspend</CODE> would be to suspend that
component, as if a <CODE>SUSPEND</CODE> imperative had been executed
in that thread.  Please note that the current implementation of
<CODE>aCmp._suspend</CODE> <EM>only</EM> supports suspending a
component during its own execution, i.e. you cannot "suspend somebody
else."  Finally, to handle run-time errors and manage threads in
general, the following command has been defined but not implemented: 

  code_box(`status (* NB: not implemented *)')

The purpose of evaluating <CODE>aCmp.status</CODE> is to detect
whether <CODE>aCmp</CODE> is running, suspended, or terminated, and in
case is has terminated, it should somehow deliver information about
the termination status of the component.  This could be "Normal,"
"Divide by zero," "NONE-Reference," or whatever might stop a thread.
</P>

<H3>Example 9</H3>
<P>
This example is probably best executed in running mode (don't give the
<CODE>-i</CODE> option first), it gets too boring otherwise!

program_box(cq[[<SMALL>
(* FILE ex9.gb *)
-- betaenv:descriptor --
(#
   done: @integer
     (# do value+1-&gt;value; (if value=3 then '\n'-&gt;stdio if)#);
   cmp1: @|
     (# do (for 50 repeat '.'-&gt;stdio for); done #);
   cmp2: @|
     (# do (for 100 repeat 'x'-&gt;stdio for); done #)
do
   cmp1.fork;
   cmp2.fork;
   (for i:75 repeat (if i mod 7 = 0 then '\nmain '-&gt;stdio if)for);
   done
#)]]nq)
</P>

<P>
This actually finishes the main topics. The only things left now for
the _tutref(12,next) and following sections are various odds and ends
which are nevertheless needed. 
</P>

end_tut

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
