module Franka.Ui.Main exposing (main)

import Franka.Lang exposing (name, path)
import Franka.Lang.Command exposing (Command(..))
import Franka.Lang.Type exposing (app, ref)
import Html exposing (beginnerProgram, button, div, li, text, ul)


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
    , CreateType { path = path "franka.lang.type.exp" }
    , AddConstructor
        { to = path "franka.lang.type.exp"
        , name = name "ref"
        , args = [ ref "franka.lang.path" ]
        }
    , AddConstructor
        { to = path "franka.lang.type.exp"
        , name = name "app"
        , args = [ ref "franka.lang.type.exp", ref "franka.lang.type.exp" ]
        }
    ]


model =
    commands



-- UPDATE


type Msg
    = NoMsg


update msg model =
    model



-- VIEW


view model =
    div []
        [ ul []
            (model
                |> List.map
                    (\c ->
                        li []
                            [ text (toString c) ]
                    )
            )
        ]
