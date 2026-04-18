-- [[ NattHUB | Constants & Data ]]
local Constants = {}

Constants.VERSION = "4.0.0"
Constants.Config = {
    Version = Constants.VERSION,
    Title = "NattHUB | Sailor Piece " .. Constants.VERSION,
    Icon = "solar:planet-3-bold-duotone",
    LogoID = "rbxassetid://117953684635635",
    Folder = "NattHUB_Configs",
    Author = "by Natt Dev"
}

Constants.QuestData = {
    { Min = 0,     Max = 99,    NPC = "QuestNPC1",  Island = "Starter" },
    { Min = 100,   Max = 249,   NPC = "QuestNPC2",  Island = "Starter" },
    { Min = 250,   Max = 499,   NPC = "QuestNPC3",  Island = "Jungle" },
    { Min = 500,   Max = 749,   NPC = "QuestNPC4",  Island = "Jungle" },
    { Min = 750,   Max = 999,   NPC = "QuestNPC5",  Island = "Desert" },
    { Min = 1000,  Max = 1499,  NPC = "QuestNPC6",  Island = "Desert" },
    { Min = 1500,  Max = 1999,  NPC = "QuestNPC7",  Island = "Snow" },
    { Min = 2000,  Max = 2999,  NPC = "QuestNPC8",  Island = "Snow" },
    { Min = 3000,  Max = 3999,  NPC = "QuestNPC9",  Island = "Sailor" },
    { Min = 4000,  Max = 5000,  NPC = "QuestNPC10", Island = "Sailor" },
    { Min = 5001,  Max = 6250,  NPC = "QuestNPC11", Island = "HallowIsland" },
    { Min = 6251,  Max = 7000,  NPC = "QuestNPC12", Island = "HallowIsland" },
    { Min = 7001,  Max = 8000,  NPC = "QuestNPC13", Island = "Ninja" },
    { Min = 8001,  Max = 9000,  NPC = "QuestNPC14", Island = "Ninja" },
    { Min = 9001,  Max = 10000, NPC = "QuestNPC15", Island = "Slime" },
    { Min = 10001, Max = 10750, NPC = "QuestNPC16", Island = "Academy" },
    { Min = 10751, Max = 11500, NPC = "QuestNPC17", Island = "Kadgement" },
    { Min = 11501, Max = 12000, NPC = "QuestNPC18", Island = "Lawless" },
    { Min = 12001, Max = 99999, NPC = "QuestNPC19", Island = "Tower" }
}

Constants.MobMapping = {
    QuestNPC1 = { "Thief1", "Thief2", "Thief3", "Thief4", "Thief5" },
    QuestNPC2 = "ThiefBoss",
    QuestNPC3 = { "Monkey1", "Monkey2", "Monkey3", "Monkey4", "Monkey5" },
    QuestNPC4 = "MonkeyBoss",
    QuestNPC5 = { "DesertBandit1", "DesertBandit2", "DesertBandit3", "DesertBandit4", "DesertBandit5" },
    QuestNPC6 = "DesertBoss",
    QuestNPC7 = { "FrostRogue1", "FrostRogue2", "FrostRogue3", "FrostRogue4", "FrostRogue5" },
    QuestNPC8 = "SnowBoss",
    QuestNPC9 = { "Sorcerer1", "Sorcerer2", "Sorcerer3", "Sorcerer4", "Sorcerer5" },
    QuestNPC10 = "PandaMiniBoss",
    QuestNPC11 = { "Hollow1", "Hollow2", "Hollow3", "Hollow4", "Hollow5" },
    QuestNPC12 = { "StrongSorcerer1", "StrongSorcerer2", "StrongSorcerer3", "StrongSorcerer4", "StrongSorcerer5" },
    QuestNPC13 = { "Curse1", "Curse2", "Curse3", "Curse4", "Curse5" },
    QuestNPC14 = { "Slime1", "Slime2", "Slime3", "Slime4", "Slime5" },
    QuestNPC15 = { "AcademyTeacher1", "AcademyTeacher2", "AcademyTeacher3", "AcademyTeacher4", "AcademyTeacher5" },
    QuestNPC16 = { "Swordsman1", "Swordsman2", "Swordsman3", "Swordsman4", "Swordsman5" },
    QuestNPC17 = { "Quincy1", "Quincy2", "Quincy3", "Quincy4", "Quincy5" },
    QuestNPC18 = { "Ninja1", "Ninja2", "Ninja3", "Ninja4", "Ninja5" },
    QuestNPC19 = { "ArenaFighter1", "ArenaFighter2", "ArenaFighter3", "ArenaFighter4", "ArenaFighter5" }
}

Constants.BossConfig = {
    { Name = "Jinwoo",            Container = "TimedBossSpawn_JinwooBoss_Container",           Boss = "TimedBossSpawn_JinwooBoss",           NPCFolder = "JinwooBoss" },
    { Name = "Gojo",              Container = "TimedBossSpawn_GojoBoss_Container",             Boss = "TimedBossSpawn_GojoBoss",             NPCFolder = "GojoBoss" },
    { Name = "Sukuna",            Container = "TimedBossSpawn_SukunaBoss_Container",           Boss = "TimedBossSpawn_SukunaBoss",           NPCFolder = "SukunaBoss" },
    { Name = "Alucard",           Container = "TimedBossSpawn_AlucardBoss_Container",          Boss = "TimedBossSpawn_AlucardBoss",          NPCFolder = "AlucardBoss" },
    { Name = "Aizen",             Container = "TimedBossSpawn_AizenBoss_Container",            Boss = "TimedBossSpawn_AizenBoss",            NPCFolder = "AizenBoss" },
    { Name = "Madoka",            Container = "TimedBossSpawn_MadokaBoss_Container",           Boss = "TimedBossSpawn_MadokaBoss",           NPCFolder = "MadokaBoss" },
    { Name = "Ragna",             Container = "TimedBossSpawn_RagnaBoss_Container",            Boss = "TimedBossSpawn_RagnaBoss",            NPCFolder = "RagnaBoss" },
    { Name = "Strongest Shinobi", Container = "TimedBossSpawn_StrongestShinobiBoss_Container", Boss = "TimedBossSpawn_StrongestShinobiBoss", NPCFolder = "StrongestShinobiBoss" },
    { Name = "Yamato",            Container = "TimedBossSpawn_Yamato_Container",               Boss = "TimedBossSpawn_YamatoBoss",           NPCFolder = "YamatoBoss" },
    { Name = "Yuji",              Container = "TimedBossSpawn_YujiBoss_Container",             Boss = "TimedBossSpawn_YujiBoss",             NPCFolder = "YujiBoss" }
}

return Constants
