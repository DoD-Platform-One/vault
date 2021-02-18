# -----------------------------------------------------------------------------
# Approve control group requests
# -----------------------------------------------------------------------------
path "sys/control-group/authorize" {
    capabilities = ["create", "update"]
}

# -----------------------------------------------------------------------------
# Check control group request status
# -----------------------------------------------------------------------------
path "sys/control-group/request" {
    capabilities = ["create", "update"]
}
