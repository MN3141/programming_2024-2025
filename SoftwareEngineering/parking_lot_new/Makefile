#Gradle: build system for Java
project=parking_lot_new-1.0-SNAPSHOT
port_no=8080
domain=domain1

#Get the path of the project
makefile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
project_path := $(dir $(makefile_path))
project_path := $(shell echo $(project_path) | sed 's|/|\\\\|g')

#Log files paths
server_log_file := $(GLASSFISH_HOME)\\glassfish\\domains\\$(domain)\\logs
server_log_link := $(project_path)\\debug

all:
	@echo "Launching app in http://localhost:$(port_no)/$(project)/ ..."

#Build archive file
	@gradle build
	@asadmin start-domain
	@asadmin start-database

#Deploy to glassfish environment
	@asadmin deploy build/libs/$(project).war
	@start http://localhost:$(port_no)/$(project)/

#Create symbolic link to glassfish log file
	@cmd.exe /c mklink /J $(server_log_link) $(server_log_file)

refresh:
	@echo "Refreshing app in http://localhost:$(port_no)/$(project)/ ..."
	@asadmin restart-domain
	@asadmin undeploy $(project)
	@asadmin deploy build/libs/$(project).war
	@start http://localhost:$(port_no)/$(project)/

clean:
	@echo "Cleaning..."
	@asadmin undeploy $(project)
	@asadmin stop-domain
	@gradle clean
	@rm $(server_log_link)

restart:
	@make clean
	@make