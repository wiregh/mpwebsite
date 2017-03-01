%%%-------------------------------------------------------------------
%%% @author enoch
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. Feb 2017 11:03 AM
%%%-------------------------------------------------------------------
-module(mod_ec_reg).
-author("enoch").

%% API
-export([]).
-include_lib("zotonic.hrl").
-mod_title("Regional Module").
-mod_description("Regional user tasks").
-mod_prio(500).
-mod_schema(1).
%% API
-export([manage_schema/2]).

manage_schema(install,Context)->
  ok.