include(advancedstd.m4)dnl
_deflr(2,4)dnl
begin_adv(`Co-evolution of Patterns`,' Design Patterns')

<P>
It is often relevant to have a parallel development of a number of
related concepts in specialization hierarchies.  Another related issue
which is indeed the same issue in the context of BETA is handling
interdependent generic classes.  Often in other languages, e.g. C++
and Eiffel, using generics (templates, parameterized classes) for the
co-evolution of a group of classes is not convenient.  Distinct 
templates, e.g., are separate entities and they do not "know when
each other grows".  
</P>

<P>
This problem has had a nice solution in BETA for many years, since
the block structure (general closures, nesting) of BETA makes it
possible to create a "universe," an enclosing pattern, in which a
group of interdependent patterns can be declared as virtuals and hence
develop as a group.
</P>

<P>
With _gbeta, this technique is supported in an even more expressive
way, since virtual patterns can now be further-bound to unrelated
patterns.  In traditional BETA, a virtual can only be further-bound to
a specialization of what it is in the super-pattern.
</P>

<h3>Example 3</h3>
<P>
Here's a rather long example showing how co-evolution of patterns can
be used to create support for the observer design pattern as a genuine
pattern which can just be used and reused, not as a design guide which
must be accompanied by a slightly different implementation effort each
time.

program_box(cq[[<SMALL>
(* FILE aex3.gb *)
-- betaenv:descriptor --
(#
   (* This demonstrates a very general support for the
    * Observer Design Pattern (TM) as a native language entity,
    * a pattern, not as a design guide to follow when writing
    * yet another instance of that pattern.
    * 
    * The idea is that a 'Subject' is being watched by a
    * number of 'Observer's, and the observers change
    * whenever the subject changes.  For example, a
    * graphical user interface could have a presentation
    * layer (the graphics) and a model layer (the "data"),
    * and the presentation should change to reflect any
    * changes in the model.
    *
    * This is handled by making the subject notity the
    * observers, i.e. it is necessary to implement the
    * subject in such a way that 'notify' is invoked whenever
    * significant changes have taken place.
    *
    * There are some extra 'do INNER's, to make it easier to
    * observe what it going on in an interactive session.
    *)

   set:
     (* Just a dummy data structure which 
      * supports only one element *)
     (# element:&lt; object; 
        theElement: ^element;
        insert: (# enter theElement[] do INNER #);
        delete:
          (# e: ^element enter e[] 
          do (if e[]=theElement[] then NONE-&gt;theElement[] if);
          #);
        scan: 
          (# current: ^element;
          do theElement[]-&gt;current[]; 
             INNER
          #)
     #);

   ObserverDesignPattern:
     (* This is the kernel of the example; note
      * that 'Subject' and 'Observer' are mutually
      * dependent types, and that there is some
      * implementation (relevant and needed) here, in
      * the 'notify' method *)
     (# Subject:&lt; 
          (# attach: (# enter observers.insert #);
             detach: (# enter observers.delete #);
             notify: observers.scan
               (# do this(Subject)[]-&gt;current.update #);
             observers: @set(# element::&lt; Observer #);
          #);
        Observer:&lt; 
          (# update:&lt; 
               (# theSubject: ^Subject;
               enter theSubject[]
               do INNER
               #)
          #)
     #);

   (* A few auxiliary patterns *)
   
   textBuffer:
     (* Think of a text editor buffer containing
      * the data of a file being edited, but not
      * concerned with visual presentation of it *)
     (# filename: @string;
        setFileName:&lt; (# enter filename do INNER #);
        getFileName:&lt; (# do INNER exit filename #)
     #);
   
   Window:
     (* A GUI window; we only need a 'refresh' method *)
     (# refresh:&lt; (# do INNER #)#);
   
   ColorIcon: Window
     (* A color icon; again only one method is needed *)
     (# iconTitle: @string;
        setIconTitle: (# enter iconTitle do INNER #);
        refresh::&lt;
          (#
          do 'Got a new title: "'+iconTitle+'"\n'-&gt;stdio
          #)
     #);

   (* Now use the observer design pattern: A 'textBuffer'
    * is being watched by a 'colorIcon' which should
    * always show the filename associated with the text
    * buffer *)
   
   myODP: @ObserverDesignPattern
     (# Subject::&lt; TextBuffer
          (# (* ensure that 'notify' is called after changes *)
             setFileName::&lt; (# do notify #)
          #);
        Observer::&lt; Window
          (# update::&lt;
               (* At this level we can do half of the job: refreshing
                * the graphics; the other half is getting the changed
                * state, so we define a hook for that, 'getState' *)
               (# do theSubject[]-&gt;getState; refresh #);
             getState:&lt;
               (* Somebody who knows how to get the 
                * state must fill in this hook *)
               (# theSubject: ^subject 
               enter theSubject[] 
               do INNER 
               #)
          #)
     #);
   
   myBuffer: @myODP.Subject;
   myIcon: @ (& myODP.Observer & ColorIcon &)
     (# getState::&lt;
          (* here we know how to fill in the hook: the
           * state we care about is just the filename *)
          (# do theSubject.getFileName-&gt;setIconTitle #)
     #)
do 
   myIcon[]-&gt;myBuffer.attach;
   'aex3.gb'-&gt;myBuffer.setFileName
#)</SMALL>]]nq)
</P>

<P>
The _advref(4,next) section is about roles and players, and this is
actually also a good example of co-evolution of types.
</P>


end_adv

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
