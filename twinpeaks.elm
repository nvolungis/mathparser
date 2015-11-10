import Html exposing (..)
import String exposing (..)
import Result exposing (Result)
-- import Tree exposing (..)


-- model --


type alias Metric =
  { id : Int
  , title : String
  , count : Int
  }


type alias State =
  { metrics: List Metric
  }


initialState : State
initialState =
  { metrics = [
    { id = 1
    , title = "Metric 1"
    , count = 10 }, 
    
    { id = 2
    , title = "Metric 2"
    , count = 20 }
  ]}


nullMetric : Metric
nullMetric =
  { id = -1
  , title = "Not Found"
  , count = 0
  }


equationString : List String
equationString =
  ["1", "+", "2"]


interpolateEquationVals : List String -> String
interpolateEquationVals equation =
  List.foldl ( \val final -> final ++ (interpolateVal val)) "" equation 
  

interpolateVal : String -> String
interpolateVal str =
  maybeMatch str

  
maybeMatch : String -> String
maybeMatch str =
  case String.toInt str of
    Ok id ->
      toString (getMetricCount id)

    Err _ ->
      " " ++ str ++ " "


getMetricTitle : Int -> String
getMetricTitle int =
  (getMetric int).title


getMetricCount : Int -> Int
getMetricCount int =
  (getMetric int).count


getMetric : Int -> Metric
getMetric int =
  let
    maybeMetric = List.head (List.filter (\metric -> metric.id == int) initialState.metrics)

  in
    case maybeMetric of
      Just a -> 
        a

      Nothing ->
        nullMetric
       



-- view --


titleView : Html
titleView =
  h1 [] [ text "Configurable Metrics" ]


metricsView : List Metric -> Html
metricsView metrics =
  let
    items = List.map metricView metrics
  in
    ul [] items


metricView : Metric -> Html
metricView metric =
  li [] [ text (toString metric.count) ]


equationView : List Metric -> Html
equationView metrics =
  let
    vals = interpolateEquationVals equationString
  in
    h1 [] [ text vals ] 


view : State -> Html
view state =
  div [] [ 
    titleView,
    metricsView state.metrics,
    equationView state.metrics
  ]


main : Html
main =
  view initialState

