# vault-kv-dump
This is a quick and dirty version to dump all KV (v1) secrets and policies from vault to a folder structure. 
The associated write script would write the dumped data to a v2 KV

## Usage
`TOKEN="..." VAULT_ADDR="..." KV_MOUNTS="..." ./dump_kv.sh`
`TOKEN="..." VAULT_ADDR="..." ./dump_policies.sh`
`DUMP_FOLDER="..." TOKEN="..." VAULT_ADDR="..." ./write_kv.sh`
