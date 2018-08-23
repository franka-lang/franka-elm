module Franka.Lang.Type exposing (..)

import Franka.Lang exposing (Name, Path, path)


type Exp
    = Bottom String
    | Ref Path
    | App Exp Exp
    | Tuple Exp Exp
    | Record (List ( Name, Exp ))


bottom : String -> Exp
bottom msg =
    Bottom msg


ref : String -> Exp
ref str =
    Ref (path str)


app : List Exp -> Exp
app args =
    case args of
        [] ->
            bottom "App without arguments"

        [ single ] ->
            single

        head :: tail ->
            App head (app tail)


tuple : List Exp -> Exp
tuple elems =
    case elems of
        [] ->
            bottom "Tuple without arguments"

        [ single ] ->
            single

        head :: tail ->
            Tuple head (tuple tail)


record : List ( Name, Exp ) -> Exp
record fields =
    Record fields
