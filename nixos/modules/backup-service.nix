# TODO maybe switch to something like restic
{
  systemd = {
    services.backup = {
      description = "backup using script located at /opt/bin/backup.sh";
      serviceConfig = {
        # Environment="PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin";
        Type="simple";
        ExecStart="/opt/bin/backup.sh";
        Restart="no";
        MemoryMax="10G";
        MemoryHigh="6G";
        MemorySwapMax="11G";
        CPUAccounting="false";
      };
      wantedBy = [ "multi-user.target" ];
    };
    timers.backup = {
      description = "runs the backup service weekly";
      timerConfig = {
        OnBootSec = "45min";
        OnUnitActiveSec = "1w";
      };
      wantedBy = [ "timers.target" ];
    };
  };
}
