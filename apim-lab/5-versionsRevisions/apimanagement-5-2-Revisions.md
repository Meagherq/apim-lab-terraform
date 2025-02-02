---
title: Revisions
parent: Versions & Revisions
has_children: false
nav_order: 2
---


## Revisions

### Add a new revision

- Select the *Star Wars* API v2.
- Select the *Revisions* tab.
- Add a new revision with description `Adding a caching policy.`

  ![APIM Revisions Menu](../../assets/images/apim-revisions-menu.png)
  ![APIM Revision Create](../../assets/images/apim-revisions-create.png)

  > The new revision is online but not yet current. The previous revision continues to remain the active default. Having added the new revision has not resulted in any change for your API consumers.

  ![APIM Created Revision](../../assets/images/apim-created-revision.png)

### Add caching

- Switch to the *Design* tab, then select the `GetPeople` operation.
  > *Revision 2* automatically became the active revision you are now making changes in. You can also switch between revisions, but **be aware that changes to the *Current* revision are live immediately**.

  ![APIM Revision Add Caching](../../assets/images/apim-revision-add-caching-1.png)

- Add a 10-second caching policy for the GET operation via the Code editor.

  ```xml
  <inbound>
      <base />
      <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" allow-private-response-caching="false" must-revalidate="false" downstream-caching-type="none" />
  </inbound>
  <backend>
      <base />
  </backend>
  <outbound>
      <base />
      <cache-store duration="10" />
  </outbound>
  ```

  ![APIM Revision Add Caching](../../assets/images/apim-revision-add-caching-2.png)

### Add a new revision with Terraform

API revisions can also be created in Terraform using the source_api_id property. This lets Azure know to perform the required background operations necessary to clone the previous api configuration.

- In the root main.tf file, uncomment the code definitions containing the Calculator API Version 2 Revision 2 using the Calculator Version 2 definition via the source_app_id property.
  
  Ensure that only the proper section is uncommented using the Lab Section comments.

  ![Terraform APIM Calc API v2 rev2](../../assets/images/tf-module-5-add-calc-api-v2-rev2.png)
  
- Execute a Terraform Init and Terraform Apply with these changes, this will create a rev2 resource for the Calculator API v2 and its configuration.

Note how new product associations are not required for revisions but are required for versions. 

### Test the new revision

- From the Azure portal, test the `GetPeople` operation.
  > Note the revision number at the top of the page as well as in the request URL.  
  The request URL should look similar to: `https://<your-apim-name>.azure-api.net/sw/v2;rev=2/people/`.

  ![APIM Revision Caching Test](../../assets/images/apim-revision-test-caching-1.png)

- Test the API twice. The test trace should then show that the cache-lookup occurred. 

  ![APIM Revision Caching Test](../../assets/images/apim-revision-test-caching-2.png)

### Make current revision

- Select the _Revisions_ tab.
- Click on the ellipsis for `rev2` and make it the current revision.

  ![APIM Revision Make Current](../../assets/images/apim-revision-make-current-1.png)

- Choose to post to the public change log for the API and provide a meaningful update.

  ![APIM Revision Make Current](../../assets/images/apim-revision-make-current-2.png)

- The new revision is now the current/live one. When you test now, note that the URL no longer contains a specific revision. The old revision is still online and can now be accessed with the `rev` qualifier. 

  > Unlike versioning, revisioning requires no URL updates for the API consumer.

  ![APIM Revision Make Current](../../assets/images/apim-revision-make-current-3.png)