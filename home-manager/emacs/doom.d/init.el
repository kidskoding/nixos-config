(doom! :input
       ;;bidi
       ;;chinese
       ;;japanese
       ;;layout

       :completion
       ;;company
       (corfu +orderless)
       ;;helm
       ;;ido
       ;;ivy
       vertico

       :ui
       ;;deft
       doom
       dashboard
       ;;doom-quit
       ;;(emoji +unicode)
       hl-todo
       ;;indent-guides
       ;;ligatures
       ;;minimap
       modeline
       ;;nav-flash
       ;;neotree
       ophints
       (popup +defaults)
       ;;smooth-scroll
       ;;tabs
       ;;treemacs
       ;;unicode
       (vc-gutter +pretty)
       vi-tilde-fringe
       ;;window-select
       workspaces
       zen

       :editor
       file-templates
       fold
       ;;(format +onsave)
       ;;god
       ;;lispy
       ;;multiple-cursors
       ;;objed
       ;;parinfer
       ;;rotate-text
       snippets
       (whitespace +guess +trim)
       word-wrap

       :emacs
       (dired +dirvish)
       electric
       ;;eww
       ;;ibuffer
       tramp
       undo
       vc

       :term
       ghostel

       :checkers
       syntax
       ;;(spell +flyspell)
       ;;grammar

       :tools
       ;;ansible
       ;;biblio
       ;;collab
       ;;debugger
       direnv
       docker
       editorconfig
       ;;ein
       (eval +overlay)
       lookup
       ;;llm
       lsp
       magit
       make
       ;;pass
       pdf
       terraform
       ;;tmux
       tree-sitter
       ;;upload

       :os
       (:if (featurep :system 'macos) macos)
       ;;tty

       :lang
       ;;ada
       ;;(agda +local)
       ;;beancount
       (cc +lsp +tree-sitter)
       ;;clojure
       ;;common-lisp
       ;;coq
       ;;crystal
       (csharp +lsp)
       data
       ;;(dart +flutter)
       ;;dhall
       ;;elixir
       (elm +lsp)
       emacs-lisp
       ;;erlang
       ;;ess
       ;;factor
       ;;faust
       ;;fortran
       ;;fsharp
       ;;fstar
       ;;gdscript
       (go +lsp +tree-sitter)
       (graphql +lsp)
       ;;haskell
       ;;hy
       ;;idris
       json
       ;;janet
       (java +lsp +tree-sitter)
       (javascript +lsp +tree-sitter)

       ;; must run: `julia -e 'using Pkg; Pkg.add("LanguageServer")'`
       ;; after installing
       (julia +lsp)

       kotlin
       (latex +latexmk +cdlatex +fold)
       ;;lean
       ;;ledger
       (lua +lsp +tree-sitter)
       markdown
       ;;nim
       (nix +lsp +tree-sitter)
       ;;ocaml
       ;;odin
       (org +pretty)
       (php +lsp +tree-sitter)
       ;;plantuml
       ;;graphviz
       ;;purescript
       (python +lsp +pyright +tree-sitter +uv)
       ;;qt
       ;;racket
       ;;raku
       rest
       ;;rst
       (ruby +lsp +tree-sitter)
       (rust +lsp +tree-sitter)
       ;;scad
       ;;scala
       ;;(scheme +guile)
       sh
       ;;sml
       ;;solidity
       ;;swift
       ;;terra
       (web +tree-sitter)
       (yaml +lsp +tree-sitter)
       (zig +lsp +tree-sitter)

       :email
       ;;(mu4e +org +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       ;;calendar
       ;;emms
       ;;everywhere
       ;;irc
       ;;(rss +org)

       :config
       ;;literate
       (default +bindings +smartparens))
