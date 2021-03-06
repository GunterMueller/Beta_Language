include(gbetastd.m4)dnl
begin_page(News)

<DL>
<DT>July 2001</DT>
<DD>Released _gbeta 0.9</DD>
<DT>June 2001</DT>
<DD>Switched to version 0.9, preparing new release.</DD>
<DT>May 2001</DT>
<DD>Added a lot of static pattern stuff (instructions, code generation
    with these instructions, options to control it, support in static 
    analysis).</DD>
<DT>April 2001</DT>
<DD>Started introducing static patterns in the analysis.  A static
    pattern describes a complete pattern which is known already at
    compile time.  Working with static patterns at run-time is the
    first step that must be taken in order to avoid performing
    (expensive!) pattern merge operations at run-time.</DD>
<DT>April 2001</DT>
<DD>Totally reorganized the treatment of options, to make it easier to
    keep options and documentation/help/usage synchronized.  In the
    new approach, each option is one object, and that object handles
    everything related to that particular option, including printing
    usage info and detecting whether a given command line argument is
    a usage of that option.</DD>
<DT>March 2001</DT>
<DD>Segregated run-time steps into "internal" and "final" ones, thereby
    making the construction and execution of run-time paths much
    clearer (and removing a couple of un-discovered bugs).</DD>
<DT>February 2001</DT>
<DD>Switched over to using the new meta-programming system from
    Mjolner.  This new version of MPS supports mapping from abstract
    syntax tree node to from/to-char-pos in the source code.  This
    means that there is no need to use the special, patched, version
    of MPS that adds this functionality, thus getting rid of an old
    inconvenience.</DD>
<DT>January 2001</DT>
<DD>Adding support for saving static info to disk
    (option <tt>-s</tt>).</DD>
<DT>September 2000</DT>
<DD>Started working through the entire static analysis, expressing
    types in a different way.  The difference is that the <tt>fixed</tt>
    attribute and the <tt>exactType</tt> attribute of types are
    removed and a new <tt>staticallyKnown</tt> attribute added.  The
    most important difference is that the types in the new approach
    will <em>never</em> describe anything but patterns, and they will
    <em>never</em> describe another number of patterns than exactly
    one.  With the old approach, a type could describe an object, and
    it could sometimes describe two entities - and that simply got too
    messy over time.</DD>
<DT>September 2000</DT>
<DD>Introduced programs into <tt>when</tt> statements, thereby
    compiling them all the way down to byte code, such that they can
    be expressed in disk file byte code format.</DD>
<DT>September 2000</DT>
<DD>Added level indications to <tt>tmp</tt> stack instructions, thus
    taking a first step towards a register based virtual machine (as
    opposed to the current model which is stack oriented).</DD>
<DT>July 2000</DT>
<DD>Started working on the disk file format for byte code.  The file
    based byte codes will be a printed version of the byte codes which
    are stored in the abstract syntax trees today.  To be able to do
    this we must compile a few constructs down to a lower level than
    they are in the abstract syntax trees, because the disk file byte
    codes must contain <em>complete</em> information about the program
    being executed:  It is no longer possible to take a quick look at
    the abstract syntax and/or the static info in order to execute a
    byte code.</DD>
<DT>Spring 2000</DT>
<DD>Worked on compiled object creation (it used to be based on
    closures but it will now use byte code).  This is the last part 
    of the language that still needs to be translated into byte code,
    all other parts are already being translated.</DD>
<DT>February 2000</DT>
<DD>Released _gbeta 0.81.  It should have been "0.8.1", but 
    it's hardly worth the trouble to change that after the
    announcement has been made.</DD>
<DT>January 2000</DT>
<DD>Ported _gbeta to the new release of the Mjolner BETA System.
    Implemented an <TT>eval</TT> primitive; this is an experiment, and
    there is no commitment that the language gbeta must support
    <TT>eval</TT>.</DD>
<DT>Autumn 1999</DT>
<DD>Defended PhD thesis, started as an assistant prof. at the Univ. of
    Aalborg, Denmark (not much time for implementation..)</DD>
<DT>July 25, 1999</DT>
<DD>Released _gbeta version 0.8</DD>
<DT>June 15, 1999</DT>
<DD>Delivered final version of my PhD thesis which is basically
    about _gbeta; the thesis will be made available on this 
    site.  It is the most comprehensive source of information
    about _gbeta so far.</DD>
<DT>Spring 1999</DT>
<DD>Implemented various parts of _gbeta which had been conceived
    and designed during 1998 and 1999; e.g., lower bounds on 
    virtuals, disownment markers, enhancements in the fragment
    system, and a better semantics for final bindings.</DD>
<DT>Summer and autumn 1998</DT>
<DD>Finally found a plausible design for a byte-code based model
    of execution, and implemented it.</DD>
<DT>Spring 1998</DT>
<DD>Implemented more and more of the language,
    changing the semantics in a few cases where the 
    earlier choices turned out to be ill-defined; also
    wrote some papers which were revised lots of times 
    and were accepted at conferences and/or became parts 
    of the PhD thesis at a later stage.</DD>
<DT>December 20, 1997</DT>
<DD>Improved navigation on this web-site, added 
    "not-yet-ready" markers a few places, fixed some typos.</DD>

<DT>December 18, 1997</DT>
<DD>The _gbeta web-site is fairly complete.  Announced on some 
    news groups, with the release of _gbeta version 0.5.</DD>

<DT>November 28, 1997</DT>
<DD>Everything here is new</DD>
</DL>

end_page

dnl local variables:
dnl mode: html
dnl eval: (local-set-key "\C-cc" 'gbeta-html-compile)
dnl end:
