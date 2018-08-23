module Franka.Ui.Main exposing (main)

import Dict exposing (Dict)
import Element exposing (Element, column, el, row, text)
import Element.Attributes exposing (padding, spacing)
import Franka.Lang exposing (Name, Path)
import Franka.Lang.Bootstrap as Bootstrap
import Franka.Lang.Command exposing (Command(..))
import Franka.Lang.Type as Type
import Franka.Ui.Styles exposing (Styles(..), stylesheet)
import Html exposing (beginnerProgram)


main : Program Never Model Msg
main =
    beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { typeContext : TypeContext
    }


type alias TypeContext =
    { aliases : Dict Path Type.Exp
    , types : Dict Path (List ( Name, List Type.Exp ))
    }


init : Model
init =
    { typeContext =
        { aliases = Dict.empty
        , types = Dict.empty
        }
    }


model : Model
model =
    Bootstrap.commands
        |> List.map ApplyCommand
        |> List.foldl update init



-- UPDATE


type Msg
    = ApplyCommand Command


update : Msg -> Model -> Model
update msg model =
    case msg of
        ApplyCommand cmd ->
            { model
                | typeContext = applyCommand cmd model.typeContext
            }


applyCommand : Command -> TypeContext -> TypeContext
applyCommand cmd ctx =
    case cmd of
        CreateTypeAlias { alias, exp } ->
            { ctx
                | aliases =
                    ctx.aliases
                        |> Dict.insert alias exp
            }

        CreateType { path } ->
            { ctx
                | types =
                    ctx.types
                        |> Dict.insert path []
            }

        AddConstructor { to, name, args } ->
            { ctx
                | types =
                    ctx.types
                        |> Dict.update to
                            (Maybe.map
                                (\cs ->
                                    List.append cs [ ( name, args ) ]
                                )
                            )
            }



-- VIEW


view : Model -> Html.Html msg
view model =
    Element.layout stylesheet <|
        column NoStyle
            [ padding 10
            , spacing 10
            ]
            [ text "Aliases"
            , column NoStyle
                [ padding 10
                ]
                (model.typeContext.aliases
                    |> Dict.toList
                    |> List.map
                        (\( alias, exp ) ->
                            text (toString alias)
                        )
                )
            , text "Types"
            , column NoStyle
                [ padding 10
                ]
                (model.typeContext.types
                    |> Dict.toList
                    |> List.concatMap
                        (\( path, constructors ) ->
                            [ text (toString path)
                            , column NoStyle
                                [ padding 10
                                ]
                                (constructors
                                    |> List.map
                                        (\( name, args ) ->
                                            text (toString name)
                                        )
                                )
                            ]
                        )
                )
            ]
