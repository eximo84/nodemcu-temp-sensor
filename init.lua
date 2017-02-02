--init.lua

function startup()
    if abort == true then
        print('Startup Aborted')
        return
        end
    print('Starting Application...')
    dofile("temp_sensor.lua")
end

abort = false
tmr.alarm(0,5000,0,startup)
