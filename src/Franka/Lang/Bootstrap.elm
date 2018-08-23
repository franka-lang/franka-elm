module Franka.Lang.Bootstrap exposing (..)

import Franka.Lang exposing (name, path)
import Franka.Lang.Command exposing (Command(..))
import Franka.Lang.Type exposing (app, record, ref, tuple)


commands : List Command
commands =
    [ CreateTypeAlias
        { alias = path "franka.lang.name"
        , exp = app [ ref "list.list", ref "string.string" ]
        }
    , CreateTypeAlias
        { alias = path "franka.lang.path"
        , exp = app [ ref "list.list", ref "franka.lang.name" ]
        }
    , CreateType { path = path "franka.lang.type.exp" }
    , AddConstructor
        { to = path "franka.lang.type.exp"
        , name = name "bottom"
        , args = [ ref "string.string" ]
        }
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
    , AddConstructor
        { to = path "franka.lang.type.exp"
        , name = name "tuple"
        , args = [ app [ ref "list.list", ref "franka.lang.type.exp" ] ]
        }
    , AddConstructor
        { to = path "franka.lang.type.exp"
        , name = name "record"
        , args = [ app [ ref "list.list", tuple [ ref "franka.lang.name", ref "franka.lang.type.exp" ] ] ]
        }
    , CreateType { path = path "franka.lang.command.command" }
    , AddConstructor
        { to = path "franka.lang.command.command"
        , name = name "create_type_alias"
        , args =
            [ record
                [ ( name "alias", ref "franka.lang.name" )
                , ( name "exp", ref "franka.lang.type.exp" )
                ]
            ]
        }
    , AddConstructor
        { to = path "franka.lang.command.command"
        , name = name "create_type"
        , args =
            [ record
                [ ( name "path", ref "franka.lang.path" )
                ]
            ]
        }
    , AddConstructor
        { to = path "franka.lang.command.command"
        , name = name "add_constructor"
        , args =
            [ record
                [ ( name "to", ref "franka.lang.path" )
                , ( name "name", ref "franka.lang.name" )
                , ( name "args", app [ ref "list.list", ref "franka.lang.type.exp" ] )
                ]
            ]
        }
    ]
