print("start server")

dofile("config.lua")
photos = 0;

led1 = 3
led2 = 4
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                config[k] = v
            end
        end
        
        if(config.action=="save") then
          file.open("config.lua", "w");
          file.writeline("config = {	exposure = "..config.exposure..", pause = "..config.pause..", steps = "..config.steps .."}");
          file.close();
          photos = 0;
        end
        
        buf = buf.."<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"><meta charset=\"UTF-8\"></head><body>";
        buf = buf.."<h1>Timelapse controller</h1>";
        buf = buf.."<div>Фотографій зроблено ".. photos .."</div>";
        buf = buf.."<div>Працюю ".. tmr.time() .."</div>";
        
        
        
        buf = buf.."<form>";
        buf = buf.."<div> Пауза <input type=\"number\" name=\"pause\" value=\"".. config.pause .."\" /></div>";
        buf = buf.."<div> Витримка <input type=\"number\" name=\"exposure\" value=\"".. config.exposure .."\" /></div>";
        buf = buf.."<div> Кроки <input type=\"number\" name=\"steps\" value=\"".. config.steps .."\" /></div>";
        buf = buf.."<div>";
--        buf = buf.."<button name=\"action\" value=\"apply\" />Apply</button>";
        buf = buf.."<button name=\"action\" value=\"save\" >Зберегти</button></div>";
        buf = buf.."</div>";
        buf = buf.."</form>";
        buf = buf.."</body></html>";
     
        client:send(buf);
        
        client:close();
        

        photos = photos+1;
        
        collectgarbage();
    end)
end)





   