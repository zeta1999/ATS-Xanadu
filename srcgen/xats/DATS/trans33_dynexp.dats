(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Xanadu - Unleashing the Potential of Types!
** Copyright (C) 2019 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Start Time: September, 2019
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

#staload "./../SATS/basics.sats"

(* ****** ****** *)

#staload "./../SATS/staexp2.sats"
#staload "./../SATS/statyp2.sats"
#staload "./../SATS/dynexp2.sats"
#staload "./../SATS/dynexp3.sats"

(* ****** ****** *)

#staload "./../SATS/trans33.sats"

(* ****** ****** *)

local

in

implement
trans33_dexp
  (d3e0) = let
//
(*
val loc0 = d3e0.loc()
*)
val ((*void*)) =
println!
("trans33_dexp: d3e0 = ", d3e0)
//
in
//
case+
d3e0.node() of
//
| D3Eint _ => d3e0
| D3Ebtf _ => d3e0
| D3Echr _ => d3e0
| D3Eflt _ => d3e0
| D3Estr _ => d3e0
//
| D3Enone0 _ => d3e0
| D3Enone1 _ => d3e0
//
| _ (* rest-of-d3exp *) => d3e0
//
end // end of [trans33_dexp]

end // end of [local]

(* ****** ****** *)

implement
trans33_dexpopt
  (opt) =
(
case+ opt of
| None() => None()
| Some(d3e) => Some(trans33_dexp(d3e))
) (* end of [trans33_dexpopt] *)

implement
trans33_dexplst
  (d3es) =
list_vt2t(d3es) where
{
val
d3es =
list_map<d3exp><d3exp>
  (d3es) where
{
implement
list_map$fopr<d3exp><d3exp>(d3e) = trans33_dexp(d3e)
}
} (* end of [trans33_dexplst] *)

(* ****** ****** *)

local

in

implement
trans33_decl
  (d3c0) = let
//
(*
val loc0 = d3c0.loc()
*)
val ((*void*)) =
println!
("trans33_decl: d3c0 = ", d3c0)
//
in
//
case+
d3c0.node() of
//
| D3Cnone0 _ => d3c0
| D3Cnone1 _ => d3c0
| _ (* rest-of-d3ecl *) => d3c0
//
end // end of [trans33_decl]

end // end of [local]

(* ****** ****** *)

implement
trans33_declist
  (d3cs) =
list_vt2t(d3cs) where
{
val
d3cs =
list_map<d3ecl><d3ecl>
  (d3cs) where
{
implement
list_map$fopr<d3ecl><d3ecl>(d3c) = trans33_decl(d3c)
}
} (* end of [trans33_declist] *)

(* ****** ****** *)

(* end of [xats_trans33_dynexp.dats] *)
