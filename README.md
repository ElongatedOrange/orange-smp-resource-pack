# Orange SMP Resource Pack



Minecraft Java 26.3 resource pack, maintained by Elongated_Orange.

## Cubic pumpkin carving (v0.24.0)

Adds a Voxel Forge generated solid pumpkin cube for carving. The Halloween plugin displays it at 2×2×2 blocks, with an 8×8×8 grid of removable quarter-block cells. Existing saved cut indices are retained. The rounded pumpkin used by bowling and cosmetics is unchanged. Generation and UV-preserving partition provenance are recorded in `provenance/halloween`.

## Halloween festival (v0.23.0)

Adds the eight-day Orange SMP Halloween festival artwork: physical carnival stations, four story ghosts, camera and portraits, a shared cauldron, seasonal Kitchen ingredients and treats, fishing collectibles and wearable rewards. Every new design is an actual Voxel Forge generation. Provenance and recorded derivatives are in `provenance/halloween`.

The carving pumpkin keeps its generated geometry and texture coordinates while being partitioned into editable cells. Custom model flags render a saved sculpture in one display entity. Kitchen's existing HUD gains item projections and recipe silhouettes while retaining its previous font characters.

Pair with the Events, Halloween, Kitchen and Furniture bundle. Halloween furniture uses Candy only during the active event; earned rewards remain usable afterward. Operator setup and the eight-day calendar are documented in `orange-smp-halloween/README.md` in the master project.

## Paintball HUD redesign (v0.18.1)

Paintball now uses the existing **Barlow Condensed** Medium/Bold typeface under the SIL Open Font License 1.1. The original TTFs and license are included in `assets/orangesmp/font/source`, with source links and rasterization provenance in `provenance/paintball-font`. The user explicitly requested an existing font rather than Voxel Forge font generation.

Large ammo numbers, amber low-ammo feedback, a solid team-coloured progress meter, a compact scoreboard and quieter translucent cards replace the first HUD layout. Backing and meter artwork are two actual Voxel Forge generations recorded in `provenance/paintball-hud-v2`. Core shaders and other plugin fonts remain unchanged.

## Orange SMP Paintball (v0.18.0)

Adds sporty Popper and Burst shooters, orange/blue paintball projectiles and temporary splat appearances. The core-shader HUD uses a generated panel and reticle with existing shared lettering and shaders. All six source designs are actual Voxel Forge generations; exports, team-tint adaptations and technical glyph carriers record their parentage in `provenance/paintball`. Pair with OrangeSMPEvents and OrangeSMPPaintball 0.1.0. Installing the plugins does not activate the event.

## Orange SMP Furniture (v0.16.0)

Includes 76 actual Voxel Forge furniture generations: 40 everyday and 36 Halloween designs, including chairs, sofas, tables, cabinets, workbenches, lamps, garden ornaments, pumpkin furniture and haunted decorations. Stable item aliases use `orangesmp:furniture/<design>`. Source jobs, editable generated assets and export checksums are recorded in `provenance/furniture`.

The furniture shop, repeatable delivery quests and reward mailbox use the shared core shader HUD. Its 159 carriers reuse the two existing generated panel/control sources and add small and large projections of all 76 furniture models. Artwork parentage and transport metadata are recorded in `provenance/furniture-hud`. Existing core shaders, shared lettering, cursor, pet assets and Model Engine exports are preserved. Pair with Orange SMP Furniture 0.1.0 on Paper 26.3 and Full Send's Minecoin banking service.

## Full Send Penguin Cross and Roulette (v0.7.0)

Adds a Voxel Forge penguin, orca, arctic pond and roulette-table base, plus validated ice-floe, roulette-wheel, ball, hub and chip assets. Four generated sources and all derivatives are recorded in `provenance/fullsend-expansion`. Pair with the Full Send update providing the 5×2 Penguin Cross pond and 3×3 shared European roulette table. Existing Minecoin banking, blackjack, slots and shared HUD lettering are preserved. All new gameplay stays on world blocks; no new fonts or game HUDs.

## Full Send (v0.6.0)

Adds new Voxel Forge blackjack-table and slots-cabinet models, physical card/reel/control artwork, and the oPhone Banking icon. Four generated sources and validated derivatives are recorded in `provenance/fullsend`. Full Send reuses the existing HUD lettering for its optional balance line above the action bar. Games render on world blocks with ordinary Minecraft text displays, not a game HUD. Pair with Full Send 0.1.0 and the updated oPhone/Kitchen plugins.

## oPhone (v0.5.0)

v0.5.1 adds the unread-message number badge and corrects app icon proportions using fitted Voxel Forge exports. Pair with the oPhone update that allows every player to run `/ophone give` for themselves.

Adds the oPhone item, portrait HUD frame, six app icons, four collectible wallpapers and three original ringtones. Seven Voxel Forge generations and their validated/exported derivatives are recorded in `provenance/ophone`. The existing Kitchen font and cursor are reused. A narrowly scoped extension to the shared 26.3 core shader positions native player heads for contacts and incoming-call popups. Pair with OrangeSMPOPhone 0.1.0, updated Core's local HomesService and Kitchen's shared HUD lock.



The pack uses the owner's `orange_item.png` as its icon, imported and exported through Voxel Forge without changing the artwork. Core's status dots and home menu use vanilla text and items, so they also work when a player declines the pack. All future custom assets must be created or edited through the Voxel Forge project.



Download the latest `orange-smp-resource-pack.zip` from this repository's releases. Server configuration must use the matching SHA-1 in `orange-smp-resource-pack.zip.sha1`; update both the URL and hash together when publishing a new version.



Build from PowerShell with `./build.ps1`. To publish, commit the changes, push a new version tag, and upload the ZIP and SHA-1 with `gh release create <tag> dist/orange-smp-resource-pack.zip dist/orange-smp-resource-pack.zip.sha1 --title <tag> --notes <release-notes>`.



The `provenance` directory records editable Voxel Forge source and the exported PNG's checksum. It is excluded from the playable ZIP.



## Kitchen artwork



Orange SMP Kitchen adds 148 custom item appearances, 52 crop-stage models, 103 locked-recipe silhouettes, and an illustrated cookbook panel. Source artwork comes from **162 actual Voxel Forge AI generations**. Early crop stages and silhouettes are recorded derivatives of those generated sources, validated and exported by the same studio. Stable item aliases use `orangesmp:kitchen/<id>`.



`provenance/kitchen/generated-assets.json` records source jobs, asset IDs and derivative parentage. The accompanying source JSON and export ZIPs make the artwork reproducible. `owned-files.json` records exported-file hashes. The original hand-authored prototype is not part of the release.



The cookbook uses a bitmap-font panel aligned with Minecraft's six-row inventory screen. Its version-pinned core text shader adds a subtle warm animation only to GUI glyphs using the reserved `FE FD FC` color; ordinary text and world rendering retain the vanilla paths. Paper handles the mouse interactions and recipe progression. The pack does not introduce a client mod.





## Cooking activity HUD



The full-screen workstation HUD adds a generated kitchen background, sixteen-tool sprite sheet and cursor from three more Voxel Forge generations. Its 711 carriers include these generated images, Fantasy SMP’s exact Consolas lettering, 283 item/silhouette icons in two sizes, and technical controls authored/exported through Voxel Forge. Food icons are rendered using Voxel Forge’s model renderer and imported through the validated studio API. Editable source and export checksums are in `provenance/kitchen-hud`.



The version-pinned text vertex shader places marked font carriers on a 960 Ã— 540 canvas. Mirrored corner metadata follows the corrected Fantasy SMP approach and works when GUI batches begin at unaligned vertices. Ordinary glyphs remain on the vanilla rendering path. The fragment shader renders the images, animated targets and controls alongside the existing cookbook effect. The plugin handles cursor movement, ingredient transfer and workstation-specific activities.



Food models include fitted first- and third-person transforms for both hands. Their generated geometry, texture artwork and placed-world scale are preserved.


The shared-kitchen update adds live quality stars, sixteen animated workstation tool carriers, bubbles, sparks and miss effects. These carriers are exported through Voxel Forge; core shaders animate the original generated tool artwork. Pair this pack with the shared-cooking/star-quality Kitchen plugin update.

Dropped custom items use larger ground display transforms exported through Voxel Forge: +50% scale for 3D models and +30% for flat items. Ground positions are adjusted around their bounds; held and placed-world poses are preserved.

Custom 3D models explicitly map eating/item particles to their generated material texture. The corrected Voxel Forge exporter preserves all geometry, pixels and display transforms.


Full Send Dragon Tower and poker assets: Voxel Forge tower cabinet, six-seat felt table, four door states and dealer marker. Export sources, generation jobs and SHA-256 manifests are in `provenance/fullsend-tower-poker`. Card and chip models reuse the existing Voxel Forge Full Send assets. All game labels use ordinary Minecraft text; no added font providers or shaders.

## Orange Pets

The pet collection contains 57 actual Voxel Forge generations: 36 animal coats across hamster, ferret, hedgehog, otter, raccoon, capybara, guinea pig, chinchilla, red panda, dragon, phoenix, and unicorn; three progressive egg stages; four physical beds; and 14 accessories. Inventory projections preserve the generated geometry and pixels. Original studio assets, generation IDs, projection parentage, exports, and checksums are in `provenance/orange-pets`.

The animated animals use Model Engine 4.1.1. The pack includes the compiled bone models and their texture dependencies, using stable `modelengine:orangepets_*` identifiers. Existing shared fonts and shaders are preserved. Pair this release with Orange Pets and its 36 corresponding server blueprints.

Orange Pets now uses the shared core-shader HUD for every pet menu. `orangesmp:pets_hud` adds 121 carriers from two actual Voxel Forge frame/control generations and projections of the 57 generated pet assets. Sources and checksums are in `provenance/pets-hud`. Kitchen's cursor and lettering are reused; the shared shader code is unchanged. Controls are mouse-look and click, sneak to close, F to center, and hotbar scroll to select food.

Pet cosmetics are now fitted, optional parts of all 36 animated animal models. Hats and bows inherit head movement; neckwear inherits body movement. The 14 original Voxel Forge accessories are fitted through the studio with their texture pixels and cube topology preserved. The 504 validated compositions, source parent IDs, transforms and blueprint checksums are in `provenance/pet-cosmetic-rigs`. Pair this pack with the matching Orange Pets cosmetic-bone update and server blueprints; switching styles changes visibility without teleporting an accessory or respawning the pet.

The hedgehog eye correction removes duplicate side-eye marks and gives the front pair symmetrical spacing on brown, dark and pale coats. These are Voxel Forge refinements with exactly four changed pixels per coat; geometry, bones and animations are preserved. Repair jobs, original sources and pixel verification are recorded in `provenance/hedgehog-eye-fix`. World models, fitted cosmetics and item/HUD projections use the same corrected artwork.

Three additional Voxel Forge hats are available in the pet shop: top hat (100 Minecoins), wizard hat (125), and crown (150). All are reusable account unlocks and fit every animal coat. Generation jobs are recorded in `provenance/pet-hats`; fitted exports remain in the cosmetic rig manifest. Existing HUD icon codepoints are preserved; the new hats add six carriers.

The expansion adds guinea pigs (tricolor, cream, chocolate), chinchillas (grey, white, charcoal), and red pandas (russet, golden, dark), plus chef, pirate, cowboy, party, beanie, and flower-crown hats. All designs are actual Voxel Forge generations recorded in provenance/pet-expansion. Guinea pig eye refinements centre the pair symmetrically, with the four-pixel correction and preserved rig recorded in provenance/guinea-eye-fix. New hats have fitted optional head bones across all 36 coats and unchanged artwork in their inventory/HUD projections.

Dragon, Phoenix and Unicorn add nine Voxel Forge generated coats to the pure mystery egg pool. Generation jobs are in `provenance/pet-mythical`; original art, inventory projections and fitted rig parentage remain in the existing pet manifests. All 14 wearable styles fit the 36 animated coats, including headwear adapted around horns and crests. Pair with the matching 12-species Orange Pets plugin and 36 server blueprints.

## Halloween decoration expansion

Twelve more Voxel Forge decorations bring furniture to 88 designs (48 Halloween): gargoyle, haunted portrait, spiderweb corner, potion display, haunted rag doll, mummy sarcophagus, pumpkin wheelbarrow, bone wind chime, hanging bat mobile, ghost trio, skull banner and witch hat stack. Every piece has small and large core-shader shop previews. Source generation jobs and projection parents remain in `provenance/furniture` and `provenance/furniture-hud`. Pair with the furniture update that corrects the aquarium and other multiblock display rotations to match their collision cells.
