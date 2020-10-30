-- ADDS SOME EVENTS FOR IMPORTANT THINGS THAT WOULD GET TOO UNWEILDY TO PUT INTO ONE FILE

local Network = require(game.ReplicatedStorage.Network)

Network.AddEvent("PlayerJoinedRoom")
Network.AddEvent("PlayerLeftRoom")
Network.AddEvent("SongChangedRoom")
Network.AddEvent("RateChangedRoom")
Network.AddEvent("HostChangedRoom")
Network.AddEvent("HostSelectingSongRoom")
Network.AddEvent("GameStartedRoom")
Network.AddEvent("RoomCreated")
Network.AddEvent("RoomDeleted")
