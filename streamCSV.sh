#/usr/bin/env bash
timeout=${1:-2}
path=/sys/devices/platform/soc
SECONDS_IN_24_HOURS=86400
MAX_ITERATIONS=$((SECONDS_IN_24_HOURS/timeout))
count=0

dir=$(ls $path | grep "04000.i2c")
if [ "$dir" != "" ];then
	while :
	do
        timestamp=`date +%s%3N`
        fileName=results_$timestamp.csv

        echo DV0,DV1,DV2,DV3,AIN0,AIN1,AIN2,AIN3,time_stamp_ms > $fileName
        while [ $count -lt $MAX_ITERATIONS ]
        do
            echo `cat $path/$dir/i2c-1/1-0048/in0_input`,`cat $path/$dir/i2c-1/1-0048/in1_input`,`cat $path/$dir/i2c-1/1-0048/in2_input`,`cat $path/$dir/i2c-1/1-0048/in3_input`,`cat $path/$dir/i2c-1/1-0048/in4_input`,`cat $path/$dir/i2c-1/1-0048/in5_input`,`cat $path/$dir/i2c-1/1-0048/in6_input`,`cat $path/$dir/i2c-1/1-0048/in7_input`,`date +%s%3N` \
                >> $fileName
            sleep $timeout
            count=$((count + 1))
        done
        count=0
	done
else
    echo "can't detect ads-1115"
fi
