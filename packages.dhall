let upstream =
  https://github.com/purescript/package-sets/releases/download/psc-0.13.8-20200615/packages.dhall sha256:5d0cfad9408c84db0a3fdcea2d708f9ed8f64297e164dc57a7cf6328706df93a
let overrides = {=}
let additions =
  { proact =
    { dependencies =
      [ "effect"
      , "mmorph"
      , "pairing"
      , "profunctor-lenses"
      , "react"
      , "react-dom"
      ]
    , repo = "https://github.com/alvart/purescript-proact"
    , version = ""
    }
  }
in upstream // overrides // additions
