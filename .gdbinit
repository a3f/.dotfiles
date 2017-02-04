set disassembly-flavor intel
define xxd
	dump binary memory /tmp/dump.bin $arg0 $arg0+$arg1
	eval "shell xxd-o %p /tmp/dump.bin", $arg0
end

#define list2
    #eval "shell gobjdump -dS file > /tmp/$pid.gdb.S"
    #eval "shell

# set to 1 to have ARM target debugging as default, use the "arm" command to switch inside gdb
set $ARM = 0
set $COLOREDPROMPT = 0
source ~/.gdb/.gdbinit
set startup-with-shell off
