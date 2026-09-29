# Paintball loadout equipment

Four actual Voxel Forge generations provide Scatter, Precision, Lobber and Paint Grenade. `generation-jobs.json` records the completed jobs, and each `.generated.voxelforge.json` is the original generated source. The Java exports retain their generated geometry, artwork, UVs and display transforms. Orange SMP item definitions alias the exported models.

Rebuild with `orange-smp-paintball/scripts/build-loadout-assets.mjs` from the master project. `owned-files.json` records SHA-256 hashes for every installed asset. The matching plugin adds per-loadout firing, capacity and reload behavior, throwable paint grenades, and grenade/ammo HUD readouts using the existing licensed Barlow Condensed font.
