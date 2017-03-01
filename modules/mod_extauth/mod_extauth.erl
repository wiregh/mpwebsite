%%%-------------------------------------------------------------------
%%% @author enoch
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. Jan 2017 2:09 AM
%%%-------------------------------------------------------------------
-module(mod_extauth).
-author("enoch").
%% @doc Provides JSON Web Token authentication for Zotonic API calls.


-mod_title("JWT API service authentication").
-mod_description("Provides JSON Web Token authentication for Zotonic API calls.").
-mod_prio(500).

-include_lib("zotonic.hrl").
-include_lib("jwt/include/jwt.hrl").

-export([


]).
