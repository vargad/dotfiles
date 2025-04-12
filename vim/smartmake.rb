#!/usr/bin/env ruby
# 2017, 2018, 2019, 2020, 2023 Daniel Varga (vargad88@gmail.com)


require 'etc'
require 'fileutils'
require 'json'
require 'shellwords'



HEADER_EXT=[".h", ".hxx", ".hh", ".hpp", ".H"]
CPP_EXT=[".cc", ".cxx", ".cpp", ".C"]


CURRENT_FILE=$*[0]
CURRENT_DIRNAME=File.expand_path(File.dirname($*[0]))
CORES=Etc.nprocessors


IS_RUST = CURRENT_FILE.end_with? ".rs"
IS_CPP =  CPP_EXT.include? File.extname(CURRENT_FILE)


def find_project_root(dir)
    return nil if dir == '/'

    if File.file?(dir+"/CMakeLists.txt")
        return dir if File.read(dir+"/CMakeLists.txt") =~ /project([^)]+)/
    end
    if File.file?(dir+"/Makefile")
        # TODO try to find the topmost one
        return dir
    end
    if File.file?(dir+"/Rakefile")
        return dir
    end
    if File.file?(dir+"/Cargo.toml") && IS_RUST
        return dir
    end

    if File.directory?(dir+"/.git")
        return nil
    end
    parent = File.dirname(dir)
    root = find_project_root(parent)
    return root
end


PROJECT_ROOT = find_project_root(CURRENT_DIRNAME)



if PROJECT_ROOT.nil?
    if IS_CPP
        content = File.read(CURRENT_FILE)
        if content =~ /^int main\(/
            cxx = ENV["CXX"] || "g++"
            spawn(cxx, "-ggdb", "-Wall", "-Wextra", "-O2", CURRENT_FILE, "-o", File.basename(CURRENT_FILE, ".*"))
            return
        end
    end

    puts "Can't find project root. It should have a build directory!"
    exit 1
end


puts "Project: #{PROJECT_ROOT}"

if File.file? PROJECT_ROOT+"/CMakeLists.txt"
    pid = spawn("cd #{(PROJECT_ROOT+'/build').shellescape} && cmake .. && make -j#{CORES}")
    pid, result = Process.wait2 pid
    if result.exitstatus == 0
        has_cppcheck_target = File.read("#{PROJECT_ROOT}/CMakeLists.txt").include? "add_custom_target(cppcheck"
        if has_cppcheck_target
            pid = spawn("cd #{(PROJECT_ROOT+'/build').shellescape} && make cppcheck")
            Process.wait2 pid
        end
    end
elsif File.file? PROJECT_ROOT+"/Makefile"
    pid = spawn("make")
    Process.wait2 pid
elsif File.file? PROJECT_ROOT+"/Rakefile"
    pid = spawn("rake --verbose")
    Process.wait2 pid
elsif File.file? PROJECT_ROOT+"/Cargo.toml"
    args = ARGV[1..-1]
    pid = spawn("cargo #{args.empty? ? 'build' : args.join(' ').shellescape} --manifest-path=#{PROJECT_ROOT.shellescape}/Cargo.toml")
    Process.wait2 pid
else
    $stderr.puts "Unknown build system"
    exit 1
end
