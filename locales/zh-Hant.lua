-- Match Your Colors: English texts, the source of every translation.
-- Translators: see TRANSLATING.md. Every text shows in Mod Options Menu, which upper-cases the mod name and
-- the choices. OFF, ON and the toggles' values are the game's own words and are not here.
-- The scheme names are the game's names of its weapon paint schemes.
return {
    mod = 'match_your_colors',
    title = 'Match Your Colors',
    language = 'zh-Hant',
    strings = {
        -- The mod's category button in the MODS tab.
        ['option.mod'] = '統一配色',
        -- The choice: Off / the two directions below.
        ['option.mode.label'] = '配色方式',
        ['option.mode.helmet'] = '頭盔改爲裝甲的配色',
        ['option.mode.armor'] = '裝甲改爲頭盔的配色',
        ['option.mode.description'] = '將頭盔改爲裝甲的配色，或是裝甲改爲頭盔的配色。使用此模組的隊友可以看到更改後的配色，沒有使用的隊友則無法看到。目鏡、鏡片以及燈光保持原有顏色。',
        -- The paint scheme choice: Off / the game's weapon paint schemes below.
        ['option.scheme.label'] = '塗裝',
        ['option.scheme.description'] = '將頭盔和裝甲的配色改爲遊戲中武器的塗裝配色。使用此選項時，“配色方式”與“不適用於套裝”選項不生效，“適用於兜帽”與“適用於其他材質”選項保持生效。目鏡、鏡片以及燈光保持原有顏色。',
        ['scheme.helldiver'] = '絕地戰兵',
        ['scheme.forest'] = '森林',
        ['scheme.forest_camo'] = '森林迷彩',
        ['scheme.arctic'] = '雪地',
        ['scheme.arctic_camo'] = '雪地迷彩',
        ['scheme.desert'] = '沙漠',
        ['scheme.desert_camo'] = '沙漠迷彩',
        ['scheme.urban'] = '城市',
        ['scheme.urban_camo'] = '城市迷彩',
        ['scheme.night'] = '夜戰',
        ['scheme.venus'] = '金星',
        -- The toggles.
        ['option.sets.label'] = '不適用於套裝',
        ['option.sets.description'] = '頭盔和裝甲屬於套裝時，保持原有配色不變。',
        ['option.hoods.label'] = '適用於兜帽',
        ['option.hoods.description'] = '同樣更改兜帽的配色，比如RS-100制裁者與SC-30開拓者偵察兵的兜帽。關：兜帽與目鏡一樣保持原有配色，只更改頭盔其他部分的配色。',
        ['option.materials.label'] = '適用於其他材質',
        ['option.materials.description'] = '讓可染色的金屬部件也變爲所選配色，即鍍鉻或金色頭盔搭配白色或綠色裝甲時，也會變爲白色或綠色，而非青銅色。小金屬細節與布料仍保持原有顏色。',
        ['option.capes.label'] = '適用於披肩',
        ['option.capes.description'] = '同樣更改披肩的配色。選擇“頭盔改爲裝甲的配色”時，披肩會改爲裝甲的配色，反之。使用“塗裝”選項時則改爲塗裝的配色。開啓“不適用於套裝”選項時，屬於同一套裝的披肩保持原有顏色。徽章及其他圖案保持原有顏色。',
    },
    -- Mod Options Menu's limits, in characters.
    limits = {
        ['option.mod'] = 40, ['option.mode.label'] = 64, ['option.mode.helmet'] = 48, ['option.mode.armor'] = 48,
        ['option.mode.description'] = 400, ['option.sets.label'] = 64, ['option.sets.description'] = 400,
        ['option.hoods.label'] = 64, ['option.hoods.description'] = 400, ['option.materials.label'] = 64,
        ['option.materials.description'] = 400, ['option.scheme.label'] = 64, ['option.scheme.description'] = 400,
        ['scheme.helldiver'] = 48, ['scheme.forest'] = 48, ['scheme.forest_camo'] = 48, ['scheme.arctic'] = 48,
        ['scheme.arctic_camo'] = 48, ['scheme.desert'] = 48, ['scheme.desert_camo'] = 48, ['scheme.urban'] = 48,
        ['scheme.urban_camo'] = 48, ['scheme.night'] = 48, ['scheme.venus'] = 48, ['option.capes.label'] = 64,
        ['option.capes.description'] = 400,
    },
}
