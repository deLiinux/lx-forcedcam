local check = false
local camera = Config.Cam
local fps = 4

CreateThread(function()
    while true do
        if Config.ForcedFPSinVehicle then
            if not IsPedInAnyVehicle(PlayerPedId()) then Wait(600) end
            if IsPedDoingDriveby(PlayerPedId()) then
                if GetFollowVehicleCamViewMode() == fps and check == false then
                    check = false
                else
                    SetFollowVehicleCamViewMode(fps)
                    check = true
                end
            else
                if check == true then
                    SetFollowVehicleCamViewMode(camera)
                    check = false
                end
            end
            Wait(1)
        else
            Wait(60000)
        end
    end
end)

CreateThread(function()
    local setpov = false
    while true do
        if Config.Only2CamViews then
            DisableControlAction(0, 0, true)
            local VehicleCurrentCamViewMode = GetFollowVehicleCamViewMode(PlayerPedId())
            local context = GetCamActiveViewModeContext()
            if not setpov and IsDisabledControlJustPressed(0, 0) then
                setpov = true
                SetCamViewModeForContext(context, 4)
            elseif setpov and IsDisabledControlJustPressed(0, 0) then
                setpov = false
                SetCamViewModeForContext(context, camera)
            end
            Wait(1)
        else
            Wait(60000)
        end
    end
end)