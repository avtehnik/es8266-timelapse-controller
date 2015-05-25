print("start server")

dofile("config.lua")
dofile("functions.lua")
photos = 0;

camera = 3
motor = 4
gpio.mode(camera, gpio.OUTPUT)
gpio.mode(motor, gpio.OUTPUT)


seconds = 0;
steps = 0;


srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        config.action="no"
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end

        if(_GET.action=="save") then
          
          config.exposure = tonumber(_GET.exposure);
          config.pause = tonumber(_GET.pause);
          config.steps = tonumber(_GET.steps);
          
           file.open("config.lua", "w");
          file.writeline("config = { exposure = "..config.exposure..", pause = "..config.pause..", steps = "..config.steps .."}");
          file.close();
          
          photos = 0;
          seconds = 0;
          steps = 0;
          photos = 0;
          
        end

        local buf = "<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"><meta charset=\"UTF-8\"></head><body>";
        buf = buf.."<h1>Timelapse controller</h1>";
        buf = buf.."<br>Фотографій зроблено ".. photos;
        buf = buf.."<br>Працюю ".. tmr.time() ;
        
        buf = buf.."<form>";
        buf = buf.."<br>Пауза <input type=\"number\" name=\"pause\" value=\"".. config.pause .."\" />";
        buf = buf.."<br>Витримка <input type=\"number\" name=\"exposure\" value=\"".. config.exposure .."\" />";
        buf = buf.."<br>Кроки <input type=\"number\" name=\"steps\" value=\"".. config.steps .."\" />";
        buf = buf.."<br>";
        buf = buf.."<button name=\"action\" value=\"save\" >Зберегти</button></div>";
        buf = buf.."</form>";
        buf = buf.."</body></html>";
        client:send(buf);
        client:close();
        collectgarbage(); 


    end)
end)

tmr.alarm(0, 1000, 1, function()     
  if(steps == 0) then      
    if(seconds==config.pause)then
         flash(camera);
         photos = photos + 1; 
    end
    if(seconds == (config.pause + config.exposure))then
      if(config.steps == 0)then
        seconds = 0;
      else
        steps = config.steps
      end
    end
    seconds = seconds+1;
  end
end )

tmr.alarm(1, 20, 1, function()     
  if(steps > 0)then
      flash(motor);
      steps = steps-1;
      if(steps ==0)then
        seconds = 0;
      end  
  end   
end )

   