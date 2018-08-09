module Franka.Ui.Main exposing (main)

import Franka.Lang exposing (name, path)
import Franka.Lang.Command exposing (Command(..))
import Franka.Lang.Type exposing (app, ref)
import Html exposing (beginnerProgram, button, div, text)
import Html.Events exposing (onClick)


main =
    beginnerProgram { model = model, view = view, update = update }



-- MODEL


commands : List Command
commands =
    [ CreateTypeAlias
        { alias = path "franka.lang.name"
        , exp = app (ref "list") [ ref "string" ]
        }
    , CreateTypeAlias
        { alias = path "franka.lang.path"
        , exp = app (ref "list") [ ref "franka.lang.name" ]
        }
    , CreateUnionType { path = path "franka.lang.type.exp" }
    , AddCaseToUnion
        { union = path "franka.lang.type.exp"
        , tag = name "ref"
        , args = [ ref "franka.lang.path" ]
        }
    , AddCaseToUnion
        { union = path "franka.lang.type.exp"
        , tag = name "app"
        , args = [ ref "franka.lang.type.exp", ref "franka.lang.type.exp" ]
        }
    ]


model =
    0



-- UPDATE


type Msg
    = Increment
    | Decrement


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]
