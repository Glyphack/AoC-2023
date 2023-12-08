-- write a function that prints a lua table
local function print_table(t)
    for k, v in pairs(t) do
        print(k, v)
    end
end

function string:endswith(ending)
    return ending == "" or self:sub(-#ending) == ending
end

-- print("input:")

-- local input = io.read("a")

-- Open a file in read mode
local file = io.open("./input_8_2.txt", "r")

-- Check if the file is successfully opened
if file then
    -- Read the entire content of the file
    content = file:read("*a")

    -- Display the content
    print("File content:\n" .. content)

    -- Close the file handle
    file:close()
else
    print("Failed to open the file.")
end

local input = content

-- split the input with newlines

local lines = {}

for line in input:gmatch("[^\r\n]+") do
    table.insert(lines, line)
end

local navigation = {}

-- iterate over characters of first element of lines and add them to navigation
for i = 1, #lines[1] do
    table.insert(navigation, string.sub(lines[1], i, i))
end

local map = {}
local current_locations = {}

for i = 2, #lines do
    local line = lines[i]
    local equal_pos = line:find("=")
    local key = line:sub(1, equal_pos - 2)
    local value = line:sub(equal_pos + 3)
    local left, right = value:match("(%w+),%s(%w+)")
    if key:endswith("A") then
        table.insert(current_locations, key)
    end
    map[key] = {left, right}
end

local count = 1
local i = 1

print_table(current_locations)
print_table(navigation)

while true do
    local action = navigation[i]
    if action == "L" then
        action = 1
    elseif action == "R" then
        action = 2
    end
    -- print("action ".. action)
    local all_zzz = true
    for j, current_location in ipairs(current_locations) do
        local new_location = map[current_location][action]
        current_locations[j] = new_location
        if not new_location:endswith("Z") then
            all_zzz = false
            break
        end
    end
    -- print_table(current_locations)
    if all_zzz then
        print("count ".. count)
        break
    end
    count = count + 1
    i = i + 1
    if i > #navigation then
        i = 1
    end
end

