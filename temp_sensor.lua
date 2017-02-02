--load settings
dofile("settings.lua")

function get_sensor_data()
    t = require("ds18b20")

    -- ESP-01 GPIO Mapping
    gpio0 = 4

    t.setup(gpio0)
    addrs = t.addrs()
    if (addrs ~= nil) then
        print("Total DS18B20 sensors: "..table.getn(addrs))
    end

    temperature = t.read()

    -- Just read temperature
    print("Temperature: "..temperature.."'C")

    -- Don't forget to release it after use
    t = nil
    ds18b20 = nil
    package.loaded["ds18b20"]=nil
end

--function loop()

    get_sensor_data() 
    print("Going to deep sleep for "..(time_between_sensor_readings/1000).." seconds")
    --node.dsleep(time_between_sensor_readings*1000)  
--end           

--tmr.alarm(0, 100, 1, function() loop() end)

    
