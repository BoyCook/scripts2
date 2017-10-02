#!/usr/bin/env ruby

# == Synopsis 
#   This will recursivly loop through a directory and it's subdirectories,
#   looking for any of the given xml file name, and will replace the given node with a new value
#
# == Examples
#   Basic:
#     changenode /home/me/foo bar.xml name bob john
#
# == Usage 
#   changenode [options] source_directory file_name node_to_look_for previous_value new_value
#
#   For help use: changenode -h
#
# == Options
#   -h, --help          Displays help message
#   -v, --version       Display the version, then exit
#   -q, --quiet         Output as little as possible, overrides verbose
#   -V, --verbose       Verbose output
#
# == Author
#   Craig Cook
#
# == Copyright
#   Copyright (c) 2010 Craig Cook. Licensed under the MIT License:
#   http://www.opensource.org/licenses/mit-license.php

require 'rdoc/usage'
require 'rexml/document'
require 'optparse' 
require 'ostruct'
require 'date'

include REXML

class Node_Edit
  def initialize(dir, file_name, node, v1, v2, read)
    @dir = dir
    @file_name = file_name
    @node = node
    @v1 = v1
    @v2 = v2
    @read = read
  end
  
  def run
    puts 'In read-only mode' if @read
    find_files(@dir)
  end
  
  def find_files(dir)
  	Dir.foreach(dir) do |entry|   
  	    if entry.eql? @file_name then
  	      loc = "#{dir}/#{entry}"
          file = File.new(loc)
          doc = Document.new(file)
          find_nodes(dir, doc, loc)
     		elsif File::directory?("#{dir}/#{entry}") and !entry.match('^\.') then
          find_files("#{dir}/#{entry}")
     		end
  	end    
  end
  
  def find_nodes(dir, doc, loc)
    XPath.each(doc, "//#{@node}") do |e| 
      if e.text.eql? @v1
        puts "Found #{@node}: #{e.text} in #{dir}/#{@file_name}"
        e.text = @v2
      end            
    end
    
    if !@read then
      newFile = File.new(loc, 'w')
      newFile.puts doc      
    end
  end

  # <b>DEPRECATED:</b> Please use <tt>XPath.each</tt> instead.
  def replace_version(doc, dir, loc)
    doc.elements.each(loc) do |ele|
      if ele.text.eql? @v1
        puts "Replacing Version: #{ele} in #{dir}/pom.xml"
        ele.text = @v2
      end
    end    
  end  
end

class Fix_It
  VERSION = '0.0.2'
  attr_reader :options

  def initialize(arguments)    
    @arguments = arguments
    @options = OpenStruct.new
    @options.verbose = false
    @options.quiet = false
  end  

  # Parse options, check arguments, then process the command
  def run
    if parsed_options? && arguments_valid? 
       puts "Start at #{DateTime.now}\n\n" if @options.verbose
       output_options if @options.verbose
       process_arguments            
       start
       puts "\nFinished at #{DateTime.now}" if @options.verbose
     else
       output_usage
     end    
  end
  
  def start
    puts "Fixing #{@node} in #{@file_name}"
    if !File::directory?(@dir) then
      puts "Sorry, #{@dir} is not a valid directory"
      output_usage
    end 
    
    if @v1.eql? @v2 then
      puts "Sorry, you are not changing any value. #{@v1} is the same as #{@v2}"
      output_usage      
    end
    
    edit = Node_Edit.new(@dir, @file_name, @node, @v1, @v2, @options.quiet)
    edit.run
  end
  
  protected
  
    def parsed_options?
      # Specify options
      opts = OptionParser.new 
      opts.on('-v', '--version')    { output_version ; exit 0 }
      opts.on('-h', '--help')       { output_help }
      opts.on('-V', '--verbose')    { @options.verbose = true }  
      opts.on('-q', '--quiet')      { @options.quiet = true }
      # TO DO - add additional options
            
      opts.parse!(@arguments) rescue return false
      
      process_options
      true      
    end

    # Performs post-parse processing on options
    def process_options
      @options.verbose = false if @options.quiet
    end
    
    def output_options
      puts "Options:\n"
      
      @options.marshal_dump.each do |name, val|        
        puts "#{name} = #{val}"
      end
    end

    def arguments_valid?
      true if @arguments.length == 5
    end
    
    def process_arguments
      @dir = @arguments[0]
      @file_name = @arguments[1]      
      @node = @arguments[2]      
      @v1 = @arguments[3]
      @v2 = @arguments[4]
    end
    
    def output_help
      output_version
      RDoc::usage()
    end
    
    def output_usage
      RDoc::usage('usage')
    end
    
    def output_version
      puts "#{File.basename(__FILE__)} version #{VERSION}"
    end
end  

# Create and run the application
app = Fix_It.new(ARGV)
app.run