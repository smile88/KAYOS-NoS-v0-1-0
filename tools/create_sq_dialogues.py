#!/usr/bin/env python3
import json
import os

DIALOGUE_DIR = "/Users/admin/Projectss/KAYOS-NoS-v0-1-0/godot/data/dialogue"

DIALOGUES = {
    "sq04_severed_shadow.json": {
        "id": "sq04_severed_shadow",
        "start": "sylas_intro",
        "nodes": {
            "sylas_intro": {
                "speaker": "sylas",
                "portrait": "PO-014",
                "text": "Archmage! Be careful where you cast your lantern! My shadow... it tore loose during the resonance pulse. It's hiding under the cloister arches, and every time the bells chime, it stretches further toward the canal!",
                "start_quest": {
                    "id": "sq04_severed_shadow",
                    "title": "The Severed Shadow",
                    "desc": "Help Apprentice Sylas re-anchor his severed shadow after a botched void-weaving experiment in House Nyx'Talar.",
                    "category": "side",
                    "stages": [
                        "Investigate the rogue shadow tether in the Nyx'Talar Cloister",
                        "Weave a containment ring using inverted Umbral frequencies",
                        "Re-bind the shadow to Sylas"
                    ]
                },
                "choices": [
                    {
                        "text": "[Arcana Check] Hold still. Let me analyze the fraying Umbral tether at the base of your boots.",
                        "check": {"attr": "Arcana", "dc": 7, "uncertain": False},
                        "goto": "sylas_arcana_pass",
                        "goto_fail": "sylas_arcana_fail"
                    },
                    {
                        "text": "What experiment were you performing without Master Vaross's supervision?",
                        "goto": "sylas_explain"
                    },
                    {
                        "text": "Don't move. I will corner it before it reaches the star-water.",
                        "goto": "sylas_action"
                    }
                ]
            },
            "sylas_explain": {
                "speaker": "sylas",
                "portrait": "PO-014",
                "text": "I only wanted to test if a shadow could hold essence without collapsing into void-sludge. But the frequency spike from the Northreach tear inverted the weave!",
                "choices": [
                    {"text": "We need to construct a dampening loop immediately.", "goto": "sylas_action"}
                ]
            },
            "sylas_arcana_pass": {
                "speaker": "sylas",
                "portrait": "PO-014",
                "text": "You see it! The harmonic thread is still vibrating at thirty cycles. If you cast a low resonant D, the shadow should snap back into phase.",
                "choices": [
                    {"text": "[Voidweaver] Strike the fundamental tone and seal the anchor.", "goto": "sylas_resolve"}
                ]
            },
            "sylas_arcana_fail": {
                "speaker": "sylas",
                "portrait": "PO-014",
                "text": "It's too fast—it just darted behind the basalt pillar! We have to pin it down with physical light barriers.",
                "choices": [
                    {"text": "Surround the pillar with star-lamps.", "goto": "sylas_resolve"}
                ]
            },
            "sylas_action": {
                "speaker": "sylas",
                "portrait": "PO-014",
                "text": "It's cornered! Please, Archmage, weave the re-anchoring glyph before my vitality drains completely!",
                "choices": [
                    {"text": "Re-anchor the shadow to Sylas's heels.", "goto": "sylas_resolve"}
                ]
            },
            "sylas_resolve": {
                "speaker": "sylas",
                "portrait": "PO-014",
                "text": "It worked! My shadow is back at my feet... cold, but whole. Thank you, Voidweaver. I will never touch untuned Umbral harmonics again.",
                "set_flags": {"SQ04_SHADOW_RESOLVED": True}
            }
        }
    },
    "sq05_bedrock_echoes.json": {
        "id": "sq05_bedrock_echoes",
        "start": "borak_intro",
        "nodes": {
            "borak_intro": {
                "speaker": "borak",
                "portrait": "PO-014",
                "text": "Put your hand against that basalt rib, scholar. Feel that? That's not the mining picks. That's a pulse coming from two hundred paces below the lake bed. Deep rock shouldn't hum.",
                "start_quest": {
                    "id": "sq05_bedrock_echoes",
                    "title": "Bedrock Echoes",
                    "desc": "Investigate seismic acoustic anomalies in the deepest quarry shafts beneath Starfall.",
                    "category": "side",
                    "stages": [
                        "Speak with Miner Borak in the Under-Terraces basalt shafts",
                        "Locate the acoustic anomaly vibrating through the bedrock",
                        "Stabilize the seismic shear plane"
                    ]
                },
                "choices": [
                    {
                        "text": "[Acumen Check] That rhythm matches the containment pulse from the central island, refracted through fault line four.",
                        "check": {"attr": "Acumen", "dc": 7, "uncertain": False},
                        "goto": "borak_acumen_pass",
                        "goto_fail": "borak_acumen_fail"
                    },
                    {
                        "text": "[Resilience Check] Let me descend into the lower pit and inspect the fissure myself.",
                        "check": {"attr": "Resilience", "dc": 7, "uncertain": False},
                        "goto": "borak_resilience_pass",
                        "goto_fail": "borak_explain"
                    },
                    {
                        "text": "How long has the rock been singing like this?",
                        "goto": "borak_explain"
                    }
                ]
            },
            "borak_explain": {
                "speaker": "borak",
                "portrait": "PO-014",
                "text": "Three days now. Ever since the Archmages started spinning up the test apparatus. The elven towers up top don't feel it, but down here, we're the ones under the anvil.",
                "choices": [
                    {"text": "We need to install geomantic shunts to disperse the load.", "goto": "borak_resolve"}
                ]
            },
            "borak_acumen_pass": {
                "speaker": "borak",
                "portrait": "PO-014",
                "text": "Refracted resonance? Ha! So your big machine is shaking our bedrock like a dried gourd. At least now we know which struts need shoring up.",
                "choices": [
                    {"text": "Mark the fault nodes and drive reinforcing wedges.", "goto": "borak_resolve"}
                ]
            },
            "borak_acumen_fail": {
                "speaker": "borak",
                "portrait": "PO-014",
                "text": "Whatever fancy words you call it, if that seam splits, half of Terrace Four drops into the lower mines.",
                "choices": [
                    {"text": "Let's brace the primary archway immediately.", "goto": "borak_resolve"}
                ]
            },
            "borak_resilience_pass": {
                "speaker": "borak",
                "portrait": "PO-014",
                "text": "You've got steady footing for a robed scholar. Most of your high-terrace peers get dizzy past the first ladder. Look down there—the crack is weeping star-slike.",
                "choices": [
                    {"text": "Seal the weeping crack with geomantic cement.", "goto": "borak_resolve"}
                ]
            },
            "borak_resolve": {
                "speaker": "borak",
                "portrait": "PO-014",
                "text": "The hum is dampening out. Good work, Elorin. The deep-wrights won't forget that you came down into the dirt to fix what your towers caused.",
                "set_flags": {"SQ05_BEDROCK_RESOLVED": True}
            }
        }
    },
    "sq06_house_divided.json": {
        "id": "sq06_house_divided",
        "start": "miriel_intro",
        "nodes": {
            "miriel_intro": {
                "speaker": "miriel",
                "portrait": "PO-014",
                "text": "Voidweaver. You arrive at a delicate juncture. House Corvane's succession charter has been stolen from our private gallery, and my cousin Valen intends to present a forged codicil to the Conclave before the midnight watch.",
                "start_quest": {
                    "id": "sq06_house_divided",
                    "title": "A House Divided",
                    "desc": "Navigate an inheritance dispute and covert saboteur plot within House Corvane's high manse.",
                    "category": "side",
                    "stages": [
                        "Confer with Lady Miriel in the Corvane Upper Manse",
                        "Examine the altered succession seal",
                        "Expose the usurper's conspiracy"
                    ]
                },
                "choices": [
                    {
                        "text": "[Magnetism Check] Lady Miriel, if we bring this before the Conclave without ironclad proof, the other Houses will use it to divide Corvane's voting bloc.",
                        "check": {"attr": "Magnetism", "dc": 7, "uncertain": False},
                        "goto": "miriel_magnetism_pass",
                        "goto_fail": "miriel_magnetism_fail"
                    },
                    {
                        "text": "[Acumen Check] Let me examine the wax seal on the registry copy. True Corvane wax contains crushed starlight quartz.",
                        "check": {"attr": "Acumen", "dc": 7, "uncertain": False},
                        "goto": "miriel_acumen_pass",
                        "goto_fail": "miriel_explain"
                    },
                    {
                        "text": "What does Valen hope to gain by forcing a succession crisis now?",
                        "goto": "miriel_explain"
                    }
                ]
            },
            "miriel_explain": {
                "speaker": "miriel",
                "portrait": "PO-014",
                "text": "Control of our rim observatory! He wants to redirect our stellar lenses toward the void border, defying the Common Sky covenant.",
                "choices": [
                    {"text": "Then we must recover the true charter before the vote.", "goto": "miriel_resolve"}
                ]
            },
            "miriel_magnetism_pass": {
                "speaker": "miriel",
                "portrait": "PO-014",
                "text": "You speak with the wisdom of a diplomat, Elorin. If we confront Valen privately with the Archmagister's backing, he will have no choice but to yield.",
                "choices": [
                    {"text": "Let us present the evidence to Valen in closed chambers.", "goto": "miriel_resolve"}
                ]
            },
            "miriel_magnetism_fail": {
                "speaker": "miriel",
                "portrait": "PO-014",
                "text": "I care nothing for Conclave politics! My grandfather's legacy is being rewritten by a traitor in our own bloodline!",
                "choices": [
                    {"text": "Then let us find the document before he can present it.", "goto": "miriel_resolve"}
                ]
            },
            "miriel_acumen_pass": {
                "speaker": "miriel",
                "portrait": "PO-014",
                "text": "Brilliant! The seal on his document is common resin tinted with copper shavings. Under a lantern, the fraud is undeniable.",
                "choices": [
                    {"text": "Expose the fraudulent seal to the house elders.", "goto": "miriel_resolve"}
                ]
            },
            "miriel_resolve": {
                "speaker": "miriel",
                "portrait": "PO-014",
                "text": "Valen has withdrawn his claim in disgrace. House Corvane stands united, and our observatory remains dedicated to the safeguard. Take this signet as our gratitude.",
                "set_flags": {"SQ06_CORVANE_RESOLVED": True}
            }
        }
    },
    "sq07_silent_ward.json": {
        "id": "sq07_silent_ward",
        "start": "reliquary_intro",
        "nodes": {
            "reliquary_intro": {
                "speaker": "reliquary_keeper",
                "portrait": "PO-014",
                "text": "Few come to the Dead Tower, Voidweaver. Those who remember why it went dark prefer to look away. But the ward in the inner sanctum is bleeding silence—not metaphorically, but as physical decay in the stonework.",
                "start_quest": {
                    "id": "sq07_silent_ward",
                    "title": "The Silent Ward",
                    "desc": "Inspect a decaying containment ward within the Dead House's unlit tower reliquary.",
                    "category": "side",
                    "stages": [
                        "Enter the Dead House tower reliquary",
                        "Diagnose the unlit ward's planar decay",
                        "Re-align the obsidian dampening matrix"
                    ]
                },
                "choices": [
                    {
                        "text": "[Arcana Check] This ward is not Noctari or Solari. It is a pre-caldera harmonic seal that predates the Nine Houses.",
                        "check": {"attr": "Arcana", "dc": 8, "uncertain": False},
                        "goto": "reliquary_arcana_pass",
                        "goto_fail": "reliquary_arcana_fail"
                    },
                    {
                        "text": "What is kept inside this vault that requires an unlit tower to contain?",
                        "goto": "reliquary_explain"
                    },
                    {
                        "text": "Let me examine the obsidian dampening ring around the pedestal.",
                        "goto": "reliquary_action"
                    }
                ]
            },
            "reliquary_explain": {
                "speaker": "reliquary_keeper",
                "portrait": "PO-014",
                "text": "A memory of the First Silence. A shard of the void that didn't dissolve when the Song was woven. If the ward gives out, every bell in Starfall will crack.",
                "choices": [
                    {"text": "We cannot let that happen. Let us re-tune the matrix.", "goto": "reliquary_action"}
                ]
            },
            "reliquary_arcana_pass": {
                "speaker": "reliquary_keeper",
                "portrait": "PO-014",
                "text": "You perceive the ancient geometry... yes. It requires an inverted cadence to feed on void pressure instead of resisting it.",
                "choices": [
                    {"text": "[Voidweaver] Invert the flow direction of the boundary runes.", "goto": "reliquary_resolve"}
                ]
            },
            "reliquary_arcana_fail": {
                "speaker": "reliquary_keeper",
                "portrait": "PO-014",
                "text": "Be careful! Touching that glyph with raw magic will only accelerate the entropy!",
                "choices": [
                    {"text": "Dampen the resonance manually using cold iron rods.", "goto": "reliquary_resolve"}
                ]
            },
            "reliquary_action": {
                "speaker": "reliquary_keeper",
                "portrait": "PO-014",
                "text": "The obsidian rings are spinning out of alignment. Stabilize the central node while I chant the sealing mantra.",
                "choices": [
                    {"text": "Channel steady void-weave through the focus stone.", "goto": "reliquary_resolve"}
                ]
            },
            "reliquary_resolve": {
                "speaker": "reliquary_keeper",
                "portrait": "PO-014",
                "text": "The vibration has settled into stillness. The Dead House will remain silent for another age. May your own safeguard hold as well as this ancient stone.",
                "set_flags": {"SQ07_RELIQUARY_RESOLVED": True}
            }
        }
    },
    "sq08_smugglers_siphon.json": {
        "id": "sq08_smugglers_siphon",
        "start": "kael_intro",
        "nodes": {
            "kael_intro": {
                "speaker": "kael",
                "portrait": "PO-014",
                "text": "Psst! Mistress Elorin! Over here behind the cargo barrels. You know how the water level in Canal Three has been dropping two inches every night? It's not evaporation. Someone's tapped a siphon into the main conduit under Lock Seven.",
                "start_quest": {
                    "id": "sq08_smugglers_siphon",
                    "title": "The Smuggler's Siphon",
                    "desc": "Track down an illegal star-water siphon draining celestial essence from the Canal Quarter locks.",
                    "category": "side",
                    "stages": [
                        "Meet Dockhand Kael at the lower canal sluice",
                        "Trace the hidden siphon conduits beneath the docks",
                        "Decide the fate of the black-market essence ring"
                    ]
                },
                "choices": [
                    {
                        "text": "[Acumen Check] Star-water contains refined celestial essence. Someone is distilling it for black-market alchemy in the Under-Terraces.",
                        "check": {"attr": "Acumen", "dc": 6, "uncertain": False},
                        "goto": "kael_acumen_pass",
                        "goto_fail": "kael_explain"
                    },
                    {
                        "text": "Who runs the barges through Lock Seven at night, Kael?",
                        "goto": "kael_explain"
                    },
                    {
                        "text": "Show me where the siphon attaches to the lock mechanism.",
                        "goto": "kael_action"
                    }
                ]
            },
            "kael_explain": {
                "speaker": "kael",
                "portrait": "PO-014",
                "text": "It's the Silver Current syndicate. They bottle the concentrate and sell it to uncredited scholars who can't get Academy lab permits.",
                "choices": [
                    {"text": "Lead me to their tapping point.", "goto": "kael_action"}
                ]
            },
            "kael_acumen_pass": {
                "speaker": "kael",
                "portrait": "PO-014",
                "text": "Spot on. They've rigged brass pipes directly into the sluice valve. If the water pressure drops too low, the hydraulic lift for the hospital barges will stall.",
                "choices": [
                    {"text": "We must disconnect the siphon and secure the valve.", "goto": "kael_resolve"}
                ]
            },
            "kael_action": {
                "speaker": "kael",
                "portrait": "PO-014",
                "text": "There! See that flexible lead tubing running under the wharf? They've got three casks filling right now.",
                "choices": [
                    {"text": "Sever the siphon line and seal the lock breach.", "goto": "kael_resolve"}
                ]
            },
            "kael_resolve": {
                "speaker": "kael",
                "portrait": "PO-014",
                "text": "Valve sealed and lines confiscated! The lock water is already rising back to full mark. The canal folk will breathe a lot easier tonight, Mistress.",
                "set_flags": {"SQ08_SIPHON_RESOLVED": True}
            }
        }
    },
    "sq09_seven_solstices.json": {
        "id": "sq09_seven_solstices",
        "start": "elias_intro",
        "nodes": {
            "elias_intro": {
                "speaker": "elias",
                "portrait": "PO-014",
                "text": "Seven generations of my family have worked on this grand astrolabe for House Sabreth. Four hundred moving gears of silver-bronze, all tracking the celestial dance. But the seventh solstice dial is off by three arc-seconds, and the Conclave inspection is tomorrow!",
                "start_quest": {
                    "id": "sq09_seven_solstices",
                    "title": "Seven Solstices",
                    "desc": "Assist Crafter Elias in calibrating a delicate multi-generational astrolabe for House Sabreth.",
                    "category": "side",
                    "stages": [
                        "Inspect the master astrolabe in the Sabreth brass workshop",
                        "Align the seven solstice gear trains",
                        "Correct the orbital deviation"
                    ]
                },
                "choices": [
                    {
                        "text": "[Acumen Check] The error isn't in your gears, Elias. It's the gravitational precession caused by the caldera's volcanic magma chambers.",
                        "check": {"attr": "Acumen", "dc": 7, "uncertain": False},
                        "goto": "elias_acumen_pass",
                        "goto_fail": "elias_acumen_fail"
                    },
                    {
                        "text": "[Celerity Check] Let me adjust the micro-escapement teeth with precision jeweller's tweezers.",
                        "check": {"attr": "Celerity", "dc": 7, "uncertain": False},
                        "goto": "elias_celerity_pass",
                        "goto_fail": "elias_explain"
                    },
                    {
                        "text": "Show me the differential gear train connecting the lunar and solar arms.",
                        "goto": "elias_explain"
                    }
                ]
            },
            "elias_explain": {
                "speaker": "elias",
                "portrait": "PO-014",
                "text": "Look at the main escapement arbor. Every time the winter solstice arm sweeps across the Great Bear constellation, the tension slips.",
                "choices": [
                    {"text": "We need to re-cut the counter-weight tension curve.", "goto": "elias_resolve"}
                ]
            },
            "elias_acumen_pass": {
                "speaker": "elias",
                "portrait": "PO-014",
                "text": "Volcanic precession! By the stars, of course! My grandfather calculated this for sea-level gravity, not the caldera rim!",
                "choices": [
                    {"text": "Apply the elevation correction constant to the gear ratios.", "goto": "elias_resolve"}
                ]
            },
            "elias_acumen_fail": {
                "speaker": "elias",
                "portrait": "PO-014",
                "text": "I've checked every tooth twice. If I can't find the deviation, Sabreth will strip our workshop charter.",
                "choices": [
                    {"text": "Let's calibrate the gears against tonight's actual star positions.", "goto": "elias_resolve"}
                ]
            },
            "elias_celerity_pass": {
                "speaker": "elias",
                "portrait": "PO-014",
                "text": "Incredible hand precision! You slipped the balance spring without scratching the enamel dial even once.",
                "choices": [
                    {"text": "Lock the set screw and test the sweep.", "goto": "elias_resolve"}
                ]
            },
            "elias_resolve": {
                "speaker": "elias",
                "portrait": "PO-014",
                "text": "Hear that clean, rhythmic ticking? Exactly on the second! House Sabreth will have the most accurate star-measure in the caldera. I am forever in your debt.",
                "set_flags": {"SQ09_ASTROLABE_RESOLVED": True}
            }
        }
    },
    "sq10_unspoken_collar.json": {
        "id": "sq10_unspoken_collar",
        "start": "thrak_intro",
        "nodes": {
            "thrak_intro": {
                "speaker": "thrak",
                "portrait": "PO-014",
                "text": "Step back from the crucible edge, Voidweaver. Three cooling manifolds blew out an hour ago. The molten slag is pooling near the drainage sluice, and the High Arches overseer ordered my crew to keep shovelling under threat of the collar.",
                "start_quest": {
                    "id": "sq10_unspoken_collar",
                    "title": "The Unspoken Collar",
                    "desc": "Address a hazardous slag overflow and labor safety strike in the Under-Terraces foundries.",
                    "category": "side",
                    "stages": [
                        "Meet Foreman Thrak at the deep foundry gates",
                        "Survey the compromised cooling conduits",
                        "Broker safety terms between the smiths and the High Arches"
                    ]
                },
                "choices": [
                    {
                        "text": "[Vigor Check] Give me that quench lever. I'll drop the emergency floodgate myself before the slag breaches.",
                        "check": {"attr": "Vigor", "dc": 7, "uncertain": False},
                        "goto": "thrak_vigor_pass",
                        "goto_fail": "thrak_vigor_fail"
                    },
                    {
                        "text": "[Magnetism Check] Foreman Thrak, stand your men down. As an Archmage of the Academy, I will countermand the overseer's order.",
                        "check": {"attr": "Magnetism", "dc": 7, "uncertain": False},
                        "goto": "thrak_magnetism_pass",
                        "goto_fail": "thrak_explain"
                    },
                    {
                        "text": "How many laborers are trapped in the lower casting floor?",
                        "goto": "thrak_explain"
                    }
                ]
            },
            "thrak_explain": {
                "speaker": "thrak",
                "portrait": "PO-014",
                "text": "Nine orc apprentices and twelve Terran stone-cutters. The heat is unbearable down there, and the air is thick with sulfur fumes.",
                "choices": [
                    {"text": "We clear the lower floor first, then vent the crucible.", "goto": "thrak_resolve"}
                ]
            },
            "thrak_vigor_pass": {
                "speaker": "thrak",
                "portrait": "PO-014",
                "text": "Ha! You hauled that iron gate down against two tons of slag pressure! The lower foundry is safe!",
                "choices": [
                    {"text": "Now let us fix the cooling manifolds properly.", "goto": "thrak_resolve"}
                ]
            },
            "thrak_vigor_fail": {
                "speaker": "thrak",
                "portrait": "PO-014",
                "text": "The lever is seized! Grab the secondary chains with me—heave!",
                "choices": [
                    {"text": "Pull together and lock the barrier.", "goto": "thrak_resolve"}
                ]
            },
            "thrak_magnetism_pass": {
                "speaker": "thrak",
                "portrait": "PO-014",
                "text": "An elf standing between an overseer and an orc labor crew? Never thought I'd see the day. The men will listen to you.",
                "choices": [
                    {"text": "Order the crew to safety while we vent the excess steam.", "goto": "thrak_resolve"}
                ]
            },
            "thrak_resolve": {
                "speaker": "thrak",
                "portrait": "PO-014",
                "text": "Crucible stabilized and no blood spilled. You've earned the respect of the foundry floor, Elorin. When you need heavy iron for your Nullstone project, you come to Thrak.",
                "set_flags": {"SQ10_FOUNDRY_RESOLVED": True}
            }
        }
    },
    "sq11_heretics_thesis.json": {
        "id": "sq11_heretics_thesis",
        "start": "morwen_intro",
        "nodes": {
            "morwen_intro": {
                "speaker": "morwen",
                "portrait": "PO-014",
                "text": "Close the stack door, Elorin. If the Ilmyra inquisitors see this folio, they won't just burn the parchment—they will unbind my academic credentials. I have found the lost mathematical proofs of Archmage Varis.",
                "start_quest": {
                    "id": "sq11_heretics_thesis",
                    "title": "The Heretic's Thesis",
                    "desc": "Recover and evaluate a banned theoretical treatise on void resonance hidden in House Ilmyra.",
                    "category": "side",
                    "stages": [
                        "Confront Scholar Morwen in the Ilmyra restricted stacks",
                        "Decipher the coded void-acoustic theorem",
                        "Choose whether to preserve or suppress the manuscript"
                    ]
                },
                "choices": [
                    {
                        "text": "[Acumen Check] Varis proved that the void is not empty space—it is an unvibrated medium with its own harmonic tension.",
                        "check": {"attr": "Acumen", "dc": 8, "uncertain": False},
                        "goto": "morwen_acumen_pass",
                        "goto_fail": "morwen_acumen_fail"
                    },
                    {
                        "text": "Why was Varis cast out by the Conclave eight centuries ago?",
                        "goto": "morwen_explain"
                    },
                    {
                        "text": "This research is dangerously close to what we are attempting with the Nullstone.",
                        "goto": "morwen_debate"
                    }
                ]
            },
            "morwen_explain": {
                "speaker": "morwen",
                "portrait": "PO-014",
                "text": "Because he argued that the Elder Song could be silenced! The Solari called it blasphemy. But looking at the Northreach reports, he wasn't predicting catastrophe—he was warning us!",
                "choices": [
                    {"text": "Let me examine the equations for void containment.", "goto": "morwen_acumen_pass"}
                ]
            },
            "morwen_debate": {
                "speaker": "morwen",
                "portrait": "PO-014",
                "text": "Exactly! If your containment team works from flawed assumptions about void behavior, your prototype will fail under load.",
                "choices": [
                    {"text": "Then we must preserve these folios in secret.", "goto": "morwen_resolve"}
                ]
            },
            "morwen_acumen_pass": {
                "speaker": "morwen",
                "portrait": "PO-014",
                "text": "You understand! Look at theorem seven—the decay rate resolves as a logarithmic spiral rather than a linear drop. This changes everything.",
                "choices": [
                    {"text": "Integrate Varis's spiral decay theorem into the Nullstone calculations.", "goto": "morwen_resolve"}
                ]
            },
            "morwen_acumen_fail": {
                "speaker": "morwen",
                "portrait": "PO-014",
                "text": "The cipher is dense, but the core geometry is clear. We cannot allow House Ilmyra to erase this knowledge.",
                "choices": [
                    {"text": "Smuggle the copy to the Academy Theory Wings.", "goto": "morwen_resolve"}
                ]
            },
            "morwen_resolve": {
                "speaker": "morwen",
                "portrait": "PO-014",
                "text": "The manuscript is transcribed and safe. Whatever happens to me, the truth of the void's geometry survives in your hands, Elorin.",
                "set_flags": {"SQ11_THESIS_RESOLVED": True}
            }
        }
    },
    "sq12_whispering_pylon.json": {
        "id": "sq12_whispering_pylon",
        "start": "kendra_intro",
        "nodes": {
            "kendra_intro": {
                "speaker": "kendra",
                "portrait": "PO-014",
                "text": "Warden Kendra, House Duskmere perimeter guard. Stand clear of Pylon Twelve. For the last six hours, it hasn't been relaying the city's broadcast tone—it's been whispering names in a dead dialect.",
                "start_quest": {
                    "id": "sq12_whispering_pylon",
                    "title": "The Whispering Pylon",
                    "desc": "Investigate strange auditory emissions radiating from House Duskmere's rim pylon ring.",
                    "category": "side",
                    "stages": [
                        "Report to Warden Kendra at the Duskmere perimeter",
                        "Attune to the pylon's dissonant psychic pulse",
                        "Discharge the accumulated planar static"
                    ]
                },
                "choices": [
                    {
                        "text": "[Arcana Check] That's not speech—it's harmonic cavitation from the cloud-sea planar boundary catching in the crystal matrix.",
                        "check": {"attr": "Arcana", "dc": 7, "uncertain": False},
                        "goto": "kendra_arcana_pass",
                        "goto_fail": "kendra_arcana_fail"
                    },
                    {
                        "text": "[Resilience Check] Let me touch the pylon base and ground the accumulating electrostatic charge.",
                        "check": {"attr": "Resilience", "dc": 7, "uncertain": False},
                        "goto": "kendra_resilience_pass",
                        "goto_fail": "kendra_explain"
                    },
                    {
                        "text": "What names is it whispering, Warden?",
                        "goto": "kendra_explain"
                    }
                ]
            },
            "kendra_explain": {
                "speaker": "kendra",
                "portrait": "PO-014",
                "text": "The names of the outposts lost beyond the cloud-veil. It's frightening the night watchmen, and two initiates refused their posts.",
                "choices": [
                    {"text": "We need to bleed the resonant static before the crystal cracks.", "goto": "kendra_action"}
                ]
            },
            "kendra_arcana_pass": {
                "speaker": "kendra",
                "portrait": "PO-014",
                "text": "Cavitation? So the external cloud pressure is forcing an inverted harmonic into the pylon. How do we tune it out?",
                "choices": [
                    {"text": "Adjust the ground resonance prongs to phase-cancel the feedback.", "goto": "kendra_resolve"}
                ]
            },
            "kendra_arcana_fail": {
                "speaker": "kendra",
                "portrait": "PO-014",
                "text": "The whispers are getting louder! The obsidian cap is starting to hum with purple corona discharge!",
                "choices": [
                    {"text": "Ground the pylon with a copper tether immediately.", "goto": "kendra_resolve"}
                ]
            },
            "kendra_resilience_pass": {
                "speaker": "kendra",
                "portrait": "PO-014",
                "text": "You absorbed that entire discharge without flinching! The purple corona has faded to soft blue.",
                "choices": [
                    {"text": "Re-lock the grounding clamps.", "goto": "kendra_resolve"}
                ]
            },
            "kendra_action": {
                "speaker": "kendra",
                "portrait": "PO-014",
                "text": "Hand me the tuning fork. Strike the base on three while I ground the collar.",
                "choices": [
                    {"text": "Strike the harmonic tuning node.", "goto": "kendra_resolve"}
                ]
            },
            "kendra_resolve": {
                "speaker": "kendra",
                "portrait": "PO-014",
                "text": "Silence at last. Just the steady, calm hum of the standard city broadcast. The watchmen can return to their stations. Thank you, Voidweaver.",
                "set_flags": {"SQ12_PYLON_RESOLVED": True}
            }
        }
    },
    "sq13_blind_diviner.json": {
        "id": "sq13_blind_diviner",
        "start": "althor_intro",
        "nodes": {
            "althor_intro": {
                "speaker": "althor",
                "portrait": "PO-014",
                "text": "I do not need eyes to know who stands before me, Elorin. The rings of the Armillary behind me sing of your footsteps—and the great quiet you carry in your wake. The stars have begun their descent.",
                "start_quest": {
                    "id": "sq13_blind_diviner",
                    "title": "The Blind Diviner",
                    "desc": "Interpret an apocalyptic celestial alignment foreseen by Diviner Althor at the Armillary monument.",
                    "category": "side",
                    "stages": [
                        "Listen to Diviner Althor's reading at the Armillary",
                        "Cross-reference the stellar alignment with historical star-charts",
                        "Formulate a response to the omens of the Silence"
                    ]
                },
                "choices": [
                    {
                        "text": "[Acumen Check] You speak of the Grand Conjunction of the Twin Suns. The orbital precession matches once every two thousand years.",
                        "check": {"attr": "Acumen", "dc": 7, "uncertain": False},
                        "goto": "althor_acumen_pass",
                        "goto_fail": "althor_acumen_fail"
                    },
                    {
                        "text": "[Magnetism Check] Diviner Althor, if you speak of catastrophe so openly in the public plaza, you will incite mass panic.",
                        "check": {"attr": "Magnetism", "dc": 7, "uncertain": False},
                        "goto": "althor_magnetism_pass",
                        "goto_fail": "althor_explain"
                    },
                    {
                        "text": "What do the rings tell you about our safeguard, Althor?",
                        "goto": "althor_explain"
                    }
                ]
            },
            "althor_explain": {
                "speaker": "althor",
                "portrait": "PO-014",
                "text": "They tell me that you build a cage for something that has no edges. You seek to save the light by giving the darkness a home. It is noble, and it will cost everything you cherish.",
                "choices": [
                    {"text": "A cost I am prepared to bear if the city endures.", "goto": "althor_resolve"}
                ]
            },
            "althor_acumen_pass": {
                "speaker": "althor",
                "portrait": "PO-014",
                "text": "You calculate what I perceive through touch and resonance. When the second sun passes behind the shadow-moon at the solstice, the music of Astra'Thalas will pause. That pause is what you must bridge.",
                "choices": [
                    {"text": "The Nullstone will hold the chord through the pause.", "goto": "althor_resolve"}
                ]
            },
            "althor_acumen_fail": {
                "speaker": "althor",
                "portrait": "PO-014",
                "text": "Do not dismiss the vision as astronomical arithmetic. The sky is alive, Elorin, and tonight it is holding its breath.",
                "choices": [
                    {"text": "I will heed your warning, Diviner.", "goto": "althor_resolve"}
                ]
            },
            "althor_magnetism_pass": {
                "speaker": "althor",
                "portrait": "PO-014",
                "text": "The people only hear the brass rings turning. They believe the sound is eternal. Perhaps it is kindness to let them celebrate one last solstice in peace.",
                "choices": [
                    {"text": "Let us keep the vigil between ourselves.", "goto": "althor_resolve"}
                ]
            },
            "althor_resolve": {
                "speaker": "althor",
                "portrait": "PO-014",
                "text": "Go then, Architect of the Void. Build your stone. The heavens turn, and when the silence falls, may your foundation hold.",
                "set_flags": {"SQ13_DIVINER_RESOLVED": True}
            }
        }
    },
    "sq14_golden_graft.json": {
        "id": "sq14_golden_graft",
        "start": "vael_intro",
        "nodes": {
            "vael_intro": {
                "speaker": "vael",
                "portrait": "PO-014",
                "text": "Archmage! Please, look at the Solari Sun-Vine in conservatory bed four! The graft with our native starlight briar took beautifully for three seasons, but since the morning watch, the golden blossoms are turning black and brittle.",
                "start_quest": {
                    "id": "sq14_golden_graft",
                    "title": "The Golden Graft",
                    "desc": "Heal a dying celestial flora hybrid in the starlight glasshouses.",
                    "category": "side",
                    "stages": [
                        "Examine the withered Solari sun-vine in the botanical terrace",
                        "Identify the necrotic blight affecting the starlight rootstock",
                        "Synthesize a nutrient infusion using star-water"
                    ]
                },
                "choices": [
                    {
                        "text": "[Acumen Check] The graft isn't sick with blight—it's essence starvation. The soil conduits are clogged with calcified mineral deposits from the upper aqueduct.",
                        "check": {"attr": "Acumen", "dc": 6, "uncertain": False},
                        "goto": "vael_acumen_pass",
                        "goto_fail": "vael_acumen_fail"
                    },
                    {
                        "text": "[Arcana Check] Let me weave an invigorating light-stream through the xylem vascular bundle.",
                        "check": {"attr": "Arcana", "dc": 7, "uncertain": False},
                        "goto": "vael_arcana_pass",
                        "goto_fail": "vael_explain"
                    },
                    {
                        "text": "What nutrients have you been feeding the hybrid rootstock?",
                        "goto": "vael_explain"
                    }
                ]
            },
            "vael_explain": {
                "speaker": "vael",
                "portrait": "PO-014",
                "text": "Standard star-water mixed with crushed amber moss. But ever since the harmonic tremor, the roots have refused to drink.",
                "choices": [
                    {"text": "We need to clear the root channels and restore harmonic flow.", "goto": "vael_action"}
                ]
            },
            "vael_acumen_pass": {
                "speaker": "vael",
                "portrait": "PO-014",
                "text": "Mineral clogging! Of course! The Terran masonry work upstream kicked calcium flakes into the feeder lines. Let us flush the irrigation tubes immediately.",
                "choices": [
                    {"text": "Flush the conduits with purified star-water.", "goto": "vael_resolve"}
                ]
            },
            "vael_acumen_fail": {
                "speaker": "vael",
                "portrait": "PO-014",
                "text": "The leaves are wilting faster. If the main stem snaps, two decades of hybrid cultivation will be lost.",
                "choices": [
                    {"text": "Prune the damaged runners and brace the central stalk.", "goto": "vael_resolve"}
                ]
            },
            "vael_arcana_pass": {
                "speaker": "vael",
                "portrait": "PO-014",
                "text": "The golden glow is returning to the veins! The petals are unfurling again, drinking in the light.",
                "choices": [
                    {"text": "Stabilize the harmonic frequency at fifty-four hertz.", "goto": "vael_resolve"}
                ]
            },
            "vael_action": {
                "speaker": "vael",
                "portrait": "PO-014",
                "text": "Help me aerate the soil while you channel warmth into the root collar.",
                "choices": [
                    {"text": "Channel steady warmth into the soil bed.", "goto": "vael_resolve"}
                ]
            },
            "vael_resolve": {
                "speaker": "vael",
                "portrait": "PO-014",
                "text": "Look! A fresh golden shoot is already budding at the crown. You saved the hybrid, Archmage. Sylvari gardens throughout the terrace will flourish tonight.",
                "set_flags": {"SQ14_BOTANY_RESOLVED": True}
            }
        }
    },
    "sq15_tide_of_shadows.json": {
        "id": "sq15_tide_of_shadows",
        "start": "gavin_intro",
        "nodes": {
            "gavin_intro": {
                "speaker": "gavin",
                "portrait": "PO-014",
                "text": "Halt, Archmage! Watch your footing near the causeway threshold! The Mirror isn't resting calm tonight. Black swell waves are lapping over the stone pavers, and the star-reflections below look like they're sinking into an abyss.",
                "start_quest": {
                    "id": "sq15_tide_of_shadows",
                    "title": "Tide of Shadows",
                    "desc": "Investigate anomalous wave surges and void-shadows rising from the depths of the Mirror lake.",
                    "category": "side",
                    "stages": [
                        "Confer with Bridgewarden Gavin at the causeway gate",
                        "Monitor the dark tides surging against the stone piers",
                        "Enact an emergency tethering ritual to secure the crossing"
                    ]
                },
                "choices": [
                    {
                        "text": "[Arcana Check] That's not water movement—it is gravitational tide distortion caused by the containment rig's spin-up cycle on the island.",
                        "check": {"attr": "Arcana", "dc": 7, "uncertain": False},
                        "goto": "gavin_arcana_pass",
                        "goto_fail": "gavin_arcana_fail"
                    },
                    {
                        "text": "[Resilience Check] Step behind me, Bridgewarden. I can anchor the causeway threshold with a starlight tether.",
                        "check": {"attr": "Resilience", "dc": 7, "uncertain": False},
                        "goto": "gavin_resilience_pass",
                        "goto_fail": "gavin_explain"
                    },
                    {
                        "text": "Has anyone attempted to cross the causeway during the surge?",
                        "goto": "gavin_explain"
                    }
                ]
            },
            "gavin_explain": {
                "speaker": "gavin",
                "portrait": "PO-014",
                "text": "A courier tried an hour ago. He said the middle of the bridge felt like walking on grease over an endless sky. Had to crawl back on hands and knees.",
                "choices": [
                    {"text": "We need to re-anchor the ward stones along the pier foundation.", "goto": "gavin_action"}
                ]
            },
            "gavin_arcana_pass": {
                "speaker": "gavin",
                "portrait": "PO-014",
                "text": "Gravitational distortion? So the lake is literally warping space around the stone road! What do we do to keep travellers from falling through?",
                "choices": [
                    {"text": "[Voidweaver] Invert the anchor runes on the shore pylons to counteract the pull.", "goto": "gavin_resolve"}
                ]
            },
            "gavin_arcana_fail": {
                "speaker": "gavin",
                "portrait": "PO-014",
                "text": "Another wave just hit the second pier! The spray is dissolving into cold black mist!",
                "choices": [
                    {"text": "Plant the grounding staff and brace the barrier.", "goto": "gavin_resolve"}
                ]
            },
            "gavin_resilience_pass": {
                "speaker": "gavin",
                "portrait": "PO-014",
                "text": "By the gods, you held that surge back with pure will! The black water broke against your ward like glass on granite.",
                "choices": [
                    {"text": "Lock the boundary anchor into the bedrock.", "goto": "gavin_resolve"}
                ]
            },
            "gavin_action": {
                "speaker": "gavin",
                "portrait": "PO-014",
                "text": "The shore ward stones are glowing red-hot. Pour cold starlight into the left pylon while I secure the chain!",
                "choices": [
                    {"text": "Channel starlight into the pylon array.", "goto": "gavin_resolve"}
                ]
            },
            "gavin_resolve": {
                "speaker": "gavin",
                "portrait": "PO-014",
                "text": "The waves have smoothed out to glass. The star-reflections are clear and calm once more. The causeway is open for the scholars. Thank you, Voidweaver.",
                "set_flags": {"SQ15_CAUSEWAY_RESOLVED": True}
            }
        }
    }
}

for fname, data in DIALOGUES.items():
    p = os.path.join(DIALOGUE_DIR, fname)
    with open(p, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2)
    print(f"Wrote {fname}")

print("All SQ04-SQ15 dialogue files written successfully.")
