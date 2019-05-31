# Create a Highly Available PostgreSQL Cluster Using Patroni and HAProxy

This project has automated the creation of highly available postgreSQL cluster using patroni and HAProxy. To run the setup follow the following steps:

1. export `GOOGLE_APPLICATION_CREDENTIALS` and set the value to be the absolute path to your GCP service account that has permisions to create instances and network resources.
2. While on the root directory folder, run `./deploy.sh` command via your terminal. (NOTE: you might want to make the script executable first by running `chmod +x deploy.sh`)
3. Head to your `VM instances` under your GCP console and copy the external IP address of `harith-haproxy` instance and paste it into your browser window, append `:7000` to it and hit enter, VOILA, you have the cluster setup ready!
