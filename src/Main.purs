{-
  @license MIT
  Main.purs
-}

module Main
  ( main
  )
where

import Data.Maybe (fromJust)
import Effect (Effect)
import Partial.Unsafe (unsafePartial)
import Prelude
import React (component, createLeafElement) as React
import ReactDOM (render) as React
import Todo (empty, todo) as Todo
import Todo.Program (render) as Todo
import Web.DOM.NonElementParentNode (getElementById) as DOM
import Web.HTML.HTMLDocument (toNonElementParentNode) as DOM
import Web.HTML (window) as DOM
import Web.HTML.Window (document) as DOM

main :: Effect Unit
main =
  unsafePartial
    do
    window <- DOM.window
    document <- map DOM.toNonElementParentNode $ DOM.document window
    element <- map fromJust $ DOM.getElementById "app" document
    void $ React.render appElement element
  where
  appClass = React.component "App" appComponent

  appComponent this =
    pure { state : Todo.empty, render : Todo.render this Todo.todo }

  appElement = React.createLeafElement appClass { }
