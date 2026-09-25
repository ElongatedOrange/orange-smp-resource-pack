# Orange SMP Resource Pack



Minecraft Java 26.3 resource pack, maintained by Elongated_Orange.

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
