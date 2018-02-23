{-
  @license MIT
  Program.purs
-}

module Todo.Program
  ( Component
  , EventHandler
  , IndexedComponent
  , (..)
  , _this
  , render
  )
where

import Data.Functor.Pairing (identity) as P
import Data.Identity (Identity(..))
import Data.Lens (Iso)
import Effect (Effect)
import Prelude
import Proact.React (Component, EventHandler, IndexedComponent, render) as P
import React (ReactElement, ReactThis, getState) as React

-- | An alias for Semigroupoid composition.
infixr 9 compose as ..

-- | A type synonym for a React Component with no additional side effects.
type Component s a = P.Component s Identity a

-- | A type synonym for an Event Handler with no additional side effects.
type EventHandler s a = P.EventHandler s Identity a

-- | A type synonym for an Indexed Component with no special side effects.
type IndexedComponent i s a = P.IndexedComponent i s Identity a

-- | An alias for the identity isomorphism.
_this :: forall a b . Iso a b a b
_this = identity

-- | Renders a `ReactElement` from a React Context and Proact Component.
render
  :: forall s
   . React.ReactThis { } { | s }
  -> Component { | s } React.ReactElement
  -> Effect React.ReactElement
render this component =
  do
  state <- React.getState this
  P.render P.identity Identity state this component
