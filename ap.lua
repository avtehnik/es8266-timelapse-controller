print('init.lua ver 1.2')
--init.lua
print("set up wifi mode")
wifi.setmode(wifi.SOFTAP)
cfg={}
cfg.ssid="ESP_STATION"
cfg.pwd="jellyfish"
wifi.ap.config(cfg)

print("ESP8266 SSID is: " .. cfg.ssid .. " and PASSWORD is: " .. cfg.pwd)

 tmr.alarm(0, 3000, 0, function()
	dofile("server.lua")
 end)


