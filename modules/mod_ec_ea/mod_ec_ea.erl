%%%-------------------------------------------------------------------
%%% @author enoch
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. Feb 2017 10:56 AM
%%%-------------------------------------------------------------------
-module(mod_ec_ea).
-author("enoch").


-include_lib("zotonic.hrl").
-mod_title("Electoral Module").
-mod_description("Electoral Area user tasks").
-mod_prio(500).
-mod_schema(1).
%% API
-export([manage_schema/2]).

manage_schema(install,Context)->
  ok.