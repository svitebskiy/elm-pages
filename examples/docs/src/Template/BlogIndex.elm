module Template.BlogIndex exposing (Model, Msg, template)

import Element exposing (Element)
import Global
import GlobalMetadata
import Head
import Head.Seo as Seo
import Index
import Pages exposing (images)
import Pages.PagePath as PagePath exposing (PagePath)
import Pages.StaticHttp as StaticHttp
import Showcase
import SiteConfig
import Template exposing (DynamicPayload, StaticPayload, Template)
import TemplateMetadata exposing (BlogIndex)


type Msg
    = Msg


template : Template BlogIndex StaticData Model Msg
template =
    Template.template
        { view = view
        , head = head
        , staticData = staticData
        , init = init
        , update = update
        }


staticData :
    List ( PagePath Pages.PathKey, GlobalMetadata.Metadata )
    -> StaticHttp.Request StaticData
staticData siteMetadata =
    Showcase.staticRequest


type alias StaticData =
    List Showcase.Entry


init : BlogIndex -> ( Model, Cmd Msg )
init metadata =
    ( Model, Cmd.none )


update : BlogIndex -> Msg -> Model -> ( Model, Cmd Msg, Global.GlobalMsg )
update metadata msg model =
    ( Model, Cmd.none, Global.NoOp )


type alias Model =
    {}


view :
    DynamicPayload Model
    -> List ( PagePath Pages.PathKey, GlobalMetadata.Metadata )
    -> StaticPayload BlogIndex StaticData
    -> Global.RenderedBody
    -> Global.PageView Msg
view dynamicPayload allMetadata staticPayload rendered =
    { title = "elm-pages blog"
    , body =
        Element.column [ Element.width Element.fill ]
            [ Element.column [ Element.padding 20, Element.centerX ]
                [ Index.view allMetadata
                ]
            ]
    }


head : StaticPayload BlogIndex StaticData -> List (Head.Tag Pages.PathKey)
head staticPayload =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = images.iconPng
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = SiteConfig.tagline
        , locale = Nothing
        , title = "elm-pages blog"
        }
        |> Seo.website