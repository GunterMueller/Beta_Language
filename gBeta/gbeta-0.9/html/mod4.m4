include(modularizationstd.m4)dnl
_deflr(3,5)dnl
begin_mod(`A Concrete Example (continued)')

<P>
In the example which started on the previous section there were
references to three fragments (by means of <TT>INCLUDE</TT>
properties) that we have not yet shown.  They provide a hierarchy of
patterns for <TT>ordered</TT> entities.  The basic <TT>ordered</TT>
pattern is defined in the file <TT>ordered.gb</TT>, and it looks like
this:
</P>

program_box(cq[[(* FILE ordered *)
ORIGIN 'betaenv';
BODY 'orderedImpl'

-- lib:attributes --

ordered:
  (# &lt;&lt;SLOT OrderedLib:attributes&gt;&gt;;
     cmpType:&lt; ordered :&gt; this(ordered);
     init:&lt; (# do INNER exit this(ordered)[] #);
     lessEqual:&lt; 
       (# other: ^cmpType; b: @boolean
       enter other[] 
       do INNER 
       exit b
       #);
     greaterEqual: 
       (# b: @boolean enter lessEqual->b exit not b #);
     max:
       (# other,maxi: ^cmpType
       enter other[]
       &lt;&lt;SLOT OrderedMax:dopart&gt;&gt;
       exit maxi[]
       #)
  exit this(ordered)[]
  #)]]nq)

<P>
The slot <TT>OrderedMax</TT> appears where the implementation of the
<TT>max</TT> method would be; this implementation has been taken out
and placed in another file, in order to illustrate how the interface
and the implementation of an entity can be separated from each other.
The implementation fragment looks like this:
</P>

program_box(cq[[(* FILE orderedImpl *)
ORIGIN 'ordered'

-- OrderedMax:dopart --
do  
   (if other[]->greaterEqual then 
       other[]->maxi[]
    else 
       this(ordered)[]->maxi[]
   if)]]nq)

<P>
The <TT>ordered</TT> pattern is specialized in two directions,
to <TT>text</TT> and to <TT>number</TT> which is itself specialized to
<TT>int</TT> and to <TT>float</TT>:
</P>

program_box(cq[[(* FILE orderedText *)
ORIGIN 'betaenv';
INCLUDE 'ordered'

-- lib:attributes --

text: ordered
  (# &lt;&lt;SLOT TextLib:attributes&gt;&gt;;
     cmpType::text;
     init::(# enter value #);
     lessEqual::(# do (other.value&lt;=value) -> b #);
     value: @string
  #)]]nq)

program_box(cq[[(* FILE orderedNumber *)
ORIGIN 'betaenv';
INCLUDE 'ordered'

-- lib:attributes --

number: ordered
  (# &lt;&lt;SLOT NumberLib:attributes&gt;&gt;;
     cmpType::number;
     lessEqual::(# do (other.asReal&lt;=asReal)->b #);
     asReal:&lt; (# r: @real do INNER exit r #);
     asInteger:&lt; (# i: @integer do INNER exit i #);
  #);

int: number
  (# &lt;&lt;SLOT IntLib:attributes&gt;&gt;;
     init::(# enter value #);
     asReal::(# do value->r #);
     asInteger::(# do value->i #);
     value: @integer
  #);

float: number
  (# &lt;&lt;SLOT FloatLib:attributes&gt;&gt;;
     init::(# enter value #);
     asReal::(# do value->r #);
     asInteger::(# do value->i #);
     value: @real
  #)]]nq)

<P>
All these patterns are made available in our program (in the file
<TT>orderedUser.gb</TT>) by means of the <TT>INCLUDE</TT> properties,
and the implementation in the file <TT>orderedImpl.gb</TT> was brought
along because of the <TT>BODY</TT> property in <TT>ordered.gb</TT>.
Note that no files include <TT>orderedImpl.gb</TT>, so the static
analysis of the other files cannot depend on the contents of
<TT>orderedImpl.gb</TT>; in other words, nobody depends on the
implementation of the <TT>max</TT> method.  
</P>

<P>
With these patterns the system is almost complete.  The only missing
part is that the main program calls an <TT>asString</TT> method on an
<TT>ordered</TT> object, and we have no such method available in the
declarations so far.  The _modref(5,next) section explains how we can
provide such a method unintrusively.
</P>

end_mod

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
