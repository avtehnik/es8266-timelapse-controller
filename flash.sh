./luatool.py --port /dev/tty.usbserial --src init.lua --dest init.lua --verbose           --baud 115200
./luatool.py --port /dev/tty.usbserial --src functions.lua --dest functions.lua --verbose  --baud 115200
./luatool.py --port /dev/tty.usbserial --src server.lua --dest server.lua --verbose  --baud 115200
./luatool.py --port /dev/tty.usbserial --src config.lua --dest config.lua --verbose --restart       --baud 115200 
