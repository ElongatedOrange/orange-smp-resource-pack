# Orange SMP Resource Pack

Minecraft Java 26.3 resource pack, maintained by Elongated_Orange.

The pack uses the owner's `orange_item.png` as its icon, imported and exported through Voxel Forge without changing the artwork. Core's status dots and home menu use vanilla text and items, so they also work when a player declines the pack. All future custom assets must be created or edited through the Voxel Forge project.

Download the latest `orange-smp-resource-pack.zip` from this repository's releases. Server configuration must use the matching SHA-1 in `orange-smp-resource-pack.zip.sha1`; update both the URL and hash together when publishing a new version.

Build from PowerShell with `./build.ps1`. To publish, commit the changes, push a new version tag, and upload the ZIP and SHA-1 with `gh release create <tag> dist/orange-smp-resource-pack.zip dist/orange-smp-resource-pack.zip.sha1 --title <tag> --notes <release-notes>`.

The `provenance` directory records editable Voxel Forge source and the exported PNG's checksum. It is excluded from the playable ZIP.

## Kitchen artwork

Orange SMP Kitchen adds 148 custom item appearances, 52 crop-stage models, 103 locked-recipe silhouettes, and an illustrated cookbook panel. Source artwork comes from **162 actual Voxel Forge AI generations**. Early crop stages and silhouettes are recorded derivatives of those generated sources, validated and exported by the same studio. Stable item aliases use `orangesmp:kitchen/<id>`.

`provenance/kitchen/generated-assets.json` records source jobs, asset IDs and derivative parentage. The accompanying source JSON and export ZIPs make the artwork reproducible. `owned-files.json` records exported-file hashes. The original hand-authored prototype is not part of the release.

The cookbook uses a bitmap-font panel aligned with Minecraft's six-row inventory screen. Its version-pinned core text shader adds a subtle warm animation only to GUI glyphs using the reserved `FE FD FC` color; ordinary text and world rendering retain the vanilla paths. Paper handles the mouse interactions and recipe progression. The pack does not introduce a client mod.


## Cooking activity HUD

The full-screen workstation HUD adds a generated kitchen background, sixteen-tool sprite sheet and cursor from three more Voxel Forge generations. Its 124 carriers include these generated images, imported vanilla lettering and technical controls authored/exported through Voxel Forge. Editable source and export checksums are in `provenance/kitchen-hud`.

The version-pinned text vertex shader places marked font carriers on a 960 × 540 canvas. Mirrored corner metadata follows the corrected Fantasy SMP approach and works when GUI batches begin at unaligned vertices. Ordinary glyphs remain on the vanilla rendering path. The fragment shader renders the images, animated targets and controls alongside the existing cookbook effect. The plugin handles cursor movement, ingredient transfer and workstation-specific activities.
