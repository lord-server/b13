--- Trees
--- Деревья

local path_to_file = modpath .. "/json/woods.json"
local res = json_2_table(path_to_file)

if type(res) == "table" then
    for name, v in pairs(res) do
        --print(dump(v))
        -- если какой то из нод необходимо прописать кастомную функцию, добавляем условие по имени
        --[[if name == "lava" then

        elseif name == "snow" then

        end]]
        v.description = S(v.description)
        v._help = S(v._help)
        v.sounds = node_sound_defaults({
            footstep = {
                name = "default_wood_footstep",
                gain = 0.5
            },
            dug = {
                name = "default_wood_footstep",
                gain = 1.0
            },
            dig = {
                name = "default_dig_choppy",
                gain = 1.0
            },
            place = {
                name = "default_place_node",
                gain = 1.0
            }
        })
        
        -- генерим дополнительные формы из этого материала
        if type(v._forms) == "table" then
            for _, shape in pairs(v._forms) do
                if shape == "_form_cube" then
                    minetest.register_node("nodes:"..name, v)
                else 
                    new_v = forms_handler(v,forms[shape],shape)
                    minetest.register_node("nodes:"..name..shape, new_v)
                end
            end
        else
            minetest.register_node("nodes:"..name, v)
        end
    end
end