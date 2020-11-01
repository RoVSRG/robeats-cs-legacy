local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local AssertType = require(game.ReplicatedStorage.Shared.AssertType)

local Player = require(game.ServerScriptService.Multiplayer.Player)

local Room = {}

function Room:new(id)
    local self = {}
    self.players = SPDict:new()
    self.host = 0
    self.selected_song_key = 1
    self.name = "Room"
    self.id = id
    self.is_playing = false

    function self:set_host(host)
        AssertType:is_number(host, "Host must be a UserId number!")
        self.host = host
	end
	
	function self:set_name(name)
		AssertType:is_string(name, "Name must be a valid string!")
		self.name = name
	end

    function self:random_host()
        local _key = self.players:key_list():random()
        self.host = self.players:get(_key)
    end

    function self:add_player(plr)
        AssertType:is_classname(plr, "Player")
        self.players:add(plr.UserId, Player:new(plr))
    end

    function self:get_players_list()
        local ret = {}
        for _, v in self.players:key_itr() do
            ret[#ret+1] = v
        end
        return ret
    end

    function self:remove_player(plr)
        AssertType:is_classname(plr, "Player")
        self.players:remove(plr.UserId)
    end

    function self:update_stats_for_player(plr, stats)
        AssertType:is_classname(plr, "Player")
        self:get_player(plr):update_stats(stats)
    end

    function self:get_player(plr)
        AssertType:is_classname(plr, "Player")
        return self.players:get(plr.UserId)
    end

    function self:change_song_key(key)
        self.selected_song_key = key
    end

    function self:get_player_stats()
        local ret = {}

        for i, plr in self.players:key_itr() do
            ret[#ret+1] = plr:get_stats()
        end

        return ret
    end

    function self:is_host(player)
        AssertType:is_classname(player, "Player")
        return self.host == player.UserId
    end

    function self:set_playing(val)
        self.is_playing = val
    end

    function self:get_metadata()
        return {
            name = self.name;
            id = self.id;
            selected_song_key = self.selected_song_key;
            host = self.host;
            players = self.players:key_list()._table;
        }
    end

    return self
end

return Room
