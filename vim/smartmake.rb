#!/usr/bin/env ruby
# 2017 Daniel Varga (vargad88@gmail.com)

require 'fileutils'
require 'shellwords'

def find_project_root(dir)
    return nil if dir == '/'
    has_cmakelists = false
    has_build_dir = File.directory?(dir+"/build")
    if File.directory?(dir+"/.git")
        return dir if has_build_dir
    end
    if File.file?(dir+"/CMakeLists.txt")
        has_cmakelists = true
        return dir if has_build_dir && File.read(dir+"/CMakeLists.txt") =~ /project([^)]+)/
    end
    parent = File.dirname(dir)
    root = find_project_root(parent)
    return dir if root.nil? && has_cmakelists && has_build_dir
    return root
end

CURRENT_FILE=$*[0]
CORES=`cat /proc/cpuinfo | grep processor | wc -l`.to_i
PROJECT_ROOT = find_project_root(Dir.pwd)

if PROJECT_ROOT.nil?
    if File.exists? 'Makefile'
        pid = spawn("make")
        Process.wait2 pid
        exit 0
    end

    if File.exists? 'Rakefile'
        pid = spawn("rake")
        Process.wait2 pid
        exit 0
    end

    file_content = File.read(CURRENT_FILE)
    if file_content.include?("#include <avr/") || file_content.include?("#include <avrcpp")
        system("/home/dev/arduino/compile.sh", CURRENT_FILE)
        exit 0
    end

    puts "Can't find project root. It should have a build directory!"
    exit 1
end

puts "Args: #{$*}"

puts "Project: #{PROJECT_ROOT}"
pid = spawn("cd #{(PROJECT_ROOT+'/build').shellescape} && cmake .. && make -j#{CORES}")
pid, result = Process.wait2 pid
if result.exitstatus == 0
    has_cppcheck_target = File.read("#{PROJECT_ROOT}/CMakeLists.txt").include? "add_custom_target(cppcheck"
    if has_cppcheck_target
        pid = spawn("cd #{(PROJECT_ROOT+'/build').shellescape} && make cppcheck")
        Process.wait2 pid
    end
end
