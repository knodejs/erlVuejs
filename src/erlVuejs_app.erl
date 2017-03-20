%%%-------------------------------------------------------------------
%% @doc erlVuejs public API
%% @end
%%%-------------------------------------------------------------------

-module(erlVuejs_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
    {'_', [
        {"/", test_handler, []}
    ]}
	]),
	{ok, _} = cowboy:start_clear(http, 100, [{port, 8080}], #{
		env => #{dispatch => Dispatch}
	}),
    io:format("Start App Port 8080 ~n"),
    erlVuejs_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
