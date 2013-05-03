#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "newrelic_plugin"
require_relative "perfmon_metrics.rb"

module PerfmonAgent

  class Agent < NewRelic::Plugin::Agent::Base

    agent_config_options :local, :hostname, :countersfile, :debug, :testrun
    agent_guid "com.newrelic.examples.perfmon"
    agent_version "0.0.1"

    if !:hostname.empty? then agent_human_labels("Perfmon") { "#{hostname}" }
    elsif :local then agent_human_labels("Perfmon") { "#{Socket.gethostname}" }
    else abort("No hostname found or local is not set to true.") end
      
    def setup_metrics
      @pm = PerfmonMetrics.new
      if :countersfile.empty? then counters_file = "config/perfmon_counters.txt"
      else counters_file = "config/#{self.countersfile}" end
      
      if File.file?(counters_file)
        @counters = "typeperf"
        clines = File.open(counters_file, "r")
        clines.each { |l| if !?l.chr.eql?("#") then @counters = "#{@counters} \"#{l.strip}\"" end }
        clines.close
        if !self.local then @counters = "#{@counters} -s #{self.hostname}" end
        @counters = "#{@counters} -sc #{@pm.metric_samples}"
      else abort("No Perfmon counters file named #{counters_file}.") end
    end
    
    def poll_cycle

      if self.testrun then perf_input = File.open("typeperf_test.txt", "r")
      else perf_input = `#{@counters}`.split("\n") end
      
      perf_lines = Array.new  
      perf_input.each {|pl| if pl.chr.eql?("\"") 
        perf_lines << pl.gsub(/\"/, "").gsub(/\[/, "(").gsub(/\]/, ")").gsub(/\\\\\w+\\/, "") end }
      
      if self.testrun then perf_input.close end
      
      perf_names = perf_lines[0].split(",")
      perf_values = perf_lines[1].split(",")
      
      perf_names.each_index{ |i|
        if !perf_names[i].rindex("\\").nil?
          metric_name = perf_names[i].slice(perf_names[i].rindex("\\")+1, perf_names[i].length)
          report_metric_check_debug perf_names[i].strip, @pm.metric_types[metric_name], perf_values[i]
        end     
      }
      
      if self.testrun then exit end
    end
    
    private
    
    def report_metric_check_debug(metricname, metrictype, metricvalue)
      if "#{self.debug}" == "true" then puts("#{metricname}[#{metrictype}] : #{metricvalue}")
      else report_metric metricname, metrictype, metricvalue end
    end
    
  end
  
  NewRelic::Plugin::Setup.install_agent :perfmon, self
  NewRelic::Plugin::Run.setup_and_run

end