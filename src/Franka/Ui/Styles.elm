module Franka.Ui.Styles exposing (..)

import Style


type Styles
    = NoStyle


stylesheet : Style.StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ Style.style NoStyle
            []
        ]
