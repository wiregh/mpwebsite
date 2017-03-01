%%%-------------------------------------------------------------------
%%% @author enoch
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. Jan 2017 3:34 AM
%%%-------------------------------------------------------------------
-module(service_extauth_logon).
-author("enoch").
-include_lib("zotonic.hrl").
-include_lib("jwt/include/jwt.hrl").
%% API
-export([logon/1,process_post/1]).
-svc_title("Log in from outside.").
-svc_needauth(false).

%%handle post requests... only json post data supported!
process_post(Context) ->
    logon(Context).


% Return a JWT token if successful
logon(Context) ->

    Args = z_context:get_q_all(Context),
    ContextAuth = controller_logon:logon(Args, [], Context),
    User = z_acl:user(ContextAuth),
    case User of
        undefined -> {error, not_authenticated};
        _ ->
            Token = mod_service_auth_jwt:createToken(User, ContextAuth),
            jiffy:encode({[{id_token, Token}]})
%%         mochijson2:encode({struct, [{<<"id_token">>,<<Token/binary>>}]})
%%            Token
    end.


