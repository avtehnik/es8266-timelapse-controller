print('init')
wifi.setmode(wifi.SOFTAP)
cfg={};
cfg.ssid="ESP_STATION"
cfg.pwd="jellyfish"
wifi.ap.config(cfg)
--tmr.delay(5000)
--uart.setup( 0, 115200, 8, 0, 1, 0, 1 )

print("ESP8266 SSID is: " .. cfg.ssid .. " and PASSWORD is: " .. cfg.pwd)

dofile("server.lua")


