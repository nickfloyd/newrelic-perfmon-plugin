PerfMon Plugin for New Relic RPM
Steps for Building Standalone Version
(Standalone Executable and Windows Service)

Prerequisites
--------------------

* Windows Server to locally or remotely collect Perfmon counters
* RubyInstaller 1.9.3+ installed with Development Kit
	* http://rubyinstaller.org/
	* http://rubyinstaller.org/add-ons/devkit/
* Ruby bundler 
	* gem install bundler
* OCRA (One-Click Ruby Application) 
	* http://ocra.rubyforge.org/ 
	* gem install ocra
* winsw - Windows service wrapper with MIT license 
	* Homepage: https://github.com/kohsuke/winsw
	* Download: http://repo.jenkins-ci.org/releases/com/sun/winsw/winsw/
	* Currently using v1.13 from the download site
* Bundle of CA Root Certificates from cURL 
	* http://curl.haxx.se/ca/cacert.pem
	* Based on fix described here: https://gist.github.com/fnichol/867550
	
Building the Standalone Executable
--------------------

1. Download plugin to windows server
2. Copy template_newrelic_plugin.yml to newrelic_plugin.yml
3. Edit newrelic_plugin.yml to allow OCRA to execute properly. 
	* OCRA executes ruby script as part of EXE creation.
	* Since the plugin will normally stay running, set "testrun" and "debug" both to true, to run through script once and complete.
4. Open command line, change to directory with plugin
5. Run bundler ("bundle install") and resolve any issues, i.e. install DevKit if skipped.
6. Run OCRA to build standalone executable of plugin
	* Include gem dependencies listed in Gemfile
	* Optional: Set filename to a name that will be specified in winsw XML.
	* Optional: Cutesy icon for executable (default is a Ruby)
	* Include all immutable files that are referenced by plugin
	* Working example of OCRA command included in this repo in "create_standalone.bat"
7. Edit newrelic_plugin.yml to prepare for testing
	* Set debug & testrun both to false
	* Enter valid license key
	* Give server a unique name
8. Run plugin executable to validate functionality
	* Should work from execution at command-line or via double-click in explorer
	* Verify no errors in command window.
	* Verify metrics appear in RPM
	
Building the Windows Service
--------------------

1. Copy winsw executable to same directory as standalone executable
2. Rename winsw executable to be descriptive (i.e. "perfmon_plugin_service.exe")
3. Create XML and exe.config files with same name as renamed winsw executable 
	* Working examples of both files are included in this repo.
4. Create "logs" directory
5. Optional: Create BAT scripts to install/uninstall service
6. Install windows service: "perfmon_plugin_service.exe install" or use installer BAT
7. Start service
	* "perfmon_plugin_service.exe start" OR "sc start nr_perfmon" OR start from Services UI
	* Use same newrelic_plugin.yml as was used for testing standalone executable
8. Verify service 
	* Once installed, service is listed properly in Services UI
	* Once started, service stays running (in "Running" state)
	* Check logs for any errors - normally they will be empty
	* Verify metrics appear in RPM

Packaging the Windows Service
--------------------
The following files should be included in a ZIP of the standalone/service:

* Standalone executable
* Windows service executable,
* Windows service .exe.config 
* Windows service XML
* Template YML file: config/template_newrelic_plugin.yml
* (For Service only) Logs directory - can be empty, or put dummy file in there
	
Notes / Tips
--------------------
If service isn't working and logs don't indicate anything:

* Check Windows Event Viewer - Application Logs - look for "nr_perfmon" as Source
* Uncomment "verbose: 1" in newrelic_plugin.yml and restart service, then check logs in "logs" directory for output from plugin.

Contributing
--------------------
1. [Fork the repository](https://help.github.com/articles/fork-a-repo)
2. Add awesome code or fix an [issue](https://github.com/nickfloyd/newrelic-perfmon-plugin/issues) with awesome code
3. [Submit a pull request](https://github.com/nickfloyd/newrelic-perfmon-plugin/pulls)

Support
--------------------

All support requests will be handled via [github issues](https://github.com/nickfloyd/newrelic-perfmon-plugin/issues).