#!/usr/bin/env ruby
# 2017, 2018, 2019, 2020 Daniel Varga (vargad88@gmail.com)

require 'json'
require 'fileutils'
require 'shellwords'


HEADER_EXT=["*.h", "*.hxx", "*.hh"]
CPP_EXT=[".cc", ".cxx", ".cpp"]

AVR_MCU="atmega328p"
AVR_F_CPU=16000000
AVR_COMPILE_COMMANDS_INCLUDE=["-I/usr/avr/include"]
AVR_OBJCOPY="avr-objcopy"
AVR_OBJDUMP="avr-objdump"
AVRDUDE="avrdude"
AVR_CXX="avr-g++"
AVR_FLAGS=["-DF_CPU=#{AVR_F_CPU}", "-mmcu=#{AVR_MCU}"]
AVR_CXXFLAGS=["-Wall", "-std=c++17", "-Os", "-fno-stack-protector",
      "-fno-exceptions", "-fno-rtti", "-fomit-frame-pointer"]



def arduino_build
    # update compile_commands.json
    compile_commands = []
    (HEADER_EXT+CPP_EXT).each { |ext|
        Dir.glob(CURRENT_DIRNAME+"/*"+ext) { |filename|
            compile_commands << {
                    directory: CURRENT_DIRNAME,
                    arguments: [*AVR_FLAGS, *AVR_CXXFLAGS, *AVR_COMPILE_COMMANDS_INCLUDE, "-include", File.expand_path("~/.vim/avr/compat.h")],
                    file: filename
                }
        }
    }
    File.write(CURRENT_DIRNAME+"/compile_commands.json", JSON.generate(compile_commands))

    unless CPP_EXT.include?(File.extname(CURRENT_FILE))
        puts "not a C++ file: #{CURRENT_FILE}"
        return
    end

    elffile=CURRENT_DIRNAME+"/build/"+File.basename(CURRENT_FILE, ".*")+".elf"
    hexfile=CURRENT_DIRNAME+"/build/"+File.basename(CURRENT_FILE, ".*")+".hex"

    if !File.exist?(elffile) || File.mtime(elffile) < File.mtime(CURRENT_FILE)
        return unless system(AVR_CXX, *AVR_FLAGS, *AVR_CXXFLAGS, CURRENT_FILE, "-o", elffile)
    end

    if $*.include? "upload"
        return unless system(AVR_OBJCOPY, "-O", "ihex", "-R", ".eeprom", elffile, hexfile)
        avrdude_port=(Dir.glob("/dev/ttyUSB*")+Dir.glob("/dev/ttyACM*"))[0]
        return unless system(AVRDUDE, "-p", AVR_MCU, "-P", avrdude_port, "-b", "57600", "-c", "arduino", "-U", "flash:w:#{hexfile}")
    end
end


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
    if File.file?(dir+"/Rakefile")
        return dir
    end
    parent = File.dirname(dir)
    root = find_project_root(parent)
    return dir if root.nil? && has_cmakelists && has_build_dir
    return root
end

CURRENT_FILE=$*[0]
CURRENT_DIRNAME=File.expand_path(File.dirname($*[0]))
CORES=`cat /proc/cpuinfo | grep processor | wc -l`.to_i
PROJECT_ROOT = find_project_root(Dir.pwd)

if PROJECT_ROOT.nil?
    if File.exists? 'Makefile'
        pid = spawn("make")
        Process.wait2 pid
        exit 0
    end

    if File.directory?(CURRENT_DIRNAME+"/build")
        file_content = File.read(CURRENT_FILE)
        if file_content.include?("#include <avr/") || file_content.include?("#include <avrcpp")
            #system("/home/dev/arduino/compile.sh", CURRENT_FILE)
            arduino_build
            exit 0
        end
    end

    puts "Can't find project root. It should have a build directory!"
    exit 1
end

puts "Args: #{$*}"

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
elsif File.file? PROJECT_ROOT+"/Rakefile"
    pid = spawn("rake --verbose")
    Process.wait2 pid
else
    puts "Unknown build system"
    exit 1
end
