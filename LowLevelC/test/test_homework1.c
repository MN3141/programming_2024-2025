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

void test_power_of_2(){

    TEST_ASSERT_EQUAL(1,VerifyPowerOf2(1));
    TEST_ASSERT_EQUAL(0,VerifyPowerOf2(3));
}

void test_nibble_sum(){

    TEST_ASSERT_EQUAL(14,CalculateSumOfNibbles(0xff));
    TEST_ASSERT_EQUAL(0,CalculateSumOfNibbles(0x88));
    TEST_ASSERT_EQUAL(0,CalculateSumOfNibbles(0));
}
void tearDown(){

}

int main(void)
{
    UNITY_BEGIN();
    RUN_TEST(test_bit_count);
    RUN_TEST(test_power_of_2);
    RUN_TEST(test_nibble_sum);
    return UNITY_END();
}