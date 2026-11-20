rec {
  disks = {
    data1 = {
      device = "/dev/disk/by-id/ata-ST8000NM0045-1RL112_ZA159V83";
      mapperName = "p1";
    };
    data2 = {
      device = "/dev/disk/by-id/ata-ST8000NM0045-1RL112_ZA158CRD";
      mapperName = "p2";
    };
  };

  primaryMapperDevice = "/dev/mapper/${disks.data1.mapperName}";

  mountOptions = [
    "noauto"
    "nofail"
    "compress=zstd"
    "noatime"
  ];

  # Keep the order used by media-storage-unlock.
  volumes =
    map
      (
        volume:
        volume
        // {
          subvolume = "@${volume.name}";
          mountpoint = "/mnt/storage/${volume.name}";
        }
      )
      [
        {
          name = "media";
          target = "arr-media.target";
        }
        {
          name = "photos";
          target = "immich-photos.target";
        }
        {
          name = "documents";
          target = "paperless-documents.target";
        }
        { name = "backups"; }
      ];
}
