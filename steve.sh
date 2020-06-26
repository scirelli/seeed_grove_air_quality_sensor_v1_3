#/usr/bin/env bash
timeout=${1:-2}
path=/sys/devices/platform/soc

dir=$(ls $path | grep "04000.i2c")
if [ "$dir" != "" ];then
	echo AIN0,AIN1,AIN2,AIN3
	while :
	do
	    echo `cat $path/$dir/i2c-1/1-0048/in4_input`,`cat $path/$dir/i2c-1/1-0048/in5_input`,`cat $path/$dir/i2c-1/1-0048/in6_input`,`cat $path/$dir/i2c-1/1-0048/in7_input`
	    sleep $timeout
	done
else
    echo "can't detect ads-1115"
fi
