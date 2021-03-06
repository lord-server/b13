--- Bricks
--- Кирпичи

local path_to_file_res = modpath .. "/json/bricks.json"
local res = json_2_table(path_to_file_res)

--[[local function on_construct_dirt_with_grass(pos)
    local node = minetest.get_node(pos)
    if node.param2 == 0 then
        local new_node = mcl_core.get_grass_block_type(pos)
        if new_node.param2 ~= 0 or new_node.name ~= "mcl_core:dirt_with_grass" then
            minetest.set_node(pos, new_node)
        end
    end
    return mcl_core.on_snowable_construct(pos)
end]]--

if type(res) == "table" then
    for name, v in pairs(res) do
        --print(dump(v))
        -- если какой то из нод необходимо прописать кастомную функцию, добавляем условие по имени
        if name == "andesite" then
        --    v.on_construct = on_construct_dirt_with_grass(pos)
        --elseif name == "snow" then

        end
        v.description = S(v.description)
        v._help = S(v._help)
        v.sounds = node_sound_defaults(v.sounds)
        
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