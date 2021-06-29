#!/bin/sh

# -Scgi 	- Support operators like C; Enable LABEL and GOTO(default for -MDelphi; Inlining
# -Cg PIC code 	- for Linux library only (slowed code for program)
# -Ci 		- IO checking
# -O2 		- optimization level
# -g -gl -gw2 -Xg- Generate debug information; Use line info unit (show more info with backtraces); DWARFv2 debug info; debug info in separate file
# -k'-rpath=$ORIGIN' - link to a library in the same folder as program
# -veiq -vw-n-h - verbose(errors, info, message numbers) no warnings, no notes, no hints
# -B 		- build all
# -Se10 	- halts after 10 error 

TARGET=linux
ARCH=x86_64

rm -rf ./.dcu
mkdir -p ./.dcu/$ARCH-$TARGET

set -x
fpc -MDelphi -Sci -Ci -O3 -k'-rpath=$ORIGIN' -k-lstdc++ \
  -veiq -vw-n-h- \
  -Fi.dcu/$ARCH-$TARGET -Filib/Synopse \
  -Fllib/Synopse/static/$ARCH-$TARGET \
  -Fulib/Synopse \
  -FU.dcu/$ARCH-$TARGET  \
  -dDOPATCHTRTL -dFPCUSEVERSIONINFO \
  -B -Se1 ./utf8validate.lpr
