%%%-------------------------------------------------------------------
%%% @author enoch
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Jan 2017 5:20 AM
%%%-------------------------------------------------------------------
-module(m_ec).
-author("enoch").

%% API
-behaviour(gen_model).

-export([
  m_find_value/3,
  m_to_list/2,
  m_value/2,
  install/1
]).

-include_lib("zotonic.hrl").
% ... We will add our m_find_value functions here

% ... Before ending with the final fallback:
m_find_value(_, _, _Context) ->
  undefined.

% This is the default m_to_list if we don't have any list values.
% We will come back to this in a minute
m_to_list(_, _Context) ->
  [].

% The function that we can ignore
m_value(_, _Context) ->
  undefined.

install(Context) ->
  case z_db:table_exists(ec_region, Context) of
    false ->
      lager:info("Creating EC Regions Table..."),
      [] = z_db:q("
      create table ec_region(
      id serial not null,
      code text not null,
      name text not null,
      primary key(id))", Context),
      lager:info("Populating Regions.."),
     ec_install_data:populate_regions(Context);
    true ->
      ok
  end,
  case z_db:table_exists(ec_district, Context) of
    false->
      lager:info("Creating EC Districts Table..."),
      [] = z_db:q("
      create table ec_district(
      id serial not null,
      region_id integer REFERENCES ec_region,
      code text not null,
      name text not null,
      primary key(id))", Context),
      lager:info("Populating Districts.."),
      ec_install_data:populate_districts(Context);
    true ->
      ok

  end,
  case z_db:table_exists(ec_constituency, Context) of
    false->
      lager:info("Creating EC Constityencies Table..."),
      [] = z_db:q("
      create table ec_constituency(
      id serial not null,
      district_id integer REFERENCES ec_district,
      code text not null,
      name text not null,
      primary key (id))", Context),
      lager:info("Populating Constituencies.."),
      ec_install_data:populate_constituencies(Context);
    true ->
      ok
  end,
  case z_db:table_exists(ec_elect_area, Context) of
    false->
      lager:info("Creating EC ElectoralAreas Table..."),
      [] = z_db:q("
      create table ec_elect_area(
      id serial not null,
      constituency_id integer REFERENCES ec_constituency,
      code text not null,
      name text not null,
      primary key (id))", Context),
      lager:info("Populating Electoral Areas.."),
      ec_install_data:populate_elect_areas(Context);
    true ->
      ok
  end,
  case z_db:table_exists(ec_polling_centre, Context) of
    false->
      lager:info("Creating EC Polling Centres Table..."),
      [] = z_db:q("
      create table ec_polling_centre(
      id serial not null,
      elect_area_id integer REFERENCES ec_elect_area,
      code text not null,
      name text not null,
      primary key (id))", Context),
      lager:info("Populating Polling Centres.."),
      ec_install_data:populate_polling_centres(Context);
true ->
ok
  end.

