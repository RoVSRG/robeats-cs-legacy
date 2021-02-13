local HitObject = require(script.Parent.HitObject)

return function()
    it("should be createable", function()
        local object = HitObject:new({
            pressTime = 0;
            scrollSpeed = 100;
        })

        expect(object).to.be.ok()
    end)

    it("should implicity take in paramaters and determine the type", function()
        -- regular note
        local object = HitObject:new({
            pressTime = 0;
            scrollSpeed = 100;
        })

        expect(object.type).to.equal(1)

        --hold note

        local object = HitObject:new({
            pressTime = 0;
            releaseTime = 10;
            scrollSpeed = 100;
        })

        expect(object.type).to.equal(2)
    end)

    it("should interpolate based on current audio time", function()
        local object = HitObject:new({
            pressTime = 0;
            scrollSpeed = 100;
        })

        object:update(-50)

        expect(object.pressTimeAlpha).to.equal(0.5)
    end)

    it("should determine the proper judgement based on current audio time/press/release times", function()
        local object = HitObject:new({
            pressTime = 0;
            scrollSpeed = 100;
        })

        object:update(0);

        expect(object:currentPressJudgement().judgement).to.equal(5)

        object = HitObject:new({
            pressTime = 0;
            releaseTime = 100;
            scrollSpeed = 100;
        })

        object:update(100);

        expect(object:currentPressJudgement().judgement).to.equal(2)
        expect(object:currentReleaseJudgement().judgement).to.equal(5)
    end)

    it("should remove itself when needed", function()
        local object = HitObject:new({
            pressTime = 0;
            releaseTime = 10;
            scrollSpeed = 100;
        })

        object:update(147)

        expect(object:shouldRemove()).to.equal(true)

        object = HitObject:new({
            pressTime = 5;
            scrollSpeed = 100;
        })

        object:update(142)

        expect(object:shouldRemove()).to.equal(true)
    end)
end