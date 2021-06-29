# simdjson_pas
Wraper for [simdjson](https://github.com/simdjson/simdjson) library what exports a C style `validate_utf8` function,
ready to be used in FreePascal programs.

For Intel(R) Core(TM) i5-8300H CPU @ 2.30GHz *validation speed is ~43.2 GB/s*

# How to build

- copy (or symlink) `simdjson.cpp` and `simdjson.h` from https://github.com/simdjson/simdjson/tree/master/singleheader into lib folder
- run lib/build.sh to build a c wrapper for C++ simdjson

# How to use in FPC program
Usage sample (and speed test) is in `utf8validate.lpr`.

Sample can be compiled using `build_fpc.sh` (expect mORMot1 to be copied or sym-linked into ./lib/Synopse)

For realistic speed test pass a path to a big valid UTF8 file as program parameter.