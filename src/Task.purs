{-
  @license MIT
  Task.purs
-}

module Task
  ( State
  , _completed
  , _description
  , empty
  , task
  )
where

import Control.Monad.Reader (ask)
import Data.Lens (Lens', (.=), (^.), lens)
import Data.Profunctor (lcmap)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import React (ReactElement) as R
import React.DOM (button, input, span', td, text, tr) as R
import React.DOM.Props
  (_type, checked, className, onChange, onClick, title) as R
import Prelude
import Proact.React (dispatcher) as P
import Todo.Program (IndexedComponent, (..))
import Unsafe.Coerce (unsafeCoerce)

-- | A type synonym for the state of a task component.
type State =
  { completed :: Boolean
  , description :: String
  }

-- | Gets or sets whether the task completed or not.
_completed :: Lens' State Boolean
_completed = lens _.completed (_ { completed = _ })

-- | Gets or sets the task description.
_description :: Lens' State String
_description = lens _.description (_ { description = _ })

-- | The initial state of the component.
empty :: State
empty =
  { completed : false
  , description : ""
  }

-- | The task component.
task :: (Int -> Effect Unit) -> IndexedComponent Int State R.ReactElement
task onDelete =
  do
  Tuple index state <- ask
  dispatcher <- map (..) P.dispatcher

  pure $ view dispatcher index state
  where
  view dispatcher index state =
    (R.tr [ R.className "row" ])
      [
        R.td
          [ R.className "col-1" ]
          [
            R.input
              [ R._type "checkbox"
              , R.className "checkbox"
              , R.checked $ state ^. _completed
              , R.title "Mark as completed"
              , R.onChange $ lcmap fromInputEvent $ dispatcher onCompleted
              ]
          ]
      , R.td [ R.className "col-10" ] [ R.text $ state ^. _description ]
      ,
        R.td
          [ R.className "col-1" ]
          [
            R.button
              [ R._type "button"
              , R.className "close"
              , R.onClick \_ -> onDelete index
              ]
              [ R.span' [ R.text "×" ] ]
          ]
      ]

  fromInputEvent event = { checked : (unsafeCoerce event).target.checked }

  onCompleted event = _completed .= event.checked
