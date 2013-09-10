newrelic-perfmon-plugin
================================

### Perfmon Plugin for New Relic RPM

Quick Download
--------------------

#### NOTE: When using this, please follow the directions below for [Standalone](README.md#standalone-version) or [Windows Service](README.md#windows-service-version).
##### https://github.com/nickfloyd/newrelic-perfmon-plugin/blob/master/standalone/perfmon_plugin_standalone.zip

Prerequisites
--------------------

### [Standalone](README.md#standalone-version) and [Windows Service](README.md#windows-service-version) Versions
* Windows Server to locally or remotely collect Perfmon counters
* .NET 2.0 or 4.0 runtime for Windows Service

### [Ruby Script](README.md#ruby-script-version) Version
* Windows Server to locally or remotely collect Perfmon counters
* Ruby 1.9.3+ installed (http://rubyinstaller.org/ works great for Windows) with DevKit installed
* Ruby 'bundler' installed ("gem install bundler" at command-line once Ruby is installed)

Instructions for running the Plugin
--------------------

### Standalone Version
1. Verify that the "typeperf" command is available at your Windows command line. ex. `typeperf "\Processor(_Total)\% Processor Time"`
2. Download and extract the plugin to a local directory
	* https://github.com/nickfloyd/newrelic-perfmon-plugin/blob/master/standalone/perfmon_plugin_standalone.zip
3. Copy `config\template_newrelic_plugin.yml` to `config\newrelic_plugin.yml`
4. Edit `config\newrelic_plugin.yml` and replace:
  	* `'YOUR_LICENSE_KEY_HERE'` with your New Relic license key (in ' ')
	* `your_sever_name_here` with the hostname of your Windows server from which you wish to collect Perfmon counters
	* (optional) If your server is behind an HTTP proxy, uncomment and set the `proxy_host`, `proxy_user` and `proxy_pass` settings.
5. Run `perfmon_plugin_standalone.exe`
6. Go back to the Plugins list, after a brief period you will see an entry called 'Perfmon'

### Windows Service Version
1. Follow directions for [Standalone Version](README.md#standalone-version)
2. Install the plugin service: run `install_perfmon_plugin_service.bat`
3. Start the plugin service by one of the following:
	* Run `perfmon_plugin_service.exe start` OR 
	* Run `sc start nr_perfmon` OR 
	* Start via Windows Services GUI
* Note: This service is set to start automatically at Windows start. To set to manual or disable, do so by editing the service in the Windows Services GUI.

### Ruby Script Version
1. Verify that the "typeperf" command is available at your Windows command line. ex. `typeperf "\Processor(_Total)\% Processor Time"`
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

Collecting Custom Perfmon Counters 
--------------------

Out-of-the-box, we have collected a set of Perfmon counters and dashboards that pertain to .NET applications. 
If you would like to collect your own counters, you can do so via config files in the Standalone agent, like so:

1. Create a new perfmon counters text file in the "config" directory
	* You can use the existing perfmon_totals_counters.txt file as an example
	* Use one Perfmon counter expression per line - the wildcards are as permitted by the "typeperf" command in Windows.
2. Edit your newrelic_config.yml file as follows:
	* Uncomment "guid" and set to your own GUID
	* Uncomment "countersfile" and set to the list of perfmon counters text file.
3. Follow the instructions above - [Instructions for running the Plugin](README.md#instructions-for-running-the-plugin)
	* The agent will appear in the UI under the new GUID name you defined.

Note: You will need to create your own custom dashboards and summary alerts for the agent.
* https://newrelic.com/docs/plugin-dev/working-with-plugin-dashboards
* https://newrelic.com/docs/plugin-dev/creating-summary-metrics-for-plugins

Forking the plugin / Making it your own
--------------------

Beyond collecting new Perfmon counters, if you'd like to take this plugin and customize it for your own specific needs you can do the following:

1. [Fork the repository](https://help.github.com/articles/fork-a-repo) | [Download the code](https://github.com/nickfloyd/newrelic-perfmon-plugin/archive/master.zip)
2. Change the agent_guid found in `perfmon_plugins_multithread.rb` to your own custom GUID (see the [docs](https://newrelic.com/docs/plugin-dev/the-parts-of-a-plugin#guid) for more information)
3. Follow the instructions above - [Instructions for running the Plugin](README.md#instructions-for-running-the-plugin)

Notes / Tips
--------------------

* Set "debug: true" in newrelic_plugin.yml to see the metrics logged to stdout instead of sending them to New Relic.
* Make sure that you set your license key in `config\newrelic_plugin.yml` if you're not seeing the plugin show up in your dashboard.
* You can add or remove counters by editing the `perfmon_metrics.rb` file.

Contributing
--------------------
1. [Fork the repository](https://help.github.com/articles/fork-a-repo)
2. Add awesome code or fix an [issue](https://github.com/nickfloyd/newrelic-perfmon-plugin/issues) with awesome code
3. [Submit a pull request](https://github.com/nickfloyd/newrelic-perfmon-plugin/pulls)

Support
--------------------

All support requests will be handled via [github issues](https://github.com/nickfloyd/newrelic-perfmon-plugin/issues).
