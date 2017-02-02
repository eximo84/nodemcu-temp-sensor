--load settings
dofile("settings.lua")

function startup()
    if abort == true then
        print('startup aborted')
        return
        end
    print('in startup')
    -- dofile("temp_sensor.lua")
end

--init.lua
wifi.sta.disconnect()
print("set up wifi mode")
wifi.setmode(wifi.STATION)
wifi.setphymode(wifi_signal_mode)
wifi.sta.config(wifi_SSID,wifi_password,0)
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function() 
    if wifi.sta.getip()== nil then 
        print("IP unavaiable, Waiting...") 
    else 
        tmr.stop(1)
        print("Config done, IP is "..wifi.sta.getip())
    end 
 end)

abort = false
tmr.alarm(0,5000,0,startup)
