module Franka.Ui.Main exposing (main)

import Franka.Lang.Bootstrap as Bootstrap
import Franka.Lang.Command exposing (Command(..))
import Html exposing (beginnerProgram, button, div, li, text, ul)


main =
    beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { count : Int
    , types : List String
    }


init : Model
init =
    { count = 0
    , types = []
    }


model : Model
model =
    Bootstrap.commands
        |> List.foldl applyCommand init



-- UPDATE


type Msg
    = ApplyCommand Command


update msg model =
    case msg of
        ApplyCommand cmd ->
            applyCommand cmd model


applyCommand : Command -> Model -> Model
applyCommand cmd model =
    case cmd of
        CreateTypeAlias { alias } ->
            { model
                | types = model.types ++ [ toString alias ]
            }

        CreateType { path } ->
            { model
                | types = model.types ++ [ toString path ]
            }

        _ ->
            { model
                | count = model.count + 1
            }



-- VIEW


view model =
    div []
        [ text (toString model.count)
        , ul []
            (model.types
                |> List.map
                    (\t ->
                        li [] [ text t ]
                    )
            )
        ]
