--load settings
dofile("settings.lua")

-- Setup MQTT client and events
m = mqtt.Client(client_id, 120, username, password)
temperature = 0

-- Connect to the wifi network
wifi.setmode(wifi.STATION) 
--wifi.setphymode(wifi_signal_mode)
wifi.sta.config(wifi_SSID, wifi_password) 
wifi.sta.connect()
if client_ip ~= "" then
    wifi.sta.setip({ip=client_ip,netmask=client_netmask,gateway=client_gateway})
end

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
    if wifi.sta.status() == 5 then
        -- Stop the loop
--        tmr.stop(0)
--        m:connect( mqtt_broker_ip , mqtt_broker_port, 0, function(conn)
--            print("Connected to MQTT")
--            print("  IP: ".. mqtt_broker_ip)
--            print("  Port: ".. mqtt_broker_port)
--            print("  Client ID: ".. mqtt_client_id)
--            print("  Username: ".. mqtt_username)
            -- Get sensor data
            get_sensor_data() 
--            m:publish("ESP8266/temperature",temperature, 0, 0, function(conn)
                print("Going to deep sleep for "..(time_between_sensor_readings/1000).." seconds")
                node.dsleep(time_between_sensor_readings*1000)             
--            end)          
--        end)
    else
        print("Network not available")
        print("Going to deep sleep for "..(time_between_sensor_readings/1000).." seconds")
        node.dsleep(time_between_sensor_readings*1000) 
    end  
--end           

--tmr.alarm(0, 100, 1, function() loop() end)

-- Watchdog loop, will force deep sleep the operation somehow takes to long
--tmr.alarm(1,4000,1,function() node.dsleep(time_between_sensor_readings*1000) end)
    
