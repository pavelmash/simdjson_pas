rm -rf ./*.o

gcc -O3 -pthread -c -fpic utf8fast.cpp
gcc -O3 -fPIC -pthread -c -fpic simdjson.cpp
gcc -O3 -pthread -shared -o ../libutf8fast.so utf8fast.o simdjson.o
