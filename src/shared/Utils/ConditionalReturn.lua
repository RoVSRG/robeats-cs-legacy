local function ConditionalReturn(conditional, returnValue)
    if conditional then return returnValue end
    return nil
end
return ConditionalReturn
