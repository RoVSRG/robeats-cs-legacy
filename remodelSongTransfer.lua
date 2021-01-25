local Models = remodel.readModelFile("models/Songs.rbxmx")

remodel.createDirAll("songs")

string.split = function(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

local couldntBe = {
    "This is a list of songs that could NOT be automatically added to the rewrite, due to string formatting errors. These will have to be added manually.",
    "------------------------------------------------------------------------------------------------------------------------------------------------------",
    "",
    ""
}

local numOfCouldntBe = 0

local forbiddenCharacters = {"&", "\"", "?", "<", ">", "#", "{", "}", "%", "~", "/", "\\", ".", "^"}

for _, model in ipairs(Models[1]:GetChildren()) do
    local woDiff = "%[(%d+)%]%s+(.+)%s+%-%s+(.+)%s+%((.+)%)"
    local wiDiff = "%[(%d+)%]%[(.+)%]%s+(.+)%s+%-%s+(.+)%s+%((.+)%)"

    local hasDiffData = string.match(model.Name, "%[.+%]%[.+%]") ~= nil

    local id, diffName, artist, fileName, mapper

    if hasDiffData then
        id, diffName, artist, fileName, mapper  = string.match(model.Name, wiDiff)
    else
        id, artist, fileName, mapper  = string.match(model.Name, woDiff)
    end

    artist = artist or "Unknown Artist"
    fileName = fileName or "Unknown File Name"

    if id == nil then
        couldntBe[#couldntBe+1] = model.Name
    end

    local diff = model:FindFirstChild("SongDiff") and remodel.getRawProperty(model:FindFirstChild("SongDiff"), "Value") or 0

    local source = remodel.getRawProperty(model, "Source")

    if diffName then
        fileName = string.format("%s (%s)", fileName, diffName)
    end

    local sourceLines = string.split(source, "\n")

    local lineToCallback = {
        ["rtv.AudioDifficulty"] = function(i)
            sourceLines[i] = string.format("rtv.AudioDifficulty = %d", diff)
        end;
        ["rtv.AudioArtist"] = function(i)
            sourceLines[i] = string.format("rtv.AudioArtist = \"%s\"", artist)
        end;
        ["rtv.AudioFilename"] = function(i)
            sourceLines[i] = string.format("rtv.AudioFilename = \"%s\"", fileName)
        end;
    }

    for i, line in ipairs(sourceLines) do
        for checkKey, callback in pairs(lineToCallback) do
            if string.find(line, checkKey) ~= nil then
                callback(i)
            end
        end
    end

    local export = string.gsub(artist..fileName, " ", "")

    for _, forbiddenCharacter in pairs(forbiddenCharacters) do
        if forbiddenCharacter == "%" then
            forbiddenCharacter = "%%"
        end
        string.gsub(export, forbiddenCharacter, "")
    end

    local toRemove = -1

    for i, v in pairs(sourceLines) do
        if v == "local maxPoints = 0" then
            print(string.format("Removing unwanted line \"%s\" at %d", v, i))
            toRemove = i
        end
    end

    if toRemove ~= -1 then
        for _ = 1, 3 do
            print(table.remove(sourceLines, toRemove))
        end
    end

    local suc, err = pcall(function()
        remodel.writeFile(string.format("songs/%s.lua", export), table.concat(sourceLines, "\n"))
    end)

    if not suc then
        numOfCouldntBe = numOfCouldntBe + 1

        local errorMessage = string.format("Error adding file: %s, \"%s\"", model.Name, err)
        print(errorMessage)
        couldntBe[#couldntBe+1] = errorMessage
    end
end

couldntBe[#couldntBe+1] = string.format("%d maps could not be added automatically. To add these, you must add them manually.", numOfCouldntBe)

remodel.writeFile("errorLog.txt", table.concat(couldntBe, "\n"))
