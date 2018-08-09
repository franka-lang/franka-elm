module Franka.Lang.Type exposing (..)

import Franka.Lang exposing (Path, path)


type Exp
    = Ref Path
    | App Exp Exp


ref : String -> Exp
ref str =
    Ref (path str)


app : Exp -> List Exp -> Exp
app cons args =
    case args of
        [] ->
            cons

        head :: tail ->
            App cons (app head tail)
