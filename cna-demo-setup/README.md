# cna-demo
Easy to set up cloud-native architecture demo for PCF. Consists of two apps, greeting-ui and fortune-service, and a database used by fortune-service. Can be used to demo all three services in Spring Cloud Services, container to container networking, and distributed tracing in PCF Metrics.

This section explains how to manually deploy this demo to Pivotal Cloud Foundry. (For instructions on how to set up a CI/CD pipeline for automated deployment of the demo, please see the [cloud-pipelines README](cloud-pipelines/README.md).)

This demo comprises four repos:
* https://github.com/ciberkleid/cna-demo-setup.git - Set up instructions and deployment scripts
* https://github.com/ciberkleid/fortune-service.git - Backend service, returns fortunes
* https://github.com/ciberkleid/greeting-ui.git - Front-end service, displays fortunes
* https://github.com/ciberkleid/app-config - Config repo

# instructions

1. Clone the setup repo and the two project repos into a single local directory:
```
mkdir cna-demo
cd cna-demo
git clone https://github.com/ciberkleid/cna-demo-setup.git
git clone https://github.com/ciberkleid/fortune-service.git
git clone https://github.com/ciberkleid/greeting-ui.git
```

2. Use the cf CLI to target the space to which you wish to deploy.

3. From the cna-demo-setup directory, run the setup script:
```
cd cna-demo-setup
. ./00_setup.sh
```

Answer the prompts from the script:

* Provide the git address to back the Config Server
    * The default value is https://github.com/ciberkleid/app-config. If you wish to set or change config values, fork this repo and enter the new value.
* Choose whether or not to leverage container-to-container networking
    * Note that at this time, you must set C2C=N in order to demo distributed tracing in PCF Metrics.
* Choose whether or not to build the apps
    * If 'Y', the script will run "./mvnw clean install" for both fortune-service and greeting-ui.

The script will create the necessary services and deploy the two applications to the targeted space. It will also optionally enable access between the apps for C2C networking using Eureka. Alternatively, the mesh setup script can be used for C2C networking using the default PCF internal domain.

4. [Optional] To delete the apps, routes, and services created by the setup script, run the cleanup script. Answer the prompts to control if just apps and routes are deleted, or services as well.
```
. ./01_cleanup.sh
```
