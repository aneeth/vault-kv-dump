# vault-kv-dump
This is a quick and dirty version to dump all KV (v1) secrets and policies from vault to a folder structure. 
The associated write script would write the dumped data to a v2 KV

## Usage
* dump secrets
`TOKEN="..." VAULT_ADDR="..." KV_MOUNTS="..." ./dump_kv.sh`

* dump policies
`TOKEN="..." VAULT_ADDR="..." ./dump_policies.sh`

* write secrets
`DUMP_FOLDER="..." TOKEN="..." VAULT_ADDR="..." ./write_kv.sh`

## SOCK Proxy
You can specify a SOCK5 proxy using `SOCK_PROXY="sock5h://..."`
