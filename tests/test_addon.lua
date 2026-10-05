-- Match Your Colors: the frame step against a simulated game (tests/fake_game.lua) with a local and a remote
-- player: who is recolored, re-equip, previews (the gameplay copies and the UI preview), options, pause, texture
-- lifetime, and the exact calls each kind of frame makes (tests/frame_budget.lua). The job is replaced by a canned one (the real job reads the
-- game's files; tests/test_parity.lua covers it), so these tests need no game install.
-- Usage: luajit tests/test_addon.lua <repository root>
local root = assert(arg and arg[1], 'usage: test_addon.lua <repository root>')
package.path = root .. '/src/?.lua;' .. package.path
local ffi = require('ffi')
local Avatar, Engine, Recolor, Addon = require('avatar'), require('engine'), require('recolor'), require('addon')
local Preview = require('preview')
local Fake = dofile(root .. '/tests/fake_game.lua')
local budget = dofile(root .. '/tests/frame_budget.lua')
local passed = 0
local function check(name, fn)
    fn()
    passed = passed + 1
end

local HELMET_LUT, ARMOR_LUT, OTHER_LUT = '962a946e964ebc40', 'a007a73e4082430e', '1111111111111111'
local SET_HELMET = 0x5e7e7e7e
local HELMET_PATTERN = 'f18dfbb5346732c1'
local VANILLA = {[HELMET_LUT] = 0x190000000, [ARMOR_LUT] = 0x190001000, [OTHER_LUT] = 0x190002000,
                 [HELMET_PATTERN] = 0x190003000}
local with_patterns = false -- the canned job also plans the helmet's pattern (v11.4)

-- The canned job: the plan changes the target kit's one LUT. It calls yield 20 times (the fake clock moves
-- 0.1 ms per read, so the 1.5 ms budget makes it span two frames).
local jobs = 0
local function fake_job(_, _, request, yield)
    jobs = jobs + 1
    for _ = 1, 20 do yield() end
    if request.mode == Recolor.OFF then return {action = 'restore', reason = 'off'} end
    if request.keep_sets and request.helmet == SET_HELMET then return {action = 'restore', reason = 'complete set'} end
    local helmet = request.mode == Recolor.HELMET_FROM_ARMOR
    local lut = helmet and HELMET_LUT or ARMOR_LUT
    local pieces = helmet and {{piece = {slot = 0, type = 0, body = 3}, materials = {{lut = lut}}, skin = false}}
        or {{piece = {slot = 2, type = 0, body = 0}, materials = {{lut = lut}}, skin = false},
            {piece = {slot = 3, type = 1, body = 3}, materials = {{lut = lut}}, skin = false},
            {piece = {slot = 4, type = 0, body = 0}, materials = {{lut = lut}}, skin = true}}
    return {action = 'apply', key = table.concat({request.mode, request.helmet, request.armor, request.body}, ':'),
            luts = {[lut] = {width = 23, height = 8, data = ffi.new('float[?]', 23 * 8 * 4)}},
            patterns = with_patterns and helmet and {[HELMET_PATTERN] = {width = 3, height = 1,
                                                                         data = ffi.new('float[12]')}} or nil,
            first = helmet and 0 or 1, last = helmet and 0 or 9,
            target = {kit = {kit_type = helmet and 'Helmet' or 'Armor'}, pieces = pieces}}
end
local TestRecolor = setmetatable({job = fake_job}, {__index = Recolor})

-- A fresh world: local helmet unit 0x100 (slot 0), armor units 0x101 (torso) and 0x102 (hips undergarment),
-- 0x103 (a skin piece, left leg); the remote player's helmet 0x200 uses the same helmet LUT.
local function setup(options)
    options = options or {}
    local space = Fake.world({previews = options.previews, ui = options.ui, players = options.players,
        helmet = options.helmet,
        local_units = {[{0, 0}] = 0x100, [{0, 2}] = 0x101, [{1, 3}] = 0x102, [{0, 4}] = 0x103},
        remote_units = {[{0, 0}] = 0x200}})
    local engine = Fake.engine(space, VANILLA)
    engine.unit(0x100, HELMET_LUT, nil, options.patterns and HELMET_PATTERN or nil)
    engine.unit(0x101, ARMOR_LUT) engine.unit(0x102, ARMOR_LUT)
    engine.unit(0x103, ARMOR_LUT) engine.unit(0x200, HELMET_LUT)
    local memory = Fake.memory(space)
    local memory_calls, native_calls = budget.wrap(memory), budget.wrap(engine.native)
    local lines = {}
    local instance = Addon.new({Avatar = Avatar, Preview = Preview, Recolor = TestRecolor, Engine = Engine, memory = memory,
                                native = engine.native, game = Fake.GAME, note = function(l) lines[#lines + 1] = l end})
    local world = {space = space, engine = engine, memory = memory, instance = instance, lines = lines}
    -- One frame: the calls it made to memory and to the engine, merged ('read_into', 'alive', ...).
    function world.frame()
        for k in pairs(memory_calls) do memory_calls[k] = nil end
        for k in pairs(native_calls) do native_calls[k] = nil end
        instance.step()
        local all = {}
        for k, v in pairs(memory_calls) do all[k] = v end
        for k, v in pairs(native_calls) do all[k] = (all[k] or 0) + v end
        return all
    end
    function world.frames(count)
        local last
        for _ = 1, count do last = world.frame() end
        return last
    end
    function world.bound(unit) -- the LUT object of each of the unit's materials
        local out = {}
        for i, m in ipairs(engine.units[unit].materials) do out[i] = engine.binding(m.material) end
        return out
    end
    return world
end

local function same(a, b)
    for k, v in pairs(a) do if b[k] ~= v then return false end end
    for k, v in pairs(b) do if a[k] ~= v then return false end end
    return true
end
local function expect(frame, expected, label)
    assert(same(frame, expected), label .. ': ' .. budget.describe(frame) .. ', expected ' .. budget.describe(expected))
end

-- Calls of the exact frame kinds (Steam build 25480438 layout). Idle: the avatar's unit bytes, plus the
-- preview slot's count when the local player has a slot. Every 30th frame also checks one recolored material
-- per runtime texture: two reads each (one texture for the helmet).
local IDLE = {read_into = 1}
local IDLE_PREVIEW = {read_into = 2}
local CHECK = {read_into = 3}
local CHECK_PREVIEW = {read_into = 4}
-- A planned pattern is one more runtime texture: the 30-frame check reads two more (v11.4, the helmet's pattern).
local CHECK_PATTERN = {read_into = 5}

-- Over `count` frames: how many were exactly `idle`, exactly `check`, and other (the 2-second chain check,
-- reads and alive() only).
local function classify(w, count, idle, check)
    local n = {idle = 0, check = 0, other = 0}
    for _ = 1, count do
        local f = w.frame()
        if same(f, idle) then
            n.idle = n.idle + 1
        elseif same(f, check) then
            n.check = n.check + 1
        else
            n.other = n.other + 1
            for k in pairs(f) do assert(k == 'read_into' or k == 'alive', 'unexpected call on a check frame: ' .. k) end
        end
    end
    return n
end

check('no local Helldiver: nothing between resolves, one resolve every 15 frames', function()
    local w = setup({players = 0})
    local first = w.frame()
    assert(first.read_into and first.read_into <= 3, 'resolve stops at the player count: ' .. budget.describe(first))
    for i = 2, 15 do expect(w.frame(), {}, 'frame ' .. i) end
    assert(w.frame().read_into, 'frame 16 resolves again')
    assert(#w.engine.created == 0 and jobs == 0, 'nothing applied')
end)

check('the local helmet takes the plan; the remote player and the armor keep theirs', function()
    local w = setup()
    w.frames(3) -- resolve, then the job over two frames, applied on the second
    local texture = w.engine.created[1]
    assert(texture and texture.alive, 'one texture')
    for _, object in ipairs(w.bound(0x100)) do assert(object == texture.object, 'local helmet recolored') end
    for _, object in ipairs(w.bound(0x200)) do assert(object == VANILLA[HELMET_LUT], 'remote helmet untouched') end
    for _, object in ipairs(w.bound(0x101)) do assert(object == VANILLA[ARMOR_LUT], 'armor untouched') end
    assert(#w.engine.created == 1, 'exactly one texture')
end)

check('idle frames: one read (two with a preview slot); +2 every 30 frames; the chain every 120', function()
    for _, previews in ipairs({false, true}) do
        local w = setup({previews = previews})
        w.frames(5)
        local n = classify(w, 240, previews and IDLE_PREVIEW or IDLE, previews and CHECK_PREVIEW or CHECK)
        -- 240 frames: 8 material checks and 2 chain checks; a chain check may fall on a check frame.
        assert(n.idle + n.check + n.other == 240 and n.other == 2 and n.check >= 6 and n.check <= 8
               and n.idle == 240 - n.check - n.other, string.format('idle %d, check %d, other %d', n.idle, n.check,
               n.other))
    end
end)

check('the game putting the original LUT back is noticed within 30 frames and recolored again', function()
    local w = setup()
    w.frames(3)
    local texture = w.engine.created[1]
    local material = w.engine.units[0x100].materials[1].material
    w.space.u64(material + 0x48, VANILLA[HELMET_LUT]) -- as the game's own set_texture would
    w.frames(33)
    assert(w.engine.binding(material) == texture.object, 'recolored again with the same texture')
    local seen = false
    for _, line in ipairs(w.lines) do if line:find('original color texture back', 1, true) then seen = true end end
    assert(seen and #w.engine.created == 1, 'logged, no new texture')
end)

check('re-equip: the new helmet unit is recolored with the same texture, the old one retired never', function()
    local w = setup()
    w.frames(3)
    local texture = w.engine.created[1]
    w.engine.units[0x100].alive = false
    w.engine.unit(0x104, HELMET_LUT)
    w.space.u32(Fake.local_unit_at(0, 0), 0x104)
    w.frames(3)
    for _, object in ipairs(w.bound(0x104)) do assert(object == texture.object, 'new unit recolored') end
    assert(#w.engine.created == 1 and texture.alive, 'same texture kept')
end)

check('preview entries of the local player are recolored, the remote player\'s are not', function()
    local w = setup({previews = true})
    w.frames(3)
    w.engine.unit(0x105, HELMET_LUT)
    w.engine.unit(0x205, HELMET_LUT)
    w.space.u32(Fake.preview_entry_at(1, 0) + 12, 0x105) -- local slot, entry 0, helmet
    w.space.u32(Fake.PREVIEWS + 2080 + 2184 + 64, 1)
    w.space.u32(Fake.preview_entry_at(0, 0) + 12, 0x205) -- remote slot
    w.space.u32(Fake.PREVIEWS + 2080 + 64, 1)
    w.frames(3)
    local texture = w.engine.created[1]
    for _, object in ipairs(w.bound(0x105)) do assert(object == texture.object, 'local preview recolored') end
    for _, object in ipairs(w.bound(0x205)) do assert(object == VANILLA[HELMET_LUT], 'remote preview untouched') end
    local n = classify(w, 30, {read_into = 3}, {read_into = 3 + 2})
    assert(n.idle >= 28 and n.other == 0, 'idle with one local preview entry: units, count, entries')
end)

check('Off puts the vanilla LUT back and destroys the texture four frames later', function()
    local w = setup()
    w.frames(3)
    local texture = w.engine.created[1]
    w.instance.set_option('mode', Recolor.OFF)
    w.frames(3) -- the job spans two frames, restore on the second
    for _, object in ipairs(w.bound(0x100)) do assert(object == VANILLA[HELMET_LUT], 'helmet back to vanilla') end
    assert(texture.alive, 'not destroyed at once')
    w.frames(4)
    assert(not texture.alive, 'destroyed after the retire delay')
end)

check('armor matches helmet: armor units recolored, skin pieces and the helmet untouched', function()
    local w = setup()
    w.instance.set_option('mode', Recolor.ARMOR_FROM_HELMET)
    w.frames(3)
    local texture = w.engine.created[1]
    for _, unit in ipairs({0x101, 0x102}) do
        for _, object in ipairs(w.bound(unit)) do assert(object == texture.object, 'armor unit recolored') end
    end
    for _, object in ipairs(w.bound(0x103)) do assert(object == VANILLA[ARMOR_LUT], 'skin piece untouched') end
    for _, object in ipairs(w.bound(0x100)) do assert(object == VANILLA[HELMET_LUT], 'helmet untouched') end
end)

check('switching direction restores the old target before recoloring the new one', function()
    local w = setup()
    w.frames(3)
    local first = w.engine.created[1]
    w.instance.set_option('mode', Recolor.ARMOR_FROM_HELMET)
    w.frames(3)
    for _, object in ipairs(w.bound(0x100)) do assert(object == VANILLA[HELMET_LUT], 'helmet restored') end
    for _, object in ipairs(w.bound(0x101)) do assert(object == w.engine.created[2].object, 'armor recolored') end
    w.frames(4)
    assert(not first.alive and w.engine.created[2].alive, 'only the retired texture destroyed')
end)

check('complete sets stay vanilla while the option is on', function()
    local w = setup({helmet = SET_HELMET})
    w.frames(3)
    assert(#w.engine.created == 0, 'no texture for a complete set')
    w.instance.set_option('keep_sets', false)
    w.frames(3)
    assert(#w.engine.created == 1, 'recolored once the option is off')
end)

check('a pause restores at once; the next frames start over', function()
    local w = setup()
    w.frames(3)
    w.instance.pause('test')
    for _, object in ipairs(w.bound(0x100)) do assert(object == VANILLA[HELMET_LUT], 'vanilla during the pause') end
    w.frames(10)
    for _, object in ipairs(w.bound(0x100)) do
        assert(object == w.engine.created[2].object, 'recolored again after the pause')
    end
end)

check('kits that change while a job runs discard its result', function()
    local w = setup()
    w.frame() -- resolve
    w.frame() -- job starts, yields
    w.space.u32(Fake.CUSTOMIZATION + 2416, 0x99999999) -- another helmet before the job ends
    w.frame() -- job ends: discarded, a new job starts on the next frame
    assert(#w.engine.created == 0, 'stale result not applied')
    w.frames(4)
    assert(#w.engine.created == 1, 'applied for the new kits')
end)

-- UI preview (the Armory CHARACTER view): helmet 0x0b0b0b0b is hovered, so the preview shows another pair.
local HOVERED = {helmet = 0x0b0b0b0b, armor = 0x0ade6719, body = 0}

check("the local UI preview takes its own plan (a hovered helmet); the remote player's preview stays", function()
    local w = setup({ui = true})
    w.frames(3)
    local avatar_texture = w.engine.created[1]
    w.engine.unit(0x300, HELMET_LUT) -- the local preview's helmet
    w.engine.unit(0x301, HELMET_LUT) -- the remote player's preview helmet
    Fake.show_ui(w.space, 1, HOVERED, {[{0, 0}] = 0x300})
    Fake.show_ui(w.space, 3, {helmet = 0x0c0c0c0c, armor = 0x22222222, body = 0}, {[{0, 0}] = 0x301})
    w.frames(7) -- seen within 4 frames (the gate), then the job over two frames
    local preview_texture = w.engine.created[2]
    assert(preview_texture and #w.engine.created == 2, 'one texture for the preview pair')
    for _, object in ipairs(w.bound(0x300)) do assert(object == preview_texture.object, 'local preview recolored') end
    for _, object in ipairs(w.bound(0x301)) do assert(object == VANILLA[HELMET_LUT], 'remote preview untouched') end
    for _, object in ipairs(w.bound(0x100)) do assert(object == avatar_texture.object, 'the avatar keeps its own') end
    local seen = false
    for _, line in ipairs(w.lines) do
        if line:find('Preview recolored: 2 materials (helmet 0b0b0b0b', 1, true) then seen = true end
    end
    assert(seen, 'logged')
end)

check("a hover change re-plans the preview; closing it retires only the preview's textures", function()
    local w = setup({ui = true})
    w.frames(3)
    w.engine.unit(0x300, HELMET_LUT)
    Fake.show_ui(w.space, 1, HOVERED, {[{0, 0}] = 0x300})
    w.frames(7)
    local first = assert(w.engine.created[2], 'preview texture')
    w.engine.units[0x300].alive = false -- the game replaces the piece units on a hover change
    w.engine.unit(0x302, HELMET_LUT)
    Fake.show_ui(w.space, 1, {helmet = 0x0d0d0d0d, armor = 0x0ade6719, body = 0}, {[{0, 0}] = 0x302})
    w.frames(3)
    local second = assert(w.engine.created[3], 'a texture for the new pair')
    for _, object in ipairs(w.bound(0x302)) do assert(object == second.object, 'the new helmet recolored') end
    w.frames(5)
    assert(not first.alive and second.alive, "the previous pair's texture destroyed after the retire delay")
    Fake.show_ui(w.space, 1, nil)
    w.frames(6)
    assert(not second.alive and w.engine.created[1].alive, 'preview textures retired; the avatar keeps its own')
end)

check('UI preview cost: +1 read on 1 frame in 4 while it is not shown, +2 reads per frame while it is', function()
    local w = setup({ui = true})
    w.frames(5)
    local gates, others = 0, 0 -- others: the 30-frame material check and the 120-frame chain check add reads
    for _ = 1, 40 do
        local f = w.frame()
        local gate = w.instance.state.frame % Addon.UI_GATE_FRAMES == 0
        if gate then gates = gates + 1 end
        if not same(f, {read_into = gate and 2 or 1}) then others = others + 1 end
    end
    assert(gates == 10 and others <= 2, string.format('gate frames %d, other frames %d', gates, others))
    w.engine.unit(0x300, HELMET_LUT)
    Fake.show_ui(w.space, 1, HOVERED, {[{0, 0}] = 0x300})
    w.frames(8)
    local shown = 0
    for _ = 1, 20 do if same(w.frame(), {read_into = 3}) then shown = shown + 1 end end
    assert(shown >= 18, 'avatar units, gate and record on ' .. shown .. ' of 20 frames')
end)

check('a planned pattern takes its own texture on the pattern slot, is checked every 30 frames and put back', function()
    with_patterns = true
    local w = setup({patterns = true})
    w.frames(3)
    assert(#w.engine.created == 2, 'two textures (LUT and pattern), got ' .. #w.engine.created)
    local material = w.engine.units[0x100].materials[1].material
    local lut, pattern = w.engine.binding(material), w.engine.binding(material, Fake.PATTERN_SLOT)
    assert(lut ~= VANILLA[HELMET_LUT] and pattern ~= VANILLA[HELMET_PATTERN] and lut ~= pattern, 'both slots recolored')
    for _, object in ipairs(w.bound(0x200)) do assert(object == VANILLA[HELMET_LUT], 'remote helmet untouched') end
    local n = classify(w, 120, IDLE, CHECK_PATTERN)
    assert(n.check >= 3 and n.idle + n.check + n.other == 120, string.format('idle %d, check %d, other %d', n.idle,
           n.check, n.other))
    w.space.u64(w.engine.entry(material, Fake.PATTERN_SLOT) + 8, VANILLA[HELMET_PATTERN]) -- the game's own reset
    w.frames(33)
    assert(w.engine.binding(material, Fake.PATTERN_SLOT) == pattern and #w.engine.created == 2,
           'the pattern recolored again with the same texture')
    w.instance.set_option('mode', Recolor.OFF)
    w.frames(3)
    assert(w.engine.binding(material) == VANILLA[HELMET_LUT]
           and w.engine.binding(material, Fake.PATTERN_SLOT) == VANILLA[HELMET_PATTERN], 'both slots back to vanilla')
    w.frames(4)
    for _, texture in ipairs(w.engine.created) do assert(not texture.alive, 'textures destroyed') end
    with_patterns = false
end)

if rawget(_G, 'MYC_TEST_SETUP_ONLY') then return setup end
print('PASS test_addon (' .. passed .. ' checks)')
