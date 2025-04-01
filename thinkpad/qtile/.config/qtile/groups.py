from libqtile.config import Group, Key, Match
from libqtile.lazy import lazy
from keys import mod, keys

groups = []
group_names = [f"{i}" for i in "12345"]

#group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9",]

group_labels = [f"{i}" for i in "12345"]
# group_labels[0] = "WWW"
# group_labels[1] = "DEV"
group_labels = ["WWW", "DEV", "SYS", "BETA", "FUCK", "CHAT", "MUS", "VID", "GFX",]
#group_labels = ["", "", "", "", "", "", "", "", "",]

group_layouts = ["max", "max", "max", "max", "max", "monadtall", "monadtall", "monadtall", "monadtall"]

# webMatch = [Match(wm_class=["firefox"])]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
            exclusive=False,
        ))
groups[0] = Group(
        name=group_names[0],
        layout=group_layouts[0],
        label=group_labels[0],
        exclusive=False,
        spawn="firefox",
)

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # mod + shift + group number = move focused window to group
            Key([mod, "control"], i.name, lazy.window.togroup(i.name),
             desc="move focused window to group {}".format(i.name)),
        ]
    )

