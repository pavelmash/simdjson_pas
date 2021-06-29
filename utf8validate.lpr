program utf8validate;
uses
  sysutils, SynCommons;

function validate_utf8(p: PChar; len: PtrUInt): boolean;
  cdecl; external 'libutf8fast' name 'validate_utf8';

var
  str: RawByteString;
  T: TPrecisionTimer;
  i: PtrInt;
  r: boolean;
  pc, ss: PChar;
  L: PtrInt;


begin
  if paramstr(1) = '' then begin
    writeln('Usage: utf8validate /path/to/file_for_validation');
    exitCode := 1;
    exit;
  end;

  str := StringFromFile(paramstr(1)); r := false;
  // choose iteration count to got ~10Gb UTF8 text
  L := (10 * 1024 * 1024 * 1024) div length(str);
  writeln('Iterating ', L, ' times over ', length(str), ' bytes string (~10Gb)...');
  T.Start;
  for i := 0 to L-1 do
    r := IsValidUTF8(str);
  writeln('Validate PAS  to ', r, ' ', T.SizePerSec(length(str) * L));

  T.Start;
  for i := 0 to L-1 do
    r := validate_utf8(pointer(str), length(str));
  writeln('Validate SIMD to ', r, ' ', T.SizePerSec(length(str) * L));

  T.Start;
  for i := 0 to L-1 do begin
    pc := pointer(str);
    while pc^ <> #0 do inc(pc);
  end;
  writeln('Dummy while loop      ', T.SizePerSec(length(str) * L));

  T.Start;
  for i := 0 to L-1 do begin
    pc := pointer(str); ss := pc;
    while (pc^ <> #0) and (pc - ss < length(str) - 4) do begin
      inc(pc); inc(pc); inc(pc); inc(pc);
    end;
  end;
  writeln('4 iter while loop     ', T.SizePerSec(length(str) * L));
end.
