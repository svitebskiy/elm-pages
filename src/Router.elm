module Router exposing (Matcher, firstMatch)

import List.Extra
import Regex


firstMatch : List (Matcher route) -> String -> Maybe route
firstMatch matchers path =
    List.Extra.findMap
        (\matcher ->
            if Regex.contains (matcher.pattern |> toRegex) (normalizePath path) then
                tryMatch matcher path

            else
                Nothing
        )
        matchers


toRegex : String -> Regex.Regex
toRegex pattern =
    Regex.fromString pattern
        |> Maybe.withDefault Regex.never


type alias Matcher route =
    { pattern : String, toRoute : List (Maybe String) -> Maybe route }


tryMatch : { pattern : String, toRoute : List (Maybe String) -> Maybe route } -> String -> Maybe route
tryMatch { pattern, toRoute } path =
    path
        |> normalizePath
        |> submatches pattern
        |> toRoute


submatches : String -> String -> List (Maybe String)
submatches pattern path =
    Regex.find
        (Regex.fromString pattern
            |> Maybe.withDefault Regex.never
        )
        path
        |> List.concatMap .submatches


normalizePath : String -> String
normalizePath path =
    path
        |> stripLeadingSlash
        |> stripTrailingSlash


stripLeadingSlash : String -> String
stripLeadingSlash path =
    if path |> String.startsWith "/" then
        String.dropLeft 1 path

    else
        path


stripTrailingSlash : String -> String
stripTrailingSlash path =
    if path |> String.endsWith "/" then
        String.dropRight 1 path

    else
        path