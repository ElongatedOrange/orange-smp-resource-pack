# Paintball team armor

Four actual Voxel Forge generations provide the jersey, trousers, boots and hollow open-face helmet. The completed source jobs and original generated specs are retained here. `owned-files.json` lists every exported file and SHA-256 hash.

Technical adaptations preserve the generated texture pixels, UVs and geometry:

- Armor equipment layers are dyeable. The plugin supplies the team's orange `#f58b26` or blue `#379bfa` dye.
- Inventory icons and the helmet use constant team tints. Helmet faces receive tint index 0.
- The helmet's head display scale is 1.8. Minecraft 26.3's native head-item layer scales items by 0.625, giving an effective scale of 1.125: a generated eight-pixel cavity fits the player's nine-pixel skin outer layer. The head item uses no equipment asset or camera overlay.

`adaptations.json` records original model paths and generated parent IDs. Rebuild with `orange-smp-paintball/scripts/build-armor-assets.mjs` from the master project. `review-armor.mjs` renders the generated artwork on a vanilla Steve reference mannequin and tests 195 unobstructed rays through the face opening. Preview mannequin geometry is a QA reference only and is not exported into the pack. In-game animated fit remains a client acceptance check.
