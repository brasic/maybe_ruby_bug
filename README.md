# is this a ruby bug?


```
> puts RubyVM::InstructionSequence.disasm(ExampleOne.new.method(:foo))
== disasm: #<ISeq:foo@bug.rb:3 (3,2)-(6,5)> (catch: FALSE)
== catch table
| catch type: break  st: 0007 ed: 0019 sp: 0000 cont: 0019
| == disasm: #<ISeq:block in foo@bug.rb:4 (4,32)-(4,55)> (catch: FALSE)
| == catch table
| | catch type: redo   st: 0001 ed: 0017 sp: 0000 cont: 0001
| | catch type: next   st: 0001 ed: 0017 sp: 0000 cont: 0017
| |------------------------------------------------------------------------
| local table (size: 2, argc: 2 [opts: 0, rest: -1, post: 0, block: -1, kw: -1@-1, kwrest: -1])
| [ 2] h@0<Arg>   | [ 1] k@1<Arg>
| 0000 nop                                                              (   4)[Bc]
| 0001 putnil                                 [Li]
| 0002 getlocal_WC_0                          h@0
| 0004 getlocal_WC_0                          k@1
| 0006 putself
| 0007 getlocal_WC_1                          arg1@0
| 0009 invokesuper                            <calldata!mid:foo, argc:1, FCALL|ARGS_SIMPLE|SUPER|ZSUPER>, nil
| 0012 setn                                   3
| 0014 opt_aset                               <calldata!mid:[]=, argc:2, ARGS_SIMPLE>
| 0016 pop
| 0017 nop
| 0018 leave                                                            (   4)[Br]
|------------------------------------------------------------------------
local table (size: 1, argc: 1 [opts: 0, rest: -1, post: 0, block: -1, kw: -1@-1, kwrest: -1])
[ 1] arg1@0<Arg>
0000 getinstancevariable                    :@_memoized_foo, <is:0>   (   4)[LiCa]
0003 dup
0004 branchif                               24
0006 pop
0007 opt_getinlinecache                     16, <is:1>
0010 putobject                              true
0012 getconstant                            :Hash
0014 opt_setinlinecache                     <is:1>
0016 send                                   <calldata!mid:new, argc:0>, block in foo
0019 nop
0020 dup                                                              (   4)
0021 setinstancevariable                    :@_memoized_foo, <is:0>
0024 pop
0025 getinstancevariable                    :@_memoized_foo, <is:0>   (   5)[Li]
0028 getlocal_WC_0                          arg1@0
0030 opt_aref                               <calldata!mid:[], argc:1, ARGS_SIMPLE>
0032 leave 
```
Expected Result:
```
irb(main):023:0> puts RubyVM::InstructionSequence.disasm(ExampleTwo.new.method(:foo))
== disasm: #<ISeq:foo@bug.rb:10 (10,2)-(13,5)> (catch: FALSE)
== catch table
| catch type: break  st: 0007 ed: 0019 sp: 0000 cont: 0019
| == disasm: #<ISeq:block in foo@bug.rb:11 (11,32)-(11,58)> (catch: FALSE)
| == catch table
| | catch type: redo   st: 0001 ed: 0017 sp: 0000 cont: 0001
| | catch type: next   st: 0001 ed: 0017 sp: 0000 cont: 0017
| |------------------------------------------------------------------------
| local table (size: 2, argc: 2 [opts: 0, rest: -1, post: 0, block: -1, kw: -1@-1, kwrest: -1])
| [ 2] h@0<Arg>   | [ 1] k@1<Arg>
| 0000 nop                                                              (  11)[Bc]
| 0001 putnil                                 [Li]
| 0002 getlocal_WC_0                          h@0
| 0004 getlocal_WC_0                          k@1
| 0006 putself
| 0007 getlocal_WC_0                          k@1
| 0009 invokesuper                            <calldata!mid:foo, argc:1, FCALL|ARGS_SIMPLE|SUPER>, nil
| 0012 setn                                   3
| 0014 opt_aset                               <calldata!mid:[]=, argc:2, ARGS_SIMPLE>
| 0016 pop
| 0017 nop
| 0018 leave                                                            (  11)[Br]
|------------------------------------------------------------------------
local table (size: 1, argc: 1 [opts: 0, rest: -1, post: 0, block: -1, kw: -1@-1, kwrest: -1])
[ 1] arg1@0<Arg>
0000 getinstancevariable                    :@_memoized_foo, <is:0>   (  11)[LiCa]
0003 dup
0004 branchif                               24
0006 pop
0007 opt_getinlinecache                     16, <is:1>
0010 putobject                              true
0012 getconstant                            :Hash
0014 opt_setinlinecache                     <is:1>
0016 send                                   <calldata!mid:new, argc:0>, block in foo
0019 nop
0020 dup                                                              (  11)
0021 setinstancevariable                    :@_memoized_foo, <is:0>
0024 pop
0025 getinstancevariable                    :@_memoized_foo, <is:0>   (  12)[Li]
0028 getlocal_WC_0                          arg1@0
0030 opt_aref                               <calldata!mid:[], argc:1, ARGS_SIMPLE>
0032 leave                                                            (  13)[Re]
```
