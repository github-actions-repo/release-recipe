## release-recipe

Enter your GitHub username and the PAT token with access to packages.

```
npm login --registry https://npm.pkg.github.com

npm install
docker build -t hello-world-recipe .
docker run -it -p 3000:3000 hello-world-recipe
```

## Using OIDC to securely deploy to any cloud

```
export GHCR_PAT=<YOUR_PAT_TOKEN>
git clone https://github.com/github-actions-repo/release-recipe.git
chmod +x setup-azure.sh
./setup-azure.sh
```

1. Use Cloud Shell or a local terminal and create a new **app registration**.
   
   ```
   az ad app create --display-name release-recipe
   ```

2. Then create a **service principle** using **app ID** from the registration output:
   
   ```
   az ad sp create --id <appId>
   ```

3. Then, open the Azure portal, and in **Microsoft Entra ID**, find **release-recipe** under **App registrations**. Add the OIDC trust under **Certificates & secrets | Federated credentials | Add credentials**. Fill out the form. Set the organization to your GitHub username, enter the repository name, and pick **Environment** as the entity type
   
   Give the credentials a name and click **Add**. Note the **Application (client) ID** and **Directory (tenant) ID** of the **release-recipe** application (see Figure 7.2). You will need that later:

4. Then, assign the service principle a role in your subscription. Open the subscription in the portal. Under **Access control (IAM) | Role assignment | Add | Add role assignment**, follow the wizard. Select role—for example, **Contributor**—and click **Next**. Select **User, group, or service principal**, and select the service principle you created earlier.


**Environment approval checks**

Make sure you have the **Application (client) ID**, **Directory (tenant) ID**, and **Subscription ID** from the previous chapters at hand. The subscription ID can be obtained by using the following

```
az account show

Environments -> Create 'Production'
AZURE_CLIENT_ID: Application (client) ID
AZURE_TENANT_ID: Directory (tenant) ID
AZURE_SUBSCRIPTION_ID: Subscription ID
AZURE_CLUSTER_NAME: AKSCluster
AZURE_RESOURCE_GROUP: AKSCluster
```


**Automating the update of your dependencies**

In the repository, navigate to **Settings | Code security and analysis** and make sure that **Dependency graph** is enabled.

1. Create a new dependabot secret called **PAT** and set it with the value of the PAT token with read access to packages:
   
   ```
   gh secret set PAT --app dependabot
   ```