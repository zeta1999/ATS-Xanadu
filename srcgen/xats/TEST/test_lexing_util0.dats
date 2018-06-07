(* ****** ****** *)
(*
** HX-2018-05-16
** Unit testing. Kind of.
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload "./../SATS/lexing.sats"
//
(* ****** ****** *)

val a = 'a'
val A = 'A'
val EOL = '\n'
val NUL = '\000'

(* ****** ****** *)

local
//
#include "./../DATS/symbol.dats"
#include "./../DATS/filepath.dats"
#include "./../DATS/location.dats"
//
#include "./../DATS/lexbuf.dats"
#include "./../DATS/lexing_token.dats"
#include "./../DATS/lexing_util0.dats"
//
in
  // nothing
end // end of [local]

(* ****** ****** *)

local
//
#include
"./../../util/DATS/cblist.dats"
#include
"./../../util/DATS/Posix/cblist.dats"
//
in
  // nothing
end // end of [local]

(* ****** ****** *)
//
val () =
println!
("Hello from [test_lexing_util0]!")
//
(* ****** ****** *)

local
//
#staload
"./../SATS/lexbuf.sats"
#staload
"./../SATS/lexing.sats"
#staload
"./../SATS/location.sats"
//
#staload
"./../DATS/lexing_util0.dats"
//
#staload
"./../../util/SATS/cblist.sats"
#staload
"./../../util/SATS/Posix/cblist.sats"
#staload _ =
"./../../util/DATS/Posix/cblist.dats"
//
in
//
val
BSZ = i2sz(020)
val
BSZ = i2sz(0x100)
val-
~Some_vt(cbs) =
fpath_get_cblist
("./test_syntax.text", BSZ)
//
var buf: lexbuf
var pos: position
//
val (_) = position_initize(pos, 0, 0, 0)
//
val (_) = lexbuf_initize_cblist(buf, cbs)
//
val res =
ref<list0(tnode)>(nil0())
//
val (_) =
loop(buf) where
{
fun
loop
(buf:
&lexbuf >> _): void = let
  val tnd = lexing_tnode(buf)
  val (_) = println!("tnd = ", tnd)
  val (_) = res[] := cons0(tnd, res[])
in
  case+ tnd of
  | T_EOF() => () | _ (*non-EOF*) => loop(buf)
end // end of [loop]
}
//
val () =
list0_rforeach
(res[], lam(x) => fprint2_tnode(stdout_ref, x))
//
end // end of [local]

(* ****** ****** *)

implement main0((*void*)) = ((*void*))

(* ****** ****** *)

(* end of [test_lexing_util0.dats] *)

/**
 Is this one special?
 */

////

The rest is treated as comment:

'What?
'\000'
"This unclosed string is ill-formed!!!"
