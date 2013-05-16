perfmon_plugin
================================

New Relic Perfmon Plugin

### Prerequisites

* Windows Server to locally or remotely collect Perfmon counters
* Ruby 1.9.3+ installed (http://rubyinstaller.org/ works great for Windows)
* Ruby 'bundler' installed ("gem install bundler" at command-line once Ruby is installed)

### Instructions for running the Plugin

1. Verify that the "typeperf" command is available at your Windows command line. ex. `typepref "\Processor(_Total)\% Processor Time"`
2. Go to: https://github.com/newrelic-platform/perfmon_plugin.git
3. Download and extract the source to a local directory
4. Run `bundle install` in the directory with this source
5. Copy `config\template_newrelic_plugin.yml` to `config\newrelic_plugin.yml`
6. Edit `config\newrelic_plugin.yml` and replace:
  * `'YOUR_LICENSE_KEY_HERE'` with your New Relic license key (in ' ')
	* `your_sever_name_here` with the hostname of your Windows server from which you wish to collect Perfmon counters
7. Edit 'config\perfmon_counters.txt' to list which counters you wish to collect
8. Execute `perfmon_plugins_multithread.rb` at command-line
9. Go back to the Plugins list, after a brief period you will see an entry called 'Perfmon'

#### Notes / Tips

* Set "debug: true" in newrelic_plugin.yml to see the metrics logged to stdout instead of sending them to New Relic.
