---
title: Named Values
parent: Policy Expressions
has_children: false
nav_order: 4
---


## Calculator API

### Named Values collection

*Named Values* (aka *Properties*) are a collection of key/value pairs that are global to the service instance. These properties can be used to manage `string` constants across all API configurations and policies. Values can be expressions, secrets (encrypted by APIM), or Key Vault, which links to a corresponding secret in Azure Key Vault.

- Open the `Named values` blade in the resource menu and press **+ Add**.
- Create the new property:
  - Name: **TimeNow**
  - Display name: **TimeNow**
  - Type: **Plain**
  - Value: `@(DateTime.Now.ToString())`

    ![APIM Named Values](../../assets/images/apim-named-values.png)

- Back in the *APIs* blade, open the *Add two integers* operation in the Calculator API. 
- Amend the inbound `set-header` policy by clicking on the pencil icon.
- Create a new header by pressing **+ Add header**:
  - Name: **x-request-received-time**
  - Value: `{{"{{TimeNow"}}}}`
  - Action: **override**  
- The corresponding XML in the *Code editor* view should look like this: 

  ```xml    
  <inbound>
      <base />
      <set-query-parameter name="x-product-name" exists-action="override">
          <value>@(context.Product?.Name ?? "none")</value>
      </set-query-parameter>
      <set-header name="x-request-context-data" exists-action="override">
          <value>@(context.Deployment.Region)</value>
      </set-header>
      <set-header name="x-request-received-time" exists-action="override">
          <value>{{"{{TimeNow"}}}}</value>
      </set-header>
  </inbound>
  ```

### Named Value collection with Terraform
- In the root main.tf file, uncomment the code definition containing the named-value-collection policy filename. Make sure to also uncomment the Named Value Collection in the root main.tf Terraform file.  No variables are interpolated for this policy.
  
  Ensure that only the proper section is uncommented using the Lab Section comments.

  ![Terraform APIM Calc API Named Value collection policy](../../assets/images/tf-module-4-add-named-value-collection-policy.png)
  
- Execute a Terraform Init and Terraform Apply with these changes, this will create the Named Value collection policy for the Calc API operation.

- Test the operation by selecting the *Starter* or *Unlimited* product scope. 
- Examine the backend trace to find the added header with the evaluated named value:

  ```json
  {
    "name": "x-request-received-time",
    "value": "12/30/2021 6:10:47 PM"
  }
  ```