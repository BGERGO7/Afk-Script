function afkKickHandler(reason)
    -- Because this will be triggered by triggerServerEvent, client will be available as the player that triggered it
    if client then
      kickPlayer(client, reason)
    end
  end
  addEvent("onPlayerAfkKick", true)
  addEventHandler("onPlayerAfkKick", getRootElement(), afkKickHandler)