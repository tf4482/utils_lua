Util = Util or {}
Util.Util = {}

function Util.Util:CombinedFingerprint(input)
    local hash = 0
    local prime = 37
    local modulus = 1e9 + 9
    for i = 1, #input do
        local char_value = input:byte(i)
        hash = (hash * prime + bit.bxor(char_value, (i % 256))) % modulus
    end
    return hash
end

function Util.Util:CompareLists(listA, listB)
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

function Util.Util:InitializeNestedTable(tbl, defaultValue, ...)
    local keys = {...}
    local current = tbl
    for i, key in ipairs(keys) do
        if i == #keys then
            current[key] = current[key] or defaultValue
        else
            current[key] = current[key] or {}
            current = current[key]
        end
    end
    return tbl
end

function Util.Util:TimeOfDay()
    Util.Util:ChronoSet()
    local hour = tonumber(Util.Hour)
    if hour < 12 then
        return "morning"
    elseif hour < 18 then
        return "afternoon"
    else
        return "evening"
    end
end

function Util.Util.PrintG(string)
    print("|cff00ff00" .. string .. "|r")
end

function Util.Util.SumElements(tbl,key)
    local sum = 0
    for _, element in ipairs(tbl) do
        sum = sum + element[key]
    end
    return sum
end

function Util.Util:SumFingerPrints(tbl)
    local sum = 0
    for _, element in ipairs(tbl) do
        sum = sum + element.fingerprint
    end
    return sum
end

function Util.Util:GetNextFreeIndex(tbl)
    local index = 1
    while tbl[index] do
        index = index + 1
    end
    return index
end

function Util.Util.validate(param, expectedType, paramName, allowNil)
    if allowNil and param == nil then
        return true
    end
    if type(param) ~= expectedType then
        error(string.format("Ungültiger Parameter '%s': Erwartet '%s', erhalten '%s'.",
            paramName, expectedType, type(param)))
    end
    return true
end


function Util.Util.validateNonEmptyString(param, paramName)
    Util.Util.validate(param, "string", paramName)
    if param == "" then
        error(string.format("Parameter '%s' darf nicht leer sein.", paramName))
    end
end

function Util.Util.validateNumberInRange(param, min, max, paramName)
    Util.Util.validate(param, "number", paramName)
    if param < min or param > max then
        error(string.format("Parameter '%s' muss zwischen %d und %d liegen. Erhalten: %d",
            paramName, min, max, param))
    end
end
