local awful = require("awful")
local naughty = require("naughty")

function file_readable(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function require_optional(lib)
    if file_readable(awful.util.getdir("config") .. '/' .. lib ..'.lua') or file_readable(awful.util.getdir("config") .. '/' .. lib) then
        local status, result = pcall(require, lib)
        if (not status) then
            naughty.notify({ text="Error: " .. result, bg="#FF0000" })
        end
        return status, result
    end
    return false, false
end


