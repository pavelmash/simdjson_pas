#include "simdjson.h"

extern "C" {
  int validate_utf8(const char * buf, unsigned long len) {
    return simdjson::validate_utf8(buf, len);
  }
}
