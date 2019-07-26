-module(effect_ex).

-compile({parse_transform, erlff}).

-export([ test/1 ]).

test(String) ->
  erlff:effect(erlff:print(), String).
