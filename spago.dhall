{ name = "proact-todo"
, dependencies =
  [ "console"
  , "effect"
  , "pairing"
  , "proact"
  , "profunctor-lenses"
  , "psci-support"
  , "react"
  , "react-dom"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
