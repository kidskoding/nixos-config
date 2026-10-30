(vim.pack.add ["https://github.com/folke/snacks.nvim"
               "https://github.com/folke/todo-comments.nvim"
               "https://github.com/folke/persistence.nvim"])

(local snacks (require :snacks))
(local persistence (require :persistence))

(persistence.setup)
(vim.opt.sessionoptions:remove :blank)

(fn open-project [dir]
  (vim.fn.chdir dir)
  (vim.cmd.Oil dir))

(local ferris-art
       ["                  .   ,.                      "
        "              ;. .xo.:xd',do  '.              "
        "          ..  ddodddddddddddoodo  .           "
        "          :dooddddddddddddddddddldd           "
        "       c:,odddddllllllllllllllllllo:,:.       "
        "       ,oooooolllllllllllllllllllllllo        "
        "    .ccoooolllllllllllllllllllllllllllccc     "
        "     loollllllllllllllllllllllllllllllll.     "
        "  .;:lllllllllllllllllllllllclllllllllllc;,   "
        "   .lllllllllllll{WWl} .lllc{WW.} clllllllllll    "
        "  .:llllllllllll  {x},  :ll, {x}  'llllllccccc'   "
        " ,lllllllllllllll    .ccc:    ;ccccccccccccc;."
        "ccc. l.:cccccccc:;;;:cccccc,,:ccccccccc y' cc,"
        " .ll  l  ;c:;:dddd;,':cc:,;dddd;:;.:c. y  .c. "
        "   ll      c,ddcc dd'        ccdd,c.      yy  "
        "    ll       .cc:.          .;::'        yy   "
        "               '::;'.    ..,;;.         yy    "])

(local ferris
       (icollect [i part (ipairs (vim.split (table.concat ferris-art "\n")
                                            "[{}]"))]
         {1 part :hl (if (= (% i 2) 0) :GruvboxFg0 :GruvboxOrange)}))

(local version (let [v (vim.version)]
                 (.. "NVIM v" v.major "." v.minor "." v.patch)))

(local dashboard {:enabled false
                  :formats {:icon (fn [item]
                                    (if (= item.icon :directory)
                                        (doto (snacks.dashboard.icon item.file
                                                                     item.icon)
                                          (tset :hl :icon))
                                        {1 item.icon :width 2 :hl :icon}))}
                  :preset {:keys [{:icon " "
                                   :key :p
                                   :desc "Open Project"
                                   :action #(snacks.picker.projects)}
                                  {:icon "󰈞 "
                                   :key :f
                                   :desc "File Browser"
                                   :action ":Oil ."}
                                  {:icon " "
                                   :key :r
                                   :desc "Recent Files"
                                   :action #(snacks.picker.recent)}
                                  {:icon " "
                                   :key :g
                                   :desc "Find Text"
                                   :action #(snacks.picker.grep)}
                                  {:icon " "
                                   :key :c
                                   :desc :Config
                                   :action #(open-project (vim.fn.stdpath :config))}
                                  {:icon "󰦛 "
                                   :key :s
                                   :desc "Restore Session"
                                   :action #(persistence.load {:last true})}
                                  {:icon " "
                                   :key :q
                                   :desc :Quit
                                   :action ":qa"}]}
                  :sections [{:text ferris :align :center :padding 2}
                             {:title "Recent Projects"
                              :section :projects
                              :action open-project
                              :padding 1}
                             {:section :keys :padding 1}
                             {:text [{1 version :hl :GruvboxBg4}]
                              :align :center}]})

(snacks.setup {:bigfile {:enabled true}
               : dashboard
               :indent {:enabled true}
               :lazygit {:configure false}
               :styles {:lazygit {:wo {:winhighlight "NormalFloat:Normal"}}}
               :picker {:enabled true
                        :sources {:explorer {:hidden true :ignored true}
                                  :projects {:confirm (fn [picker item]
                                                        (picker:close)
                                                        (when item
                                                          (open-project item.file)))
                                             :dev ["~/uiuc/go-mama-27/personal-projects"
                                                   "~/uiuc"
                                                   "~/contributing"
                                                   "~/playground"]}}}})

(let [icon snacks.util.icon]
  (set snacks.util.icon (fn [name cat opts]
                          (icon (if (= cat :file) (vim.fs.basename name) name)
                                cat opts))))

;; after snacks.setup so todo-comments registers its picker source
((. (require :todo-comments) :setup) {})

(fn map [key action desc]
  (vim.keymap.set :n key action {: desc}))

(map :<leader><space> #(snacks.picker.files) "Find files")
(map :<leader>/ #(snacks.picker.grep) "Search project")
(map :<leader>e #(snacks.picker.explorer) "File explorer")
(map :<leader>p #(snacks.picker.projects) "Switch project")
(map :<leader>h #(snacks.picker.help) "Search help pages")
(map :<leader>bb #(snacks.picker.buffers) "Switch buffer")
(map :<leader>bd #(snacks.bufdelete) "Close buffer")
(map :<leader>gz #(snacks.lazygit) :Lazygit)
(map :<leader>gB #(snacks.gitbrowse) "Open file on GitHub")
(map :<leader>gl #(snacks.picker.git_log_file) "File git history")
(map :<leader>xt #(snacks.picker.todo_comments) "Todo list")
(map :<leader>. #(snacks.scratch) "Toggle scratch buffer")
(map :<leader>S #(snacks.scratch.select) "Select scratch buffer")

;; some terminals send <C-_> for <C-/>
(vim.keymap.set [:n :t] :<C-/> #(snacks.terminal) {:desc "Toggle terminal"})
(vim.keymap.set [:n :t] :<C-_> #(snacks.terminal) {:desc :which_key_ignore})

;; add jk escape sequence for terminals, EXCEPT for lazygit!
(vim.api.nvim_create_autocmd :TermOpen
                             {:callback (fn [ev]
                                          (when (not (string.find ev.match
                                                                  :lazygit))
                                            (vim.keymap.set :t :jk
                                                            "<C-\\><C-n>"
                                                            {:buffer ev.buf
                                                             :desc "Exit terminal mode"})))})
