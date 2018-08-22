module Franka.Lang.Command exposing (..)

import Franka.Lang exposing (Name, Path, path)
import Franka.Lang.Type as Type


type Command
    = CreateTypeAlias { alias : Path, exp : Type.Exp }
    | CreateType { path : Path }
    | AddConstructor { to : Path, name : Name, args : List Type.Exp }
