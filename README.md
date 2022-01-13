# futhest

nim+docker to debug futhark/clang SIGSEGV


`$ docker build --rm -t futhest .`

output:
```
Step 7/7 : RUN ./futhest
 ---> Running in 6700db2687f2
Traceback (most recent call last)
/usr/src/app/src/futhest.nim(29) futhest
SIGSEGV: Illegal storage access. (Attempt to read from nil?)
(data: ..., private_flags: 1)
[data = 0x561f8fd62710,
numEntries = 12,
entries = ptr 0x561f8fd4c120 --> [kind = CXTUResourceUsage_AST,
amount = 278528]]
Segmentation fault (core dumped)
The command '/bin/sh -c ./futhest' returned a non-zero code: 139
```