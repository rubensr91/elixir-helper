defmodule BehaviourTest do
    @callback start(binary()) :: tuple()

    @callback return(tuple()) :: binary()
end