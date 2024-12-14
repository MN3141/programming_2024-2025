CC=gcc
CCOV_TOOL=gcov
FLAGS=-Wall\
	 -I"../../include/"\
	 -fdiagnostics-format=json-file\
	 -O0
CCOV_FLAGS=$(FLAGS) --coverage
TESTING_FRAMEWORK=C:/tools/CUnitTest/src/
TEST_DIR=../../test/
TEST_SOURCE_FILE=$(TEST_DIR)test_$(APP_NAME)

all:
#	Build sample application
	@$(CC) $(APP_NAME).c $(FUNCTIONS) $(FLAGS) -o $(APP_NAME).exe
	$(info $(APP_NAME) was built succesfully!)
ccov:
#	Generate code coverage report for sample application
	$(CC) $(APP_NAME).c $(FUNCTIONS) $(CCOV_FLAGS) -o $(APP_NAME).exe
	./$(APP_NAME)
	@for file in *.gcda; do \
	    base=$$(basename $$file .gcda); \
	    $(CCOV_TOOL) $$base.c; \
	done
#Note: basename extracts the name of the file from the absolute path
#		e.g C:/proj/src/homework1/main.gcda ->main.gcda
#	@gzip -d $(FILE_NAME).gcov.json.gz
	@rm *.gcno
	@rm *.gcda
	$(info Code coverage report for $(APP_NAME) was generated succesfully!)
ctest:
#	Unit testing using Unitiy framework
	@$(CC) -I$(TESTING_FRAMEWORK) $(TESTING_FRAMEWORK)unity.c $(TEST_SOURCE_FILE).c $(FUNCTIONS) $(FLAGS)  -o $(TEST_SOURCE_FILE)
	@./$(TEST_SOURCE_FILE)
	@rm $(TEST_SOURCE_FILE).exe
clean:
	@rm *.exe *.json *.gcov
	$(info Project for $(APP_NAME) was cleaned!)