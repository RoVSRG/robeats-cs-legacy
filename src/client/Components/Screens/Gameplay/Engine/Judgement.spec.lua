local Judgement = require(script.Parent.Judgement)

return function()
    it("should properly handle hits outside bounds", function()
        local result = Judgement:new({
            currentAudioTime = 10000;
            judgementTime = 20000;
        })
        expect(result.judgement).to.equal(0)
    end)

    it("should return the proper judgement for given millsecond values", function()
        local result = Judgement:new({
            currentAudioTime = 10000;
            judgementTime = 10000;
        })
        expect(result.judgement).to.equal(5)

        result = Judgement:new({
            currentAudioTime = 10000;
            judgementTime = 10082;
        })
        expect(result.judgement).to.equal(3)

        result = Judgement:new({
            currentAudioTime = 10000;
            judgementTime = 9918;
        })
        expect(result.judgement).to.equal(3)

        result = Judgement:new({
            currentAudioTime = 10000;
            judgementTime = 9917;
        })
        expect(result.judgement).to.equal(2)
    end)
end