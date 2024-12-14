#include "unity.h"
#include "homework1.h"

void setUp()
{

}

void test_bit_count()
{
    TEST_ASSERT_EQUAL(1,CountBitsOf1(1));
    TEST_ASSERT_EQUAL(8,CountBitsOf1(255));
    TEST_ASSERT_EQUAL(0,CountBitsOf1(0));
}

void tearDown(){

}

int main(void)
{
    UNITY_BEGIN();
    RUN_TEST(test_bit_count);
    return UNITY_END();
}