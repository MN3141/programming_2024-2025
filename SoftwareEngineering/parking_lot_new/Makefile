#Gradle: build system for Java
project=parking_lot_new-1.0-SNAPSHOT
port_no=8080
all:
	@echo "Launching app in http://localhost:$(port_no)/$(project)/ ..."
#Build archive file
	@gradle build
	@asadmin start-domain
	@asadmin start-database

#Deploy to glassfish environment
	@asadmin deploy build/libs/$(project).war
	@start http://localhost:$(port_no)/$(project)/

restart:
	@echo "Restarting app in http://localhost:$(port_no)/$(project)/ ..."
	@asadmin restart-domain
	@asadmin undeploy $(project)
	@asadmin deploy build/libs/$(project).war
	@start http://localhost:$(port_no)/$(project)/

clean:
	@echo "Cleaning..."
	@asadmin undeploy $(project)
	@asadmin stop-domain
	@gradle clean
