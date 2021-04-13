module SharedTemplate exposing (..)

import Document exposing (Document)
import Html exposing (Html)
import Pages.PagePath exposing (PagePath)
import Pages.StaticHttp as StaticHttp
import Route exposing (Route)


type alias SharedTemplate sharedMsg sharedModel sharedStaticData mappedMsg =
    { init :
        Maybe
            { path :
                { path : PagePath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : Maybe Route
            }
        -> ( sharedModel, Cmd sharedMsg )
    , update : sharedMsg -> sharedModel -> ( sharedModel, Cmd sharedMsg )
    , view :
        sharedStaticData
        ->
            { path : PagePath
            , frontmatter : Maybe Route
            }
        -> sharedModel
        -> (sharedMsg -> mappedMsg)
        -> Document mappedMsg
        -> { body : Html mappedMsg, title : String }
    , staticData : StaticHttp.Request sharedStaticData
    , subscriptions : PagePath -> sharedModel -> Sub sharedMsg
    , onPageChange :
        Maybe
            ({ path : PagePath
             , query : Maybe String
             , fragment : Maybe String
             }
             -> sharedMsg
            )
    }
