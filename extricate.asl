/*
** Extricate
** By Lyliya
*/

state("Extricate")
{
    uint lvl : "UnityPlayer.dll", 0x01771860, 0x60, 0x10, 0x98, 0x18, 0xE0, 0xF6C;
    float igt : "mono-2.0-bdwgc.dll", 0x004A3450, 0x2B0, 0xCC0, 0x108, 0x10, 0x10, 0x0, 0x524;
}

init
{
    vars.reset = 1;
}

update
{
    print("igt:" + current.igt);
    if (current.igt < old.igt) {
        vars.reset = 1;
    }
}

startup
{
    settings.Add("section0", true, "Section A");
    settings.Add("section1", true, "Section B");
    settings.Add("section2", true, "Section C");
    settings.Add("section3", true, "Section D");
    settings.Add("section4", true, "Section E");
    for (int i = 0; i < 50; i++) {
        int section = (i / 10);
        int lvl = i - (10 * section) + 1;
        char lsection = (char)(section + 65);
        settings.Add("level_"+i, true, lsection.ToString() + lvl.ToString().PadLeft(2, '0'), "section" + section);
    }
}

start
{
    if (vars.reset == 1 && current.lvl == 1) {
        vars.reset = 0;
        return true;
    }
}

split
{
    if (current.lvl > old.lvl) {
        return settings["level_"+(old.lvl - 1)];
    }
}

reset
{
}

isLoading
{
    return true;
}

gameTime
{
    return TimeSpan.FromMilliseconds(Math.Floor(current.igt));
}

shutdown {
}