from pyparsing import (
    Word, alphas, alphanums, nums, Keyword, Literal, Suppress, Group,
    OneOrMore, Optional, ZeroOrMore, Forward, delimitedList, QuotedString,
    ParserElement, cppStyleComment, pythonStyleComment, Combine, restOfLine
)

ParserElement.enablePackrat()

# Basic symbols
LBRACE, RBRACE, EQ, SEMI, LBRACK, RBRACK, COMMA = map(Suppress, "{}=;[],")
COMMENT = cppStyleComment | pythonStyleComment

# Basic tokens
identifier = Word(alphas + "_", alphanums + "_")
integer = Word(nums).setParseAction(lambda t: int(t[0]))
boolean = (Keyword("TRUE") | Keyword("FALSE")).setParseAction(lambda t: t[0] == "TRUE")
string_literal = QuotedString('"')

value = boolean | integer | string_literal | identifier

# Arrays, e.g. APPMODE[]
array_suffix = LBRACK + RBRACK
typed_identifier = Group(identifier("type") + Optional(array_suffix("is_array")))

# Attribute with optional default value, e.g. BOOLEAN USERESSCHEDULER = TRUE;
attribute = Group(
    typed_identifier("type") +
    identifier("name") +
    Optional(EQ + value("default")) +
    SEMI
)

# For nested attributes inside enums or other blocks
nested_attribute = attribute

# ENUM simple, e.g. ENUM [STANDARD, EXTENDED] STATUS;
enum_simple = Group(
    Keyword("ENUM") +
    LBRACK +
    delimitedList(identifier)("enum_values") +
    RBRACK +
    identifier("name") +
    SEMI
)

# ENUM with nested blocks, e.g.
# ENUM [
#   STANDARD,
#   LINKED {
#     RESOURCE_TYPE LINKEDRESOURCE;
#   },
#   INTERNAL
# ] RESOURCEPROPERTY;
enum_block_element = Group(
    identifier("enum_name") +
    Optional(LBRACE + Group(ZeroOrMore(nested_attribute))("attributes") + RBRACE)
)

enum_block = Group(
    Keyword("ENUM") +
    LBRACK +
    delimitedList(enum_block_element)("enum_values") +
    RBRACK +
    identifier("name") +
    SEMI
)

# BOOLEAN with options and nested blocks, e.g. BOOLEAN [TRUE { ... }, FALSE] AUTOSTART;
# We'll treat it similarly to enum_block for simplicity
boolean_option = Group(
    boolean("bool_value") +
    Optional(LBRACE + Group(ZeroOrMore(nested_attribute))("attributes") + RBRACE)
)
boolean_options = Group(
    LBRACK +
    delimitedList(boolean_option)("bool_options") +
    RBRACK
)

# Attribute with boolean options e.g. BOOLEAN [TRUE {...}, FALSE] AUTOSTART;
attribute_with_boolean_options = Group(
    identifier("type") +
    boolean_options("bool_options") +
    identifier("name") +
    SEMI
)

# UINT32 with range option, e.g. UINT32 [1, 2] CATEGORY;
uint32_range = Group(
    Keyword("UINT32") +
    LBRACK +
    integer("min") + COMMA + integer("max") +
    RBRACK +
    identifier("name") +
    SEMI
)

# General block content: can be attributes, enum_simple, enum_block, attribute_with_boolean_options, uint32_range
block_content = OneOrMore(
    attribute_with_boolean_options |
    uint32_range |
    enum_block |
    enum_simple |
    attribute
)

# Block: { content };
block = Group(LBRACE + block_content("content") + RBRACE + SEMI)

# Named blocks like OS { ... };
named_block = Group(
    identifier("block_name") +
    block
)

# IMPLEMENTATION Standard { ... };
implementation_block = Group(
    Keyword("IMPLEMENTATION") +
    identifier("impl_name") +
    LBRACE +
    OneOrMore(named_block)("blocks") +
    RBRACE + SEMI
)

# CPU DummyApp { ... };
cpu_block = Group(
    Keyword("CPU") +
    identifier("cpu_name") +
    block
)

# OIL_VERSION="2.5";
oil_version = Group(
    Keyword("OIL_VERSION") +
    EQ +
    string_literal("version") +
    SEMI
)

# Full OIL file parser: optional OIL_VERSION, implementation_block, CPU blocks
oil_file = OneOrMore(
    oil_version | implementation_block | cpu_block
)

# Ignore comments
oil_file.ignore(COMMENT)

# -----------------------
# Example usage on your file content

if __name__ == "__main__":
    oil_text = """
    /**
     * This OIL file contains the default definition of OIL objects and standard attributes.
     * This is the Subset for internal communication (CCCA and CCCB only).
     *
     * This is for version 2.5 of OIL as defined for OSEK/VDX
     * See "OIL: OSEK Implementation Language" Version 2.5 (oil25.pdf)
     *
     * Author: Mark Dixon.
     */
     
    OIL_VERSION="2.5";
    
    IMPLEMENTATION Standard {
    
        OS {
            ENUM [STANDARD, EXTENDED] STATUS;
            BOOLEAN STARTUPHOOK;
            BOOLEAN ERRORHOOK;
            BOOLEAN SHUTDOWNHOOK;
            BOOLEAN PRETASKHOOK;
            BOOLEAN POSTTASKHOOK;
            BOOLEAN USEGETSERVICEID;
            BOOLEAN USEPARAMETERACCESS;
            BOOLEAN USERESSCHEDULER = TRUE;
        };
    
        APPMODE {
        };
    
        TASK {
            BOOLEAN [
                TRUE {
                    APPMODE_TYPE APPMODE[];
                },
                FALSE
            ] AUTOSTART;
            
            UINT32 PRIORITY;
            UINT32 ACTIVATION;
            ENUM [NON, FULL] SCHEDULE;
            EVENT_TYPE EVENT[];
            RESOURCE_TYPE RESOURCE[];
            MESSAGE_TYPE MESSAGE[];
        };
    
        ISR {
            UINT32 [1, 2] CATEGORY;
            RESOURCE_TYPE RESOURCE[];
            MESSAGE_TYPE MESSAGE[];
        };
        
        COUNTER {
            UINT32 MINCYCLE;
            UINT32 MAXALLOWEDVALUE;
            UINT32 TICKSPERBASE;
        };
        
        ALARM {
            COUNTER_TYPE COUNTER;
            ENUM [
                ACTIVATETASK {
                    TASK_TYPE TASK;
                },
                SETEVENT {
                    TASK_TYPE TASK;
                    EVENT_TYPE EVENT;
                },
                ALARMCALLBACK {
                    STRING ALARMCALLBACKNAME;
                }
            ] ACTION;
            BOOLEAN [
                TRUE {
                    UINT32 ALARMTIME;
                    UINT32 CYCLETIME;
                    APPMODE_TYPE APPMODE[];
                },
                FALSE
            ] AUTOSTART;
        };
        
        EVENT {
            UINT64 WITH_AUTO MASK;
        };
        
        RESOURCE {
            ENUM [
                STANDARD,
                LINKED {
                    RESOURCE_TYPE LINKEDRESOURCE;
                },
                INTERNAL
            ] RESOURCEPROPERTY;
        };	
    
        MESSAGE {
            ENUM [
                SEND_STATIC_INTERNAL {
                    STRING CDATATYPE;
                },
                RECEIVE_UNQUEUED_INTERNAL {
                    MESSAGE_TYPE SENDINGMESSAGE;
                    UINT64 INITIALVALUE = 0;
                },
                RECEIVE_QUEUED_INTERNAL {
                    MESSAGE_TYPE SENDINGMESSAGE;
                    UINT32 QUEUESIZE;
                }
            ] MESSAGEPROPERTY;
    
            ENUM [
                NONE,
                ACTIVATETASK {
                    TASK_TYPE TASK;
                },
                SETEVENT {
                    TASK_TYPE TASK;
                    EVENT_TYPE EVENT;
                },
                COMCALLBACK {
                    STRING CALLBACKROUTINENAME;
                    MESSAGE_TYPE MESSAGE[];
                },
                FLAG {
                    STRING FLAGNAME;
                }
            ] NOTIFICATION = NONE;
        };			
    
        COM {
            BOOLEAN COMERRORHOOK = FALSE;
            BOOLEAN COMUSEGETSERVICEID = FALSE;
            BOOLEAN COMUSEPARAMETERACCESS = FALSE;
            BOOLEAN COMSTARTCOMEXTENSION = FALSE;
            STRING COMAPPMODE[];
            ENUM [	COMSTANDARD, COMEXTENDED ] COMSTATUS = COMSTANDARD;
        };
        
        NM {
        };
    
    };
    
    CPU DummyApp {
    
        /* No app specified, just implementation */
    
    };
    """

    try:
        result = oil_file.parseString(oil_text, parseAll=True)
        print(result.dump())
    except Exception as e:
        print("Parsing failed:", e)
