-module(service_something_stats).
-author("Enoch Wilson>").

-svc_title("Retrieve uptime statistics of the system.").
-svc_needauth(true).

-export([process_get/1]).

-include_lib("zotonic.hrl").

process_get(_Context) ->
    Stats = [{count, 12310}, {uptime, 398}],
    z_convert:to_json(Stats).
