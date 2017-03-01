%%%-------------------------------------------------------------------
%%% @author enoch
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Jan 2017 6:55 AM
%%%-------------------------------------------------------------------
-module(mod_ec).
-author("enoch").
-include_lib("zotonic.hrl").


-mod_title("EC Data").
-mod_description("Electoral Commission Ghana Polling Stations Data").
-mod_prio(500).
-mod_schema(1).
-mod_depends([mod_ec_ps,mod_ec_ea,mod_ec_const,mod_ec_dist,mod_ec_reg,mod_ec_nat]).
%% API
-export([manage_schema/2]).
manage_schema(install, Context) ->
  create_usergroups(Context),
  sort_usergroups(Context),
  m_ec:install(Context).

create_usergroups(Context)->
%%  z_datamodel:manage(?MODULE,
    #datamodel{

      resources =
      [

        {acl_user_group_pollingcentre,
          acl_user_group,
          [{title, <<"Polling Centre">>}]},
        {acl_user_group_electoralarea,
          acl_user_group,
          [{title, <<"Electoral Area">>}]},
        {acl_user_group_constituency,
          acl_user_group,
          [{title, <<"Constituency">>}]},
        {acl_user_group_district,
          acl_user_group,
          [{title, <<"District">>}]},
        {acl_user_group_regional,
          acl_user_group,
          [{title, <<"Regional">>}]},
        {acl_user_group_national,
          acl_user_group,
          [{title, <<"National">>}]}
      ],

      data = [
        {acl_rules, getrules()}
      ]

    }
%%    ,Context)
.


getrules()->
  [use_module(Usergroup_Modules) || Usergroup_Modules <- get_usergroup_modules()].
use_module({_,[]})->
  {};
use_module({UserGroup, [H|T]}) ->
  use_module({UserGroup,T}),
 {module, [
    {acl_user_group_id, UserGroup},
    {actions, [use]},
    {module, H}
  ]}.

get_usergroup_modules() ->
[
  {acl_user_group_pollingcentre,[mod_ec_ps]},
  {acl_user_group_electoralarea,[mod_ec_ea]},
  {acl_user_group_constituency,[mod_ec_const]},
  {acl_user_group_district,[mod_ec_dist]},
  {acl_user_group_regional,[mod_ec_reg]},
  {acl_user_group_national,[mod_nat]}

  ].



sort_usergroups(Context) ->
  R = fun(N) -> m_rsc:rid(N, Context) end,
%%  Tree = m_hierarchy:menu(acl_user_group, Context),
  NewTree = [{R(acl_user_group_anonymous),
    [{R(acl_user_group_members),
      [
        R(acl_user_group_pollingcentre),
        [
          R(acl_user_group_electoralarea),
          [
            R(acl_user_group_constituency),
            [
              R(acl_user_group_district),
              [
                R(acl_user_group_regional),
                [
                  R(acl_user_group_national),
                  []
                ]
              ]
            ]
          ]

        ],
        [{R(acl_user_group_editors),
          [{R(acl_user_group_managers),
            []
          }]
        }]
      ]
    }]
  }],
  m_hierarchy:save(acl_user_group, NewTree, Context).

