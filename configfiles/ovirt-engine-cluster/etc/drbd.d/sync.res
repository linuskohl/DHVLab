resource sync {

   protocol C;
   meta-disk internal;
   device /dev/drbd0;
   syncer {
       verify-alg sha1;
   }
   on CLUSTER_N1.clan {
      disk /dev/centos/sync;
      address CLUSTERLAN_CLUSTER_N1_IP:7789;
   }

   on CLUSTER_N1.clan {
      disk /dev/centos/sync;
      address CLUSTERLAN_CLUSTER_N2_IP:7789;
  }
}

