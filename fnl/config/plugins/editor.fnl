(vim.pack.add ["https://github.com/windwp/nvim-autopairs"
               "https://github.com/NMAC427/guess-indent.nvim"
               "https://github.com/kylechui/nvim-surround"
               "https://github.com/okuuva/auto-save.nvim"
               "https://github.com/mechatroner/rainbow_csv"
               "https://github.com/MeanderingProgrammer/render-markdown.nvim"
               "https://github.com/nvim-lua/plenary.nvim"
               "https://github.com/stevearc/oil.nvim"
               {:src "https://github.com/ThePrimeagen/harpoon"
                :version :harpoon2}])

(local autopairs (require :nvim-autopairs))
(local guess-indent (require :guess-indent))
(local surround (require :nvim-surround))
(local auto-save (require :auto-save))
(local render-markdown (require :render-markdown))
(local oil (require :oil))
(local harpoon (require :harpoon))

(autopairs.setup {})
(guess-indent.setup {})
(surround.setup {})
(render-markdown.setup {:enabled false :latex {:enabled false}})
(oil.setup {:win_options {:cursorline true}})
(harpoon:setup {:settings {:save_on_toggle true}})

(fn autosave? [buf]
  (and (= (. vim.bo buf :buftype) "")
       (not= (. vim.bo buf :filetype) :gitcommit)))

(auto-save.setup {:condition autosave?
                  :trigger_events {:defer_save [:InsertLeave
                                                :TextChanged
                                                :TextChangedI]}})

(fn map [key action desc]
  (vim.keymap.set :n key action {: desc}))

(map :<leader>mr "<cmd>RenderMarkdown toggle<CR>" "Toggle Markdown render")
(map :<leader>mp "<cmd>RenderMarkdown preview<CR>" "Markdown preview split")

(vim.keymap.set :n "-" :<cmd>Oil<CR> {:desc "Browse parent directory"})
(vim.keymap.set :n :<leader>H #(: (harpoon:list) :add) {:desc "Harpoon file"})
(vim.keymap.set :n :<C-e> #(harpoon.ui:toggle_quick_menu (harpoon:list))
                {:desc "Harpoon menu"})

(each [i key (ipairs [:<C-h> :<C-j> :<C-k> :<C-l>])]
  (vim.keymap.set :n key #(: (harpoon:list) :select i)
                  {:desc (.. "Harpoon file " i)}))
