resource virt {

   protocol C;
   meta-disk internal;
   device /dev/drbd1;
   syncer {
       verify-alg sha1;
   }
   on CLUSTER_N1.clan {
      disk /dev/centos/virt;
      address CLUSTERLAN_CLUSTER_N1_IP:7790;
   }

   on CLUSTER_N2.clan {
      disk /dev/centos/virt;
      address CLUSTERLAN_CLUSTER_N2_IP:7790;
  }
}

