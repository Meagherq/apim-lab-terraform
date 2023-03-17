resource "azurerm_api_management_email_template" "template" {
  template_name       = var.name
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name
  subject             = var.subject
  body                = <<EOF
<!DOCTYPE html >
<html>
<head>
  <meta charset="UTF-8" />
  <title>Customized Letter Title</title>
</head>
<body>
  <p style="font-size:12pt;font-family:'Segoe UI'">Dear $DevFirstName $DevLastName,</p>
</body>
</html>
EOF
}