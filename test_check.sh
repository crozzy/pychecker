#!/bin/sh

TESTS="test_input/test[1-9]*.py"

if [ -z $TMP ]; then
    TMP=/tmp
fi

error=0

for test_file in $TESTS ; do
    echo "Testing $test_file ..."
    test_name=`basename $test_file .py`
    test_path=$TMP/$test_name
    ./checker.py $test_file > $test_path
    diff $test_path test_expected/$test_name
    if [ $? -ne 0 ]; then
    	error=`expr $error + 1`
	echo "  $test_name FAILED"
    fi
    rm -f $test_path
done

if [ $error -ne 0 ]; then
    echo ""
    echo "$errors TESTS FAILED"
else
    echo "ALL TESTS PASSED"
fi
