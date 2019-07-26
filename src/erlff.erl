-module(erlff).
-compile({parse_transform, ct_expand}).


%% Exports ---------------------------------------------------------------------

-export([ parse_transform/2 ]).

-export([ handle/2
        , effect/2
        , print_handler/1
        ]).

-export([ print/0 ]).

-export([ hello_world/0
        , test/0
        ]).


%% Effect definitions ----------------------------------------------------------

-define(print, print).


%% Type definitions ------------------------------------------------------------

-type handler() :: ok.

-type effect_type() :: ?print.

-type effect_args() :: [any()].

-type effect() :: {effect, effect_type(), effect_args()}.

-type result() :: ok.


%% API functions ---------------------------------------------------------------

parse_transform(Forms, Options) ->
  io:format("Forms=~p~nOptions=~p~n", [Forms, Options]),
  parse_trans:revert(Forms).

-spec handle(handler(), effect()) -> result().
handle(_Handler, _F) ->
  ok.

-spec print_handler(effect()) -> handler().
print_handler({effect, _Type, _Args}) ->
  ok.

print() ->
  ?print.

-spec effect(effect_type(), effect_args()) -> effect().
effect(Type, Args) ->
  %% TODO Make it a record?
  %% TODO Validation on Type (and possibly args)?
  {effect, Type, Args}.

test() ->
  ct_expand:term(lists:sort([3,5,2,1,4])).


%% Examples --------------------------------------------------------------------

-spec hello_world() -> effect().
hello_world() ->
  effect(?print, ["Hello world"]).
