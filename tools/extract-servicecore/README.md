# Extracting ServiceCore from this monorepo

Reproducible procedure for splitting the Flutter app in `FSC-Portal/` out into a
standalone product repository, with client and staff data removed from both the
working tree and the git history.

This directory exists so the extraction can be re-run or audited. It does not change
anything in this repository.

## Why

`FSC-Portal/` is the product. Everything customer-specific about it — client rows, site
lists, staff records, branding — is deployment data that belongs to a deployment, not to
the product. The split makes that boundary real: the product repo carries no customer
identity, and a deployment supplies its own.

## Procedure

Requires `git >= 2.30` and `git-filter-repo` (`pip install git-filter-repo`).

```bash
# 1. Split the app out, preserving its commit history.
#    Paths are rewritten to the repo root; commits, dates and authors are unchanged.
git subtree split --prefix=FSC-Portal -b product-split

# 2. Work on a fresh clone (git-filter-repo requires one).
git clone --single-branch --branch product-split . /tmp/servicecore
cd /tmp/servicecore

# 3. Drop client data files from history entirely.
git filter-repo --invert-paths \
  --path prosperity_branches.md --path prosperity_combined.md --force

# 4. De-identify the working tree (clients, staff, residences -> synthetic demo data)
#    and drop the client-specific location enrichment.
python3 <this-dir>/deident.py .

# 5. Commit the working-tree changes, then redact the same identifiers from all
#    historical blobs. Commit metadata (author, date, message) is not touched.
git filter-repo --replace-text <this-dir>/redactions.txt --force
```

Verify with a full-history sweep before pushing:

```bash
git rev-list --all --objects \
  | git cat-file --batch-check='%(objecttype) %(objectname) %(rest)' \
  | awk '$1=="blob"{print $2}' \
  | while read sha; do
      git cat-file blob "$sha" | grep -qiE "<identifier>" && echo "RESIDUAL"
    done
```

## What the split deliberately leaves alone

Renaming these is a data migration, not a rename. Each one orphans or destroys data in
existing installations:

| Identifier | Why |
|---|---|
| `fsc_portal_v1_2026_security` | Key-derivation salt. Changing it makes every encrypted database undecryptable. |
| `fsc_portal_db_key_encrypted` | Secure-storage key holding the database key. Renaming orphans the key. |
| `fsc_export_salt_v1` | Nonce for encrypted exports. Changing it breaks decryption of prior exports. |
| `fsc_portal_dev.sqlite`, `fsc_portal/`, `fsc_portal.db` | On-disk database paths. |
| `portal_offline/` | On-disk directories for attachments, receipts and local models. |
| `admin@fscportal.local` | Seeded admin account identity. |

The Android `applicationId` **is** changed (`com.example.portal_offline` →
`com.vyrevault.servicecore`). That is a new application identity: existing Android
installs will not upgrade in place. Harmless pre-release; deliberate afterwards.

## What this does not fix

The split produces a clean product repo. It does nothing about the history of *this*
repository, which still contains the original client and staff data in every commit
since 2026-05-01. Removing it here would require the same `filter-repo` treatment
applied to this repo, coordinated with anyone holding a clone or fork.
