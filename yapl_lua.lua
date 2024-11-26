Yapl_lua = Yapl_lua or {}
Yapl_lua.Util = {}

function Yapl_lua.Util:CombinedFingerprint(input)
    local hash = 0
    local prime = 37
    local modulus = 1e9 + 9
    for i = 1, #input do
        local char_value = input:byte(i)
        hash = (hash * prime + bit.bxor(char_value, (i % 256))) % modulus
    end
    return hash
end

function Yapl_lua.Util:clock()
    Yapl_lua.Date = date("%Y-%m-%d")
    Yapl_lua.Time = date("%H:%M:%S")
    Yapl_lua.Timestamp = date("%Y-%m-%d %H:%M:%S")
    Yapl_lua.Hour = date("%H")
    Yapl_lua.Min = date("%M")
    Yapl_lua.Sec = date("%S")
end

function Yapl_lua.Util:TimeOfDay()
    Yapl_lua.Util:ChronoSet()
    local hour = tonumber(Yapl_lua.Hour)
    if hour < 12 then
        return "morning"
    elseif hour < 18 then
        return "afternoon"
    else
        return "evening"
    end
end

function Yapl_lua.Util:CompareLists(listA, listB)
    local uniqueElementsA = {}
    local uniqueElementsB = {}
    local commonElements = {}
    for _, elementA in ipairs(listA) do
        local found = false
        for _, elementB in ipairs(listB) do
            if elementA == elementB then
                table.insert(commonElements, elementA)
                found = true
                break
            end
        end
        if not found then
            table.insert(uniqueElementsA, elementA)
        end
    end
    for _, elementB in ipairs(listB) do
        local found = false
        for _, elementA in ipairs(listA) do
            if elementB == elementA then
                found = true
                break
            end
        end
        if not found then
            table.insert(uniqueElementsB, elementB)
        end
    end
    return uniqueElementsA, uniqueElementsB, commonElements
end

function Yapl_lua.Util:SerializeTable(o)
    if type(o) == "table" then
        local keys = {}
        for k in pairs(o) do
            table.insert(keys, k)
        end
        table.sort(keys)
        local result = "{"
        for _, k in ipairs(keys) do
            result = result .. "[" .. serialize(k) .. "]=" .. serialize(o[k]) .. ","
        end
        return result .. "}"
    elseif type(o) == "string" then
        return string.format("%q", o)
    else
        return tostring(o)
    end
end

function Yapl_lua.Util.PrintG(string)
    print("|cff00ff00" .. string .. "|r")
end
