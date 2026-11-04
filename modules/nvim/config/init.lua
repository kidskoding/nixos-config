package.path = package.path:gsub("%./%?%.lua;", "")
package.cpath = package.cpath:gsub("%./%?%.so;", "")

require("config")
