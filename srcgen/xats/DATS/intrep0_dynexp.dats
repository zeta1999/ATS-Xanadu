(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Xanadu - Unleashing the Potential of Types!
** Copyright (C) 2018 Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: November, 2019
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

#staload "./../SATS/dynexp3.sats"

(* ****** ****** *)

#staload "./../SATS/intrep0.sats"

(* ****** ****** *)

implement
irerase_dpat
  (d3p0) =
let
//
val loc0 = d3p0.loc()
//
in
//
case+
d3p0.node() of
//
| D3Pint(tok) =>
  ir0pat_make_node
  (loc0, IR0Pint(tok))
| D3Pbtf(tok) =>
  ir0pat_make_node
  (loc0, IR0Pbtf(tok))
//
| D3Pany() =>
  ir0pat_make_node
  (loc0, IR0Pany((*void*)))
| D3Pvar(d2v) =>
  ir0pat_make_node(loc0, IR0Pvar(d2v))
//
| _(*rest-of-d3pat*) =>
  ir0pat_make_node(loc0, IR0Pnone1(d3p0))
//
end // end of [irerase_dpat]

(* ****** ****** *)

implement
irerase_dexp
  (d3e0) =
let
//
val loc0 = d3e0.loc()
//
in
//
case+
d3e0.node() of
//
| D3Eint(tok) =>
  ir0exp_make_node
  (loc0, IR0Eint(tok))
| D3Ebtf(tok) =>
  ir0exp_make_node
  (loc0, IR0Ebtf(tok))
| D3Estr(tok) =>
  ir0exp_make_node
  (loc0, IR0Estr(tok))
//
| D3Evar(d2v) =>
  ir0exp_make_node
  (loc0, IR0Evar(d2v))
| D3Econ1(d2c) =>
  ir0exp_make_node
  (loc0, IR0Econ1(d2c))
| D3Ecst1(d2c) =>
  ir0exp_make_node
  (loc0, IR0Ecst1(d2c))
//
| D3Efcst(d2c) =>
  ir0exp_make_node
  (loc0, IR0Efcst(d2c))
//
| D3Edapp
  (d3f0, npf1, d3es) =>
  let
  val irf0 = irerase_dexp(d3f0)
  val ires = irerase_dexplst(d3es)
  in
    ir0exp_make_node
    (loc0, IR0Edapp(irf0, npf1, ires))
  end
//
| _(*rest-of-d3exp*) =>
  ir0exp_make_node(loc0, IR0Enone1(d3e0))
//
end // end of [irerase_dexp]

(* ****** ****** *)

implement
irerase_dexpopt
  (opt) =
(
case+ opt of
| None() => None()
| Some(d3e) => Some(irerase_dexp(d3e))
) (* end of [irerase_dexpopt] *)

implement
irerase_dexplst
  (d3es) =
list_vt2t(d3es) where
{
val
d3es =
list_map<d3exp><ir0exp>
  (d3es) where
{
implement
list_map$fopr<d3exp><ir0exp>(d3e) = irerase_dexp(d3e)
}
} (* end of [irerase_dexplst] *)

(* ****** ****** *)

implement
irerase_decl
  (d3cl) =
let
//
val loc0 = d3cl.loc()
//
in
//
case+
d3cl.node() of
//
| D3Cstatic(tok, d3c1) =>
  (
  ir0dcl_make_node
    (loc0, IR0Cstatic(tok, irc1))
  ) where
  {
    val irc1 = irerase_decl(d3c1)
  }
| D3Cextern(tok, d3c1) =>
  (
  ir0dcl_make_node
    (loc0, IR0Cextern(tok, irc1))
  ) where
  {
    val irc1 = irerase_decl(d3c1)
  }
//
| D3Clocal(head, body) =>
  let
  val head = irerase_declist(head)
  val body = irerase_declist(body)
  in
    ir0dcl_make_node
      (loc0, IR0Clocal(head, body))
    // ir0dcl_make_node
  end
//
| D3Cvaldecl(tok, mopt, v3ds) =>
  let
    val
    irds = irerase_valdeclist(v3ds)
  in
    ir0dcl_make_node
    (loc0, IR0Cvaldecl(tok, mopt, irds))
  end
//
| _(*rest-of-d3ecl*) =>
  ir0dcl_make_node(loc0, IR0Cnone1(d3cl))
//
end // end of [irerase_decl]

implement
irerase_declist
  (d3cs) =
list_vt2t(ircs) where
{
val
ircs =
list_map<d3ecl><ir0dcl>
  (d3cs) where
{
implement
list_map$fopr<d3ecl><ir0dcl>(d3c) = irerase_decl(d3c)
}
} (* end of [irerase_declist] *)

(* ****** ****** *)

implement
irerase_valdecl
  (v3d0) =
let
val+
V3ALDECL(rcd) = v3d0
//
val loc = rcd.loc
val pat = rcd.pat
val def = rcd.def
//
val pat = irerase_dpat(pat)
val def = irerase_dexpopt(def)
//
in
IR0VALDECL(@{loc=loc,pat=pat,def=def})
end // end of [irerase_valdecl]

implement
irerase_valdeclist
  (v3ds) =
list_vt2t(irds) where
{
val
irds =
list_map<v3aldecl><ir0valdecl>
  (v3ds) where
{
implement
list_map$fopr<v3aldecl><ir0valdecl>(d3c) = irerase_valdecl(d3c)
}
} (* end of [irerase_valdeclist] *)

(* ****** ****** *)

(* end of [intrep0_erase.dats] *)