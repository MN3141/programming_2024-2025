CC=gcc
CCOV_TOOL=gcov
FLAGS=-Wall\
	 -I"../include/"\
	 -fdiagnostics-format=json-file
CCOV_FLAGS=$(FLAGS) --coverage
TESTING_FRAMEWORK=C:/tools/CUnitTest/src/
TEST_DIR=../test/
TEST_SOURCE_FILE=$(TEST_DIR)test_$(APP_NAME)

all:
	@$(CC) $(APP_NAME).c $(FLAGS) -o $(APP_NAME).exe
	$(info $(APP_NAME) was built succesfully!)
ccov:
	@$(CC) $(APP_NAME).c $(CCOV_FLAGS) -o $(APP_NAME).exe
	@./$(APP_NAME)
	@$(CCOV_TOOL) $(APP_NAME).gcda $(APP_NAME)
#	@gzip -d $(FILE_NAME).gcov.json.gz
	@rm *.gcno
	@rm *.gcda
	$(info Code coverage report for $(APP_NAME) was generated succesfully!)
ctest:

	@$(CC) -I$(TESTING_FRAMEWORK) $(TESTING_FRAMEWORK)unity.c $(TEST_SOURCE_FILE).c $(APP_NAME).c $(FLAGS)  -o $(TEST_SOURCE_FILE)
	@./$(TEST_SOURCE_FILE)
	@rm $(TEST_SOURCE_FILE).exe
clean:
	@rm *.exe *.json
	$(info Project for $(APP_NAME) was cleaned!)