local function get_config_name(item_name, setting_name)
    local value = "tbx-balance-crafting" 
    value = value .. "-" .. item_name
    return value .. "-" .. setting_name
end

local function edit_stack_size(item_name, full_config_name)
    local stack_size_multiplier = settings.startup[full_config_name].value
    local standard_stack_size = data.raw["item"][item_name].stack_size
    local new_stack_size = standard_stack_size * stack_size_multiplier

    data.raw["item"][item_name].stack_size = new_stack_size
end

local function edit_recipe(item_name, full_config_name)

    local output_multiplier = settings.startup[full_config_name].value
    local standard_result_count = data.raw.recipe[item_name].results[1].amount

    local multi_result_count = standard_result_count * output_multiplier

    data.raw.recipe[item_name].results = {{
        type = "item",
        name = item_name,
        amount = multi_result_count
    }}
end

local items = {}
items["copper-cable"] = { stack = true, recipe = true }
items["iron-gear-wheel"] = { stack = true, recipe = true }

for item_name, item in pairs(items) do
    if item.stack then
        local full_config_name = get_config_name(item_name, "stack-size-multiplier")
        edit_stack_size(item_name, full_config_name)
    end
    
    if item.recipe then
        local full_config_name = get_config_name(item_name, "output-multiplier")
        edit_recipe(item_name, full_config_name)
    end
end

-- Adding new recipes for specific items
-- Steel furnace use 2 stone furnaces and 6 steel plates
data:extend({
    {
        type = "recipe",
        name = "tbx-steel-furnace-recicled",
        enabled = false,
        ingredients = {
            { type = "item", name = "stone-furnace", amount = 2 },
            { type = "item", name = "steel-plate", amount = 6 },
        },
        results = {
            { type = "item", name = "steel-furnace", amount = 1}
        },
        energy_required = 1
    }
})
table.insert(data.raw["technology"]["advanced-material-processing"].effects, {
    type = "unlock-recipe",
    recipe = "tbx-steel-furnace-recicled"
})

-- Electric furnace use 3 steel furnaces and 5 advanced circuits
data:extend({
    {
        type = "recipe",
        name = "tbx-electric-furnace-recicled",
        enabled = false,
        ingredients = {
            { type = "item", name = "steel-furnace", amount = 2 },
            { type = "item", name = "advanced-circuit", amount = 6 },
        },
        results = {
            { type = "item", name = "electric-furnace", amount = 1}
        },
        energy_required = 1,
    }
})
table.insert(data.raw["technology"]["advanced-material-processing-2"].effects, {
    type = "unlock-recipe",
    recipe = "tbx-electric-furnace-recicled"
})
-- Medium electric pole use 2 Small electric poles, 2 steel plates and 4 iron sticks
data:extend({
    {
        type = "recipe",
        name = "tbx-medium-electric-pole-recicled",
        enabled = false,
        ingredients = {
            { type = "item", name = "small-electric-pole", amount = 2 },
            { type = "item", name = "steel-plate", amount = 2 },
            { type = "item", name = "iron-stick", amount = 4 },
        },
        results = {
            { type = "item", name = "medium-electric-pole", amount = 1}
        },
        energy_required = 1,
    }
})
table.insert(data.raw["technology"]["electric-energy-distribution-1"].effects, {
    type = "unlock-recipe",
    recipe = "tbx-medium-electric-pole-recicled"
})