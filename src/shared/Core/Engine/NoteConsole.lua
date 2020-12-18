local NoteConsole = {}

function NoteConsole:new()
    local self = {
        indicesPrinted = {}
    }
    function self:getCharacter(switch)
        return switch and "O" or " "
    end

    function self:print(startingIndex, note, hitObjs)
        local notesFound = {
            note.Track == 1;
            note.Track == 2;
            note.Track == 3;
            note.Track == 4;
        }

        for i = startingIndex, #hitObjs do
            local hitObj = hitObjs[i]
            if hitObj.Time ~= note.Time or self.indicesPrinted[i] then break end
            notesFound[hitObj.Track] = true
            self.indicesPrinted[i] = true
        end

        local string = string.format("%s %s %s %s",
            self:getCharacter(notesFound[1]),
            self:getCharacter(notesFound[2]),
            self:getCharacter(notesFound[3]),
            self:getCharacter(notesFound[4])
        )

        print(string)
    end
    return self
end

return NoteConsole
