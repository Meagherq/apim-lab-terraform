# Configure the default provider
provider "azurerm" {
    version           = "=3.43.0"
    subscription_id   = var.subscription_id

    features {}
}

provider "azuread" {
  version           = "=2.33.0"
  subscription_id   = var.subscription_id

  features {}
}

#data
data "azurerm_client_config" "current" {}

module "resource_group" {
    source = "../../modules/azurerm/resource_group"

    name   = "${var.environment_prefix}-${var.initials}-rg"
    location = var.location
}

#Azure API Management
module "apim" {
    source = "../../modules/azurerm/api_management"

    name = "${var.environment_prefix}-${var.initials}-apim"
    location = module.resource_group.location
    publisher_name = ""
    publisher_email = ""
}

module "apim_global_cors_policy" {
    source = "../../modules/azurerm/api_management_policy"

    api_management_id = module.apim.id
    policy_filename = "cors"
    vars = { origins = [module.apim.developer_portal_url] }
    # Use line below to add the StarWars API to the global CORS policies
    # vars = { origins = [module.apim.developer_portal_url, module.apim_starwars_api.origin]}
}

# # Lab 2 Developer Portal: Section 3 Product Management
# Gold Tier Product
# module "apim_gold_tier_product" {
#     source = "../../modules/azurerm/api_management_product"

#     product_id = "goldtier"
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
#     display_name = "Gold Tier"
#     subscription_required = true
#     published = true
#     approval_required = false
# }

# module "apim_developers_group_gold_tier_product" {
#     source = "../../modules/azurerm/api_management_product_group"
    
#     product_id = "goldtier"
#     group_name = "developers"
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
# }

# module "apim_guests_group_gold_tier_product" {
#     source = "../../modules/azurerm/api_management_product_group"
    
#     product_id = "goldtier"
#     group_name = "guests"
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
# }

# module "apim_starwars_api_version_set" {
#     source = "../../modules/azurerm/api_management_api_version_set"
#
#     name = "starwars-api-vs"
#     resource_group_name = module.resource_group.name
#     api_management_name = module.apim.name
#     display_name = "StarWarsApiVersionSet"
# }

# # Lab 3 Adding APIs: Section 1 Add API from scratch
# module "apim_starwars_api" {
#     source = "../../modules/azurerm/api_management_api"

#     name = "star-wars"
#     display_name = "Star Wars"
#     description = "Implementing the Star Wars API."
#     service_url = "https://swapi.dev/api"
#     path = "sw"
#     protocols = ["https"]
#     version_set_id = module.apim_starwars_api_version_set.id
# }

# module "apim_starwars_api_starter_product_assocation" {
#     source = "../../modules/azurerm/api_management_product_api"
#
#     api_name = module.apim_star_wars_api.name
#     resource_group_name = module.resource_group.name
#     api_management_name = module.apim.name
#     product_id = "Starter"
# }

# module "apim_starwars_api_unlimited_product_assocation" {
#     source = "../../modules/azurerm/api_management_product_api"
#
#     api_name = module.apim_star_wars_api.name
#     resource_group_name = module.resource_group.name
#     api_management_name = module.apim.name
#     product_id = "Unlimited"
# }

# module "apim_starwars_api_getpeople" {
#     source = "../../modules/azurerm/api_managment_api_operation"

#     operationId = "getpeople"
#     api_name = module.apim_starwars_api.name
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
#     display_name = "GetPeople"
#     method = "GET"
#     url_template = "/people/"
#     description = "Get all people"
#     status_code = 200
# }

# module "apim_starwars_api_getpeoplebyid" {
#     source = "../../modules/azurerm/api_managment_api_operation"

#     operationId = "getpeoplebyid"
#     api_name = module.apim_starwars_api.name
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
#     display_name = "GetPeopleById"
#     method = "GET"
#     url_template = "/people/{id}"
#     description = "Get people by Id"
#     status_code = 200
# }

# # Lab 3 Adding APIs: Section 2 Import API using OpenAPI
# module "apim_calc_api" {
#     source = "../../modules/azurerm/api_management_api"

#     name = "basic-calculator"
#     display_name = "Basic Calculator"
#     description = "Arithmetics is just a call away!"
#     # service_url = "https://swapi.dev/api"
#     path = "calc"
#     protocols = ["https, http"]

#     content_format = "swagger-link-json"
#     content_value = "http://calcapi.cloudapp.net/calcapi.json"
# }

# # Lab 3 Adding APIs: Section 3 Calling APIs
# module "apim_colors_api" {
#     source = "../../modules/azurerm/api_management_api"

#     name = "colors-api"
#     display_name = "Colors API"
#     description = "Fun with Colors"
#     # service_url = "https://swapi.dev/api"
#     path = ""
#     protocols = ["https]
#     
#     content_format = "swagger-link-json"
#     content_value = "https://colors-api.azurewebsites.net/swagger/v1/swagger.json"
# }


# # Lab 4 Policy Expressions Section 2 Caching Policy
# module "apim_calc_api_getrandcolor_policy" {
#   source = "../../modules/azurerm/api_management_api_operation_policy"

#   api_name            = module.apim_calc_api.name
#   api_management_name = module.apim.name
#   resource_group_name = module.resource_group.name
#   operation_id        = "getrandomcolor"
#
#   policy_filename     = "cache-lookup"
#
# # Lab 4 Policy Expressions Section 3 Transformational Policies - Find and Replace
# # policy_filename     = "transform-find-and-replace"
#
# }

# # Lab 4 Policy Expressions Section 3 Transformational Policies - Conditional Transformation
# module "apim_starwars_api_getpeoplebyid_policy" {
#   source = "../../modules/azurerm/api_management_api_operation_policy"

#   api_name            = module.apim_starwars_api.name
#   api_management_name = module.apim.name
#   resource_group_name = module.resource_group.name
#   operation_id        = module.apim_starwars_api_getpeoplebyid.operation_id
#
#   policy_filename     = "transform-conditional"
# }

# # Lab 4 Policy Expressions Section 3 Transformational Policies - XML to JSON
# module "apim_calc_api_addtwointegers_policy" {
#   source = "../../modules/azurerm/api_management_api_operation_policy"

#   api_name            = module.apim_calc_api.name
#   api_management_name = module.apim.name
#   resource_group_name = module.resource_group.name
#   operation_id        = "addtwointegers"
#
#   policy_filename     = "xml-to-json"
#
# # Lab 4 Policy Expressions Section 3 Transformational Policies - Delete Response Headers
# # policy_filename     = "delete-response-headers"
#
# # Lab 4 Policy Expressions Section 3 Transformational Policies - Amend Request to Backend
# # policy_filename     = "amend-request"
#
# # Lab 4 Policy Expressions Section 4 Named Values - Named Value Collection
# # policy_filename     = "named-value-collection"
# 
# # Lab 4 Policy Expressions Section 4 Send One Way Policy - Send One Way Request Setup
# # policy_filename     = "send-one-way-request"
# # vars = { webhook_url = "" }

# # Lab 4 Policy Expressions Section 4 Abort Porcessing Policy - Abort Processing
# # policy_filename     = "abort-processing"
# }

# # Lab 4 Policy Expressions Section 4 Named Values
# module "apim_timenow_named_value" {
#   source = "../../modules/azurerm/api_management_named_value"

#     name = "TimeNow"
#     display_name = "TimeNow"
#     resource_group_name = module.resource_group.name
#     api_management_name = module.apim.name
#     value = "@(DateTime.Now.ToString())"
# }

# # Lab 4 Policy Expressions Section 4 Mock Policies
# module "apim_starwars_api_getfilm" {
#     source = "../../modules/azurerm/api_managment_api_operation"

#     operationId = "getfilm"
#     api_name = module.apim_starwars_api.name
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
#     display_name = "GetFilm"
#     method = "GET"
#     url_template = "/film"
#     description = "Gets a film"
#     status_code = 200
# }

# module "apim_starwars_api_getfilm_policy" {
#   source = "../../modules/azurerm/api_management_api_operation_policy"

#   api_name            = module.apim_starwars_api.name
#   api_management_name = module.apim.name
#   resource_group_name = module.resource_group.name
#   operation_id        = module.apim_starwars_api_getfilm.operation_id
#
#   policy_filename     = "mock-policy"
# }

# # Lab 4 Versioning & Revisions Section 1 Versions
# module "apim_starwars_api_v2" {
#     source = "../../modules/azurerm/api_management_api"

#     name = "star-wars-v2"
#     display_name = "Star Wars"
#     description = "Implementing the Star Wars API."
#     service_url = "https://swapi.dev/api"
#     path = "sw"
#     protocols = ["https"]
#     version_set_id = module.apim_starwars_api_version_set.id
#     version = "v2"
#     name = "star-wars-v2"
# }

# module "apim_starwars_api_v2_starter_product_assocation" {
#     source = "../../modules/azurerm/api_management_product_api"
#
#     api_name = module.apim_star_wars_api_v2.name
#     resource_group_name = module.resource_group.name
#     api_management_name = module.apim.name
#     product_id = "Starter"
# }

# module "apim_starwars_api_v2_unlimited_product_assocation" {
#     source = "../../modules/azurerm/api_management_product_api"
#
#     api_name = module.apim_star_wars_api_v2.name
#     resource_group_name = module.resource_group.name
#     api_management_name = module.apim.name
#     product_id = "Unlimited"
# }

# module "apim_starwars_api_v2_getpeople" {
#     source = "../../modules/azurerm/api_managment_api_operation"

#     operationId = "getpeople"
#     api_name = module.apim_starwars_api_v2.name
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
#     display_name = "GetPeople"
#     method = "GET"
#     url_template = "/people/"
#     description = "Get all people"
#     status_code = 200
# }

# # Lab 4 Versioning & Revisions Section 2 Revisions
# module "apim_starwars_api_v2_rev2" {
#     source = "../../modules/azurerm/api_management_api"

#     name = "star-wars-v2"
#     display_name = "Star Wars"
#     description = "Implementing the Star Wars API."
#     service_url = "https://swapi.dev/api"
#     path = "sw"
#     protocols = ["https"]
#     version_set_id = module.apim_starwars_api_version_set.id
#     version = "v2"
#     revision = "2"
#     name = "star-wars-v2"
# }

# module "apim_starwars_api_v2_starter_product_assocation" {
#     source = "../../modules/azurerm/api_management_product_api"
#
#     api_name = module.apim_star_wars_api_v2_rev2.name
#     resource_group_name = module.resource_group.name
#     api_management_name = module.apim.name
#     product_id = "Starter"
# }

# module "apim_starwars_api_v2_rev2_unlimited_product_assocation" {
#     source = "../../modules/azurerm/api_management_product_api"
#
#     api_name = module.apim_star_wars_api_v2_rev2.name
#     resource_group_name = module.resource_group.name
#     api_management_name = module.apim.name
#     product_id = "Unlimited"
# }

# module "apim_starwars_api_v2_rev2_getpeople" {
#     source = "../../modules/azurerm/api_managment_api_operation"

#     operationId = "getpeople"
#     api_name = module.apim_starwars_api_v2_rev2.name
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
#     display_name = "GetPeople"
#     method = "GET"
#     url_template = "/people/"
#     description = "Get all people"
#     status_code = 200
# }

# Lab 5 Analytics & Monitoring Section 2 Application Insights
# module "apim_log_analytics_workspace" {
#     source = "../../modules/azurerm/log_analytics_workspace"

#     name = "${var.environment_prefix}-${var.initials}-law"
# }

# module "apim_application_insights" {
#     source = "../../modules/azurerm/application_insights"

#     name = "${var.environment_prefix}-${var.initials}-insights"
#     location = module.resource_group.location
#     resource_group_name = module.resource_group.name
#     application_type = "other"
#     workspace_id = module.apim_log_analytics_workspace.id
# }

# module "apim_logger_application_insights" {
#     source = "../../modules/azurerm/api_management_logger"

#     name = "ai-apim-lab"
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
#     resource_id = module.apim_application_insights.id

#     application_insights_instrumentation_key = module.apim_application_insights.instrumentation_key
# }

# module "apim_colors_api_diagnostic_app_insights" {
#     source = "../../modules/azurerm/api_management_api_diagnostic"

#     name = "applicationinsights"
#     resource_group_name = module.resource_group_name
#     api_management_name = module.apim.name
#     api_name            = module.apim_starwars_api.name
#     api_management_logger_id = module.apim_logger_application_insights.id
#     verbosity = "verbose"
#     http_correlation_protocol = "Legacy"
#     sampling_percentage = "100"
# }

# # Lab 5 Analytics & Monitoring Section 2 Application Insights
# module "apim_eventhub_namespace" {
#     source = "../../modules/azurerm/eventhub_namespace"

#     name = "${var.environment_prefix}-${var.initials}-eh-ns"
#     location = module.resource_group.location
#     resource_group_name = module.resource_group.name
#     Sku = "Basic"
# }

# module "apim_eventhub" {
#     source = "../../modules/azurerm/eventhub"

#     name = "${var.environment_prefix}-${var.initials}-eh"
#     namespace_name = module.apim_eventhub_namespace.name
#     resource_group_name = module.resource_group.name
#     partition_count = 2
#     message_retention = 1
# }

# module "apim_eventhub_sas" {
#     source = "../../modules/azurerm/eventhub_authorization_rule"

#     name = "apim"
#     namespace_name = module.eventhub_namespace.name
#     eventhub_name = module.apim_eventhub.name
#     resource_group_name = module.resource_group.name
#     listen = false
#     send = true
#     manage = false
# }

# module "apim_logger_eventhub" {
#     source = "../../modules/azurerm/api_management_logger"

#     name = "eh-apim-lab"
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
#     resource_id = module.apim_eventhub.id

#     eventhub_name = module.apim_eventhub.name
#     eventhub_connection_string = module.apim_eventhub_sas.connection_string
# }

# module "apim_echo_api_log_to_eventhub_policy" {
#     source = "../../modules/azurerm/api_management_api_policy"

#     api_name = "echo-api"
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
#     policy_filename = "log-to-eventhub"

#     vars = { LoggerId = "${module.apim_logger_eventhub.id}" }
# }

# # Lab 6 Security Section 1 JSON Web Token Validation
# # Section requires changes to Policy file content
# module "apim_calc_api_validate_jwt_policy" {
#     source = "../../modules/azurerm/api_management_api_policy"

#     api_name = module.apim_calc_api.name
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
#     policy_filename = "validate-jwt"

#     vars = { SigningKey = "123412341234123412341234" }
# }

# # Lab 6 Security Section 2 Authorization Code Grant
# module "apim_backend_app_oauth_app_reg" {
#     source = "../../modules/azuread/application_registration"

#     display_name = "backend-app-oauth-${var.initials}"
#     app_identifier = "backendappoauth${var.initials}"
# }

# module "apim_backend_app_oath_app_reg_scope" {
#     source = "../../modules/azuread/application_registration_scope"

#     admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
#     admin_consent_display_name = "Access example"
#     type                       = "User"
#     user_consent_description   = "Allow the application to read files on your behalf."
#     user_consent_display_name  = "Read Files"
#     value                      = "files.Read"
# }

# module "apim_client_app_oauth_app_reg" {
#     source = "../../modules/azuread/application_registration"

#     display_name = "client-app-oauth-${var.initials}"
#     app_identifier = "clientappoauth${var.initials}"
#     resource_app_id = module.apim_backend_app_oauth_app_reg.id
#     permission_id = module.apim_backend_app_oath_app_reg_scope.id

#     redirect_uris = ["https://${module.apim.name}.developer.azure-api.net/signin-oauth/implicit/callback", "https://${module.apim.name}.developer.azure-api.net/signin-oauth/code/callback/oauth-authorizationcodeflow"]
# }

# # Lab 6 Security Section 3 Managed Identities
# module "apim_key_vault" {
#     source = "../../modules/azurerm/key_vault"

#     name = "${var.environment_prefix}-kv-${var.intitials}"
#     location = module.resource_group.location
#     resource_group_name = module.resource_group.name 
# }

# module "apim_key_vault_access_policy" {
#     source = "../../modules/azurerm/key_vault_access_policy"

#     key_key_vault_id = module.apim_key_vault
#     object_id = module.apim.principal_identity

#     key_permissions = [ "Get" ]
#     secret_permissions = [ "Get" ]
# }

# module "apim_starwars_api_getfavoriteperson" {
#     source = "../../modules/azurerm/api_managment_api_operation"

#     operationId = "getfavoriteperson"
#     api_name = module.apim_starwars_api.name
#     api_management_name = module.apim.name
#     resource_group_name = module.resource_group.name
#     display_name = "GetFavoritePerson"
#     method = "GET"
#     url_template = "/favorite"
#     description = "Get a favorite people"
#     status_code = 200
# }

# module "apim_starwars_api_getfavoriteperson_policy" {
#   source = "../../modules/azurerm/api_management_api_operation_policy"

#   api_name            = module.apim_starwars_api.name
#   api_management_name = module.apim.name
#   resource_group_name = module.resource_group.name
#   operation_id        = module.apim_starwars_api_getfavoriteperson.operationId

#   policy_filename     = "keyvault-managed-identities"

#   vars = { KeyVaultUri = "${module.apim_key_vault.vault_uri}" }
# }