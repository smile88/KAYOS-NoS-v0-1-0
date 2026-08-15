#!/usr/bin/env python3
import json
import os

CHARACTER_DIR = "/Users/admin/Projectss/KAYOS-NoS-v0-1-0/godot/data/characters"
DIALOGUE_DIR = "/Users/admin/Projectss/KAYOS-NoS-v0-1-0/godot/data/dialogue"

# Factions: NOCTARI=0, SOLARI=1, ORC=2, TERRAN=3, HUMAN=4, SYLVARI=5, OTHER=6

CHARACTERS = [
    {
        "filename": "corel.tres",
        "id": "CH-013",
        "display_name": "Corel",
        "faction": 0,
        "portrait": "res://art/placeholders/PO-011_corel.png",
        "sprite": "res://art/placeholders/CH-013_corel.png",
        "default_dialogue": "res://data/dialogue/mq01_corel_briefing.json",
        "notes": "Archmagister of containment, Starfall. Decency worn thin by duty. Signs off on the safeguard he is too tired to fully check."
    },
    {
        "filename": "vara.tres",
        "id": "CH-010",
        "display_name": "Vara",
        "faction": 4,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_human.png",
        "default_dialogue": "res://data/dialogue/mq02_vara_recruitment.json",
        "notes": "Young human prodigy. Twice as good, half as credited. Lodges in a canal garret in House Vael'Suran."
    },
    {
        "filename": "durak.tres",
        "id": "CH-011",
        "display_name": "Durak Ironthought",
        "faction": 3,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_terran.png",
        "default_dialogue": "res://data/dialogue/mq02_durak_recruitment.json",
        "notes": "Terran geomancer with mountain-deep caution. Lodges with the deep-wrights in the Under-Terraces."
    },
    {
        "filename": "coil.tres",
        "id": "CH-009",
        "display_name": "Coil",
        "faction": 0,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_noctari.png",
        "default_dialogue": "res://data/dialogue/mq02_coil_recruitment.json",
        "notes": "Noctari theorist, Elorin's former student. The mind that sees the math before the cost."
    },
    {
        "filename": "sera.tres",
        "id": "CH-008",
        "display_name": "Sera",
        "faction": 1,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_solari.png",
        "default_dialogue": "res://data/dialogue/mq02_sera_recruitment.json",
        "notes": "Solari structural enchantress. The outsider's outsider, living in House Serenthil."
    },
    {
        "filename": "talindir_scribe.tres",
        "id": "CH-006",
        "display_name": "Scribe Talindir",
        "faction": 0,
        "portrait": "res://art/placeholders/PO-005_talindir_chronicler.png",
        "sprite": "res://art/placeholders/CH-007_talindir_night.png",
        "default_dialogue": "res://data/dialogue/sq01_forged_ledger.json",
        "notes": "Young apprentice-scribe in the Vael'Suran scriptorium. Earnest, meticulous, troubled by altered quarry records."
    },
    {
        "filename": "orvath_smith.tres",
        "id": "NPC-SQ-02",
        "display_name": "Master Orvath",
        "faction": 3,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_terran.png",
        "default_dialogue": "res://data/dialogue/sq02_cracked_resonator.json",
        "notes": "Master Bell-Smith of House Serenthil. Tending the Great Meridian Bell under acoustic crisis."
    },
    {
        "filename": "lyris_envoy.tres",
        "id": "NPC-SQ-03",
        "display_name": "Envoy Lyris",
        "faction": 1,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_solari.png",
        "default_dialogue": "res://data/dialogue/sq03_sun_bleached_glass.json",
        "notes": "Diplomatic envoy from Astra'Thalas stationed at the House Oravelle Dawnspire."
    },
    {
        "filename": "sylas_apprentice.tres",
        "id": "NPC-SQ-04",
        "display_name": "Apprentice Sylas",
        "faction": 0,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_noctari.png",
        "default_dialogue": "res://data/dialogue/sq04_severed_shadow.json",
        "notes": "Shadow-weaving apprentice in House Nyx'Talar whose shadow severed during an experimental weave."
    },
    {
        "filename": "borak_miner.tres",
        "id": "NPC-SQ-05",
        "display_name": "Miner Borak",
        "faction": 2,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_orc.png",
        "default_dialogue": "res://data/dialogue/sq05_bedrock_echoes.json",
        "notes": "Veteran orc quarry miner in the deep basalt shafts beneath Starfall."
    },
    {
        "filename": "miriel_lady.tres",
        "id": "NPC-SQ-06",
        "display_name": "Lady Miriel",
        "faction": 0,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_noctari.png",
        "default_dialogue": "res://data/dialogue/sq06_house_divided.json",
        "notes": "Aristocrat of House Corvane caught in bitter inheritance factionalism."
    },
    {
        "filename": "reliquary_keeper.tres",
        "id": "NPC-SQ-07",
        "display_name": "Reliquary Keeper",
        "faction": 0,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_noctari.png",
        "default_dialogue": "res://data/dialogue/sq07_silent_ward.json",
        "notes": "Solemn guardian of the relic vault in the unlit tower of the Dead House."
    },
    {
        "filename": "kael_dockhand.tres",
        "id": "NPC-SQ-08",
        "display_name": "Kael",
        "faction": 4,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_human.png",
        "default_dialogue": "res://data/dialogue/sq08_smugglers_siphon.json",
        "notes": "Canal Quarter dockhand who discovered illegal essence siphons along the water locks."
    },
    {
        "filename": "crafter_elias.tres",
        "id": "NPC-SQ-09",
        "display_name": "Crafter Elias",
        "faction": 4,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_human.png",
        "default_dialogue": "res://data/dialogue/sq09_seven_solstices.json",
        "notes": "Master brass artisan in House Sabreth working on celestial astrolabes."
    },
    {
        "filename": "thrak_foreman.tres",
        "id": "NPC-SQ-10",
        "display_name": "Foreman Thrak",
        "faction": 2,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_orc.png",
        "default_dialogue": "res://data/dialogue/sq10_unspoken_collar.json",
        "notes": "Foundry foreman in the Under-Terraces negotiating hazardous smelting shifts."
    },
    {
        "filename": "morwen_scholar.tres",
        "id": "NPC-SQ-11",
        "display_name": "Scholar Morwen",
        "faction": 0,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_noctari.png",
        "default_dialogue": "res://data/dialogue/sq11_heretics_thesis.json",
        "notes": "Radical theorist in House Ilmyra researching forbidden void resonance."
    },
    {
        "filename": "kendra_warden.tres",
        "id": "NPC-SQ-12",
        "display_name": "Warden Kendra",
        "faction": 0,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_noctari.png",
        "default_dialogue": "res://data/dialogue/sq12_whispering_pylon.json",
        "notes": "Sentinel at House Duskmere's resonant pylon perimeter."
    },
    {
        "filename": "althor_diviner.tres",
        "id": "NPC-SQ-13",
        "display_name": "Diviner Althor",
        "faction": 1,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_solari.png",
        "default_dialogue": "res://data/dialogue/sq13_blind_diviner.json",
        "notes": "Blind stellar diviner situated beside the colossal Armillary of the First Measure."
    },
    {
        "filename": "vael_botanist.tres",
        "id": "NPC-SQ-14",
        "display_name": "Botanist Vael",
        "faction": 5,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_other.png",
        "default_dialogue": "res://data/dialogue/sq14_golden_graft.json",
        "notes": "Sylvari botanist tending the starlight glasshouses and celestial flora grafts."
    },
    {
        "filename": "gavin_bridgewarden.tres",
        "id": "NPC-SQ-15",
        "display_name": "Bridgewarden Gavin",
        "faction": 4,
        "portrait": "res://art/placeholders/PO-014_generic.png",
        "sprite": "res://art/placeholders/NPC_generic_human.png",
        "default_dialogue": "res://data/dialogue/sq15_tide_of_shadows.json",
        "notes": "Veteran guard stationed at the head of the railless causeway across the Mirror."
    }
]

def write_character_tres(c):
    path = os.path.join(CHARACTER_DIR, c["filename"])
    content = f"""[gd_resource type="Resource" script_class="CharacterData" load_steps=4 format=3]

[ext_resource type="Script" path="res://data/characters/character_data.gd" id="1_cd"]
[ext_resource type="Texture2D" path="{c['sprite']}" id="2_sprite"]
[ext_resource type="Texture2D" path="{c['portrait']}" id="3_portrait"]

[resource]
script = ExtResource("1_cd")
id = "{c['id']}"
display_name = "{c['display_name']}"
faction = {c['faction']}
portrait = ExtResource("3_portrait")
sprite = ExtResource("2_sprite")
default_dialogue = "{c['default_dialogue']}"
editor_notes = "{c['notes']}"
"""
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print(f"Wrote {c['filename']}")

for c in CHARACTERS:
    write_character_tres(c)

print("All 20 character .tres files generated.")
