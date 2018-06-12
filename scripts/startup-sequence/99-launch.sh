exec /sbin/tini -- su-exec ircd:ircd /opt/hybrid/bin/ircd \
  -configfile $DATADIR/config/server.conf \
  -klinefile $DATADIR/kline.db \
  -dlinefile $DATADIR/dline.db \
  -xlinefile $DATADIR/xline.db \
  -resvfile $DATADIR/resv.db \
  -logfile $DATADIR/ircd.log \
  -pidfile $DATADIR/ircd.pid \
  -foreground
