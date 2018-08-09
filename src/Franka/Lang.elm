module Franka.Lang exposing (..)


type alias Name =
    List String


type alias Path =
    List Name


name : String -> Name
name str =
    String.split "_" str


path : String -> Path
path str =
    str
        |> String.split "."
        |> List.map name
