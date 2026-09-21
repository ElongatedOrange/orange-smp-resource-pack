# Orange SMP Resource Pack

Minecraft Java 26.3 resource pack, maintained by Elongated_Orange.

The initial pack contains the Orange SMP pack icon created through Voxel Forge. Core's status dots and home menu use vanilla text and items, so they also work when a player declines the pack. All future custom assets must be created or edited through the Voxel Forge project.

Download the latest `orange-smp-resource-pack.zip` from this repository's releases. Server configuration must use the matching SHA-1 in `orange-smp-resource-pack.zip.sha1`; update both the URL and hash together when publishing a new version.

Build from PowerShell with `./build.ps1`. To publish, commit the changes, push a new version tag, and upload the ZIP and SHA-1 with `gh release create <tag> dist/orange-smp-resource-pack.zip dist/orange-smp-resource-pack.zip.sha1 --title <tag> --notes <release-notes>`.

The `provenance` directory records editable Voxel Forge source and the exported PNG's checksum. It is excluded from the playable ZIP.
