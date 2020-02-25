/*
** Color Symphony 2 RTA
** By Lyliya
*/

state("Extricate")
{
    uint lvl : "mono-2.0-bdwgc.dll", 0x0048FA90, 0xBC0, 0x3C8, 0x70, 0x9F8;
    float igt : "UnityPlayer.dll", 0x015F5EF8, 0x1F0, 0x2A0, 0x4E0, 0x438, 0x80, 0x10, 0x72C;
}

init
{
    vars.reset = 1;
}

update
{
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
