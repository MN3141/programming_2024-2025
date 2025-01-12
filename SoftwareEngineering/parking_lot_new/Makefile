#Gradle: build system for Java
project=parking_lot_new-1.0-SNAPSHOT
app_port_num=8080
server_port_num=4848
domain=domain1

#Get the path of the project
makefile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
project_path := $(dir $(makefile_path))
project_path := $(shell echo $(project_path) | sed 's|/|\\\\|g')

#Log files paths
server_log_file := $(GLASSFISH_HOME)\\glassfish\\domains\\$(domain)\\logs
server_log_link := $(project_path)\\debug

all:
	@echo "Launching app in http://localhost:$(app_port_num)/$(project)/ ..."

#Build archive file
	@gradle build
	@asadmin start-domain
	@asadmin start-database

#Deploy to glassfish environment
	@asadmin deploy build/libs/$(project).war
	@start http://localhost:$(app_port_num)/$(project)/

#Create symbolic link to glassfish log file
	@cmd.exe /c mklink /J $(server_log_link) $(server_log_file)

refresh:
	@echo "Refreshing app in http://localhost:$(app_port_num)/$(project)/ ..."
	@asadmin restart-domain
	@asadmin undeploy $(project)
	@asadmin deploy build/libs/$(project).war
	@start http://localhost:$(app_port_num)/$(project)/

clean:
	@echo "Cleaning..."
	@asadmin undeploy $(project)
	@asadmin stop-domain
	@gradle clean
	@rm $(server_log_link)

restart:
	@make clean
	@make

manage:
	@start http://localhost:$(server_port_num)/