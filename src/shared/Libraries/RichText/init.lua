local RichText = {}

function RichText:bold(str)
    return string.format("<b>%s</b>", str)
end

function RichText:italic(str)
    return string.format("<i>%s</i>", str)
end

function RichText:underline(str)
    return string.format("<u>%s</u>", str)
end

function RichText:strikethrough(str)
    return string.format("<s>%s</s>", str)
end

function RichText:font(str, properties)
    local property_str = ""
    if properties.Face then
        property_str ..= string.format("face=\"%s\" ", properties.Face)
    end
    if properties.Size then
        property_str ..= string.format("size=\"%s\" ", properties.Size)
    end
    if properties.Color then
        property_str ..= string.format("color=\"rgb(%s, %s, %s)\"", properties.Color.R, properties.Color.G, properties.Color.B)
    end
    return string.format("<font %s>%s</font>", property_str, str)
end

function RichText:text(str)
    return str
end

return RichText
