/*
** Extricate
** By Lyliya
*/

state("Extricate")
{
    uint lvl : "UnityPlayer.dll", 0x01771968, 0x60, 0x10, 0x70, 0x20, 0x18, 0xF6C;
    float igt : "UnityPlayer.dll", 0x0179E8E0, 0xE20, 0x228, 0x98, 0x80, 0x0, 0x6C;
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
    return TimeSpan.FromMilliseconds(current.igt);
}

shutdown {
}