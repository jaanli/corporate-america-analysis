# Corporate America Analysis

This is an [Observable Framework](https://observablehq.com/framework) app. To start the local preview server, run:

```
yarn dev
```

Then visit <http://localhost:3000> to preview your app.

For more, see <https://observablehq.com/framework/getting-started>.

## Project structure

A typical Framework project looks like this:

```ini
.
├─ src
│  ├─ components
│  │  └─ timeline.js           # an importable module
│  ├─ data
│  │  ├─ launches.csv.js       # a data loader
│  │  └─ events.json           # a static data file
│  ├─ example-dashboard.md     # a page
│  ├─ example-report.md        # another page
│  └─ index.md                 # the home page
├─ .gitignore
├─ observablehq.config.js      # the app config file
├─ package.json
└─ README.md
```

**`src`** - This is the “source root” — where your source files live. Pages go here. Each page is a Markdown file. Observable Framework uses [file-based routing](https://observablehq.com/framework/routing), which means that the name of the file controls where the page is served. You can create as many pages as you like. Use folders to organize your pages.

**`src/index.md`** - This is the home page for your app. You can have as many additional pages as you’d like, but you should always have a home page, too.

**`src/data`** - You can put [data loaders](https://observablehq.com/framework/loaders) or static data files anywhere in your source root, but we recommend putting them here.

**`src/components`** - You can put shared [JavaScript modules](https://observablehq.com/framework/javascript/imports) anywhere in your source root, but we recommend putting them here. This helps you pull code out of Markdown files and into JavaScript modules, making it easier to reuse code across pages, write tests and run linters, and even share code with vanilla web applications.

**`observablehq.config.js`** - This is the [app configuration](https://observablehq.com/framework/config) file, such as the pages and sections in the sidebar navigation, and the app’s title.

## Command reference

| Command           | Description                                              |
| ----------------- | -------------------------------------------------------- |
| `yarn install`            | Install or reinstall dependencies                        |
| `yarn dev`        | Start local preview server                               |
| `yarn build`      | Build your static site, generating `./dist`              |
| `yarn deploy`     | Deploy your app to Observable                            |
| `yarn clean`      | Clear the local data loader cache                        |
| `yarn observable` | Run commands like `observable help`                      |



# Data transformation using data build tool (`dbt`)

Run the following:

```
brew install uv
uv pip compile requirements.in -o requirements.txt
python3 -m venv .venv
source .venv/bin/activate # or for fish: source .venv/bin/activate.fish
pip install -r requirements.txt
```

Then initialize the dbt project (only needs to be run once per repository):

```
dbt init data_processing
```

Edit the `profiles.yml` file appropriately in `/Users/me/.dbt/profiles.yml`:

```yaml
data_processing:
  target: dev
  outputs:
    dev:
      type: duckdb
      # path: 'file_path/database_name.duckdb'
      extensions:
        - httpfs
        - parquet
      settings:
        s3_region: my-aws-region
        # s3_access_key_id: "{{ env_var('S3_ACCESS_KEY_ID') }}"
        # s3_secret_access_key: "{{ env_var('S3_SECRET_ACCESS_KEY') }}"
```

## Creating a dbt model for opencorporates.com data
Then create a new model to transform the data, using the headers of the raw csv files downloaded from the FTP server:

```
> tar xvf opencorporates_2024-05-22.tar.gz
x opencorporates/
x opencorporates/us_mi/
x opencorporates/us_mn/
x opencorporates/us_nh/
x opencorporates/us_al/
x opencorporates/us_ky/
x opencorporates/us_ak/
x opencorporates/us_mt/
x opencorporates/us_ms/
x opencorporates/us_ga/
x opencorporates/us_ma/
x opencorporates/us_mo/
x opencorporates/us_ut/
x opencorporates/us_sc/
x opencorporates/us_sd/
x opencorporates/us_vt/
x opencorporates/us_va/
x opencorporates/ca_ns/
x opencorporates/us_tx/
x opencorporates/ca_bc/
x opencorporates/us_wy/
x opencorporates/ca/
x opencorporates/ca_nu/
x opencorporates/us_ri/
x opencorporates/us_wv/
x opencorporates/us_ca/
x opencorporates/us_co/
x opencorporates/ca_pe/
x opencorporates/us_fl/
x opencorporates/us_ct/
x opencorporates/us_ia/
x opencorporates/us_ok/
x opencorporates/us_in/
x opencorporates/ca_qc/
x opencorporates/us_ne/
x opencorporates/us_ks/
x opencorporates/pr/
x opencorporates/us_md/
x opencorporates/us_ny/
x opencorporates/us_az/
x opencorporates/us_de/
x opencorporates/us_hi/
x opencorporates/us_me/
x opencorporates/us_nj/
x opencorporates/us_nm/
x opencorporates/us_nd/
x opencorporates/us_nc/
x opencorporates/us_dc/
x opencorporates/us_nv/
x opencorporates/us_ar/
x opencorporates/us_pa/
x opencorporates/ca_on/
x opencorporates/ca_nl/
x opencorporates/ca_nb/
x opencorporates/us_tn/
x opencorporates/us_wa/
x opencorporates/date.txt
x opencorporates/us_wi/
x opencorporates/us_il/
x opencorporates/us_or/
x opencorporates/md5sum.txt
x opencorporates/us_la/
x opencorporates/us_id/
x opencorporates/us_oh/
x opencorporates/us_oh/companies.csv.gz
x opencorporates/us_oh/officers.csv.gz
x opencorporates/us_oh/additional_identifiers.csv.gz
x opencorporates/us_oh/non_reg_addresses.csv.gz
x opencorporates/us_oh/alternative_names.csv.gz
x opencorporates/us_id/companies.csv.gz
x opencorporates/us_id/officers.csv.gz
x opencorporates/us_id/additional_identifiers.csv.gz
x opencorporates/us_id/non_reg_addresses.csv.gz
x opencorporates/us_id/alternative_names.csv.gz
x opencorporates/us_la/companies.csv.gz
x opencorporates/us_la/officers.csv.gz
x opencorporates/us_la/additional_identifiers.csv.gz
x opencorporates/us_la/non_reg_addresses.csv.gz
x opencorporates/us_la/alternative_names.csv.gz
x opencorporates/us_or/companies.csv.gz
x opencorporates/us_or/officers.csv.gz
x opencorporates/us_or/additional_identifiers.csv.gz
x opencorporates/us_or/non_reg_addresses.csv.gz
x opencorporates/us_or/alternative_names.csv.gz
x opencorporates/us_il/companies.csv.gz
x opencorporates/us_il/officers.csv.gz
x opencorporates/us_il/additional_identifiers.csv.gz
x opencorporates/us_il/non_reg_addresses.csv.gz
x opencorporates/us_il/alternative_names.csv.gz
x opencorporates/us_wi/companies.csv.gz
x opencorporates/us_wi/officers.csv.gz
x opencorporates/us_wi/additional_identifiers.csv.gz
x opencorporates/us_wi/non_reg_addresses.csv.gz
x opencorporates/us_wi/alternative_names.csv.gz
x opencorporates/us_wa/companies.csv.gz
x opencorporates/us_wa/officers.csv.gz
x opencorporates/us_wa/additional_identifiers.csv.gz
x opencorporates/us_wa/non_reg_addresses.csv.gz
x opencorporates/us_wa/alternative_names.csv.gz
x opencorporates/us_tn/companies.csv.gz
x opencorporates/us_tn/officers.csv.gz
x opencorporates/us_tn/additional_identifiers.csv.gz
x opencorporates/us_tn/non_reg_addresses.csv.gz
x opencorporates/us_tn/alternative_names.csv.gz
x opencorporates/ca_nb/companies.csv.gz
x opencorporates/ca_nb/officers.csv.gz
x opencorporates/ca_nb/additional_identifiers.csv.gz
x opencorporates/ca_nb/non_reg_addresses.csv.gz
x opencorporates/ca_nb/alternative_names.csv.gz
x opencorporates/ca_nl/companies.csv.gz
x opencorporates/ca_nl/officers.csv.gz
x opencorporates/ca_nl/additional_identifiers.csv.gz
x opencorporates/ca_nl/non_reg_addresses.csv.gz
x opencorporates/ca_nl/alternative_names.csv.gz
x opencorporates/ca_on/companies.csv.gz
x opencorporates/ca_on/officers.csv.gz
x opencorporates/ca_on/additional_identifiers.csv.gz
x opencorporates/ca_on/non_reg_addresses.csv.gz
x opencorporates/ca_on/alternative_names.csv.gz
x opencorporates/us_pa/companies.csv.gz
x opencorporates/us_pa/officers.csv.gz
x opencorporates/us_pa/additional_identifiers.csv.gz
x opencorporates/us_pa/non_reg_addresses.csv.gz
x opencorporates/us_pa/alternative_names.csv.gz
x opencorporates/us_ar/companies.csv.gz
x opencorporates/us_ar/officers.csv.gz
x opencorporates/us_ar/additional_identifiers.csv.gz
x opencorporates/us_ar/non_reg_addresses.csv.gz
x opencorporates/us_ar/alternative_names.csv.gz
x opencorporates/us_nv/companies.csv.gz
x opencorporates/us_nv/officers.csv.gz
x opencorporates/us_nv/additional_identifiers.csv.gz
x opencorporates/us_nv/non_reg_addresses.csv.gz
x opencorporates/us_nv/alternative_names.csv.gz
x opencorporates/us_dc/companies.csv.gz
x opencorporates/us_dc/officers.csv.gz
x opencorporates/us_dc/additional_identifiers.csv.gz
x opencorporates/us_dc/non_reg_addresses.csv.gz
x opencorporates/us_dc/alternative_names.csv.gz
x opencorporates/us_nc/companies.csv.gz
x opencorporates/us_nc/officers.csv.gz
x opencorporates/us_nc/additional_identifiers.csv.gz
x opencorporates/us_nc/non_reg_addresses.csv.gz
x opencorporates/us_nc/alternative_names.csv.gz
x opencorporates/us_nd/companies.csv.gz
x opencorporates/us_nd/officers.csv.gz
x opencorporates/us_nd/additional_identifiers.csv.gz
x opencorporates/us_nd/non_reg_addresses.csv.gz
x opencorporates/us_nd/alternative_names.csv.gz
x opencorporates/us_nm/companies.csv.gz
x opencorporates/us_nm/officers.csv.gz
x opencorporates/us_nm/additional_identifiers.csv.gz
x opencorporates/us_nm/non_reg_addresses.csv.gz
x opencorporates/us_nm/alternative_names.csv.gz
x opencorporates/us_nj/companies.csv.gz
x opencorporates/us_nj/officers.csv.gz
x opencorporates/us_nj/additional_identifiers.csv.gz
x opencorporates/us_nj/non_reg_addresses.csv.gz
x opencorporates/us_nj/alternative_names.csv.gz
x opencorporates/us_me/companies.csv.gz
x opencorporates/us_me/officers.csv.gz
x opencorporates/us_me/additional_identifiers.csv.gz
x opencorporates/us_me/non_reg_addresses.csv.gz
x opencorporates/us_me/alternative_names.csv.gz
x opencorporates/us_hi/companies.csv.gz
x opencorporates/us_hi/officers.csv.gz
x opencorporates/us_hi/additional_identifiers.csv.gz
x opencorporates/us_hi/non_reg_addresses.csv.gz
x opencorporates/us_hi/alternative_names.csv.gz
x opencorporates/us_de/companies.csv.gz
x opencorporates/us_de/officers.csv.gz
x opencorporates/us_de/additional_identifiers.csv.gz
x opencorporates/us_de/non_reg_addresses.csv.gz
x opencorporates/us_de/alternative_names.csv.gz
x opencorporates/us_az/companies.csv.gz
x opencorporates/us_az/officers.csv.gz
x opencorporates/us_az/additional_identifiers.csv.gz
x opencorporates/us_az/non_reg_addresses.csv.gz
x opencorporates/us_az/alternative_names.csv.gz
x opencorporates/us_ny/companies.csv.gz
x opencorporates/us_ny/officers.csv.gz
x opencorporates/us_ny/additional_identifiers.csv.gz
x opencorporates/us_ny/non_reg_addresses.csv.gz
x opencorporates/us_ny/alternative_names.csv.gz
x opencorporates/us_md/companies.csv.gz
x opencorporates/us_md/officers.csv.gz
x opencorporates/us_md/additional_identifiers.csv.gz
x opencorporates/us_md/non_reg_addresses.csv.gz
x opencorporates/us_md/alternative_names.csv.gz
x opencorporates/pr/companies.csv.gz
x opencorporates/pr/officers.csv.gz
x opencorporates/pr/additional_identifiers.csv.gz
x opencorporates/pr/non_reg_addresses.csv.gz
x opencorporates/pr/alternative_names.csv.gz
x opencorporates/us_ks/companies.csv.gz
x opencorporates/us_ks/officers.csv.gz
x opencorporates/us_ks/additional_identifiers.csv.gz
x opencorporates/us_ks/non_reg_addresses.csv.gz
x opencorporates/us_ks/alternative_names.csv.gz
x opencorporates/us_ne/companies.csv.gz
x opencorporates/us_ne/officers.csv.gz
x opencorporates/us_ne/additional_identifiers.csv.gz
x opencorporates/us_ne/non_reg_addresses.csv.gz
x opencorporates/us_ne/alternative_names.csv.gz
x opencorporates/ca_qc/companies.csv.gz
x opencorporates/ca_qc/officers.csv.gz
x opencorporates/ca_qc/additional_identifiers.csv.gz
x opencorporates/ca_qc/non_reg_addresses.csv.gz
x opencorporates/ca_qc/alternative_names.csv.gz
x opencorporates/us_in/companies.csv.gz
x opencorporates/us_in/officers.csv.gz
x opencorporates/us_in/additional_identifiers.csv.gz
x opencorporates/us_in/non_reg_addresses.csv.gz
x opencorporates/us_in/alternative_names.csv.gz
x opencorporates/us_ok/companies.csv.gz
x opencorporates/us_ok/officers.csv.gz
x opencorporates/us_ok/additional_identifiers.csv.gz
x opencorporates/us_ok/non_reg_addresses.csv.gz
x opencorporates/us_ok/alternative_names.csv.gz
x opencorporates/us_ia/companies.csv.gz
x opencorporates/us_ia/officers.csv.gz
x opencorporates/us_ia/additional_identifiers.csv.gz
x opencorporates/us_ia/non_reg_addresses.csv.gz
x opencorporates/us_ia/alternative_names.csv.gz
x opencorporates/us_ct/companies.csv.gz
x opencorporates/us_ct/officers.csv.gz
x opencorporates/us_ct/additional_identifiers.csv.gz
x opencorporates/us_ct/non_reg_addresses.csv.gz
x opencorporates/us_ct/alternative_names.csv.gz
x opencorporates/us_fl/companies.csv.gz
x opencorporates/us_fl/officers.csv.gz
x opencorporates/us_fl/additional_identifiers.csv.gz
x opencorporates/us_fl/non_reg_addresses.csv.gz
x opencorporates/us_fl/alternative_names.csv.gz
x opencorporates/ca_pe/companies.csv.gz
x opencorporates/ca_pe/officers.csv.gz
x opencorporates/ca_pe/additional_identifiers.csv.gz
x opencorporates/ca_pe/non_reg_addresses.csv.gz
x opencorporates/ca_pe/alternative_names.csv.gz
x opencorporates/us_co/companies.csv.gz
x opencorporates/us_co/officers.csv.gz
x opencorporates/us_co/additional_identifiers.csv.gz
x opencorporates/us_co/non_reg_addresses.csv.gz
x opencorporates/us_co/alternative_names.csv.gz
x opencorporates/us_ca/companies.csv.gz
x opencorporates/us_ca/officers.csv.gz
x opencorporates/us_ca/additional_identifiers.csv.gz
x opencorporates/us_ca/non_reg_addresses.csv.gz
x opencorporates/us_ca/alternative_names.csv.gz
x opencorporates/us_wv/companies.csv.gz
x opencorporates/us_wv/officers.csv.gz
x opencorporates/us_wv/additional_identifiers.csv.gz
x opencorporates/us_wv/non_reg_addresses.csv.gz
x opencorporates/us_wv/alternative_names.csv.gz
x opencorporates/us_ri/companies.csv.gz
x opencorporates/us_ri/officers.csv.gz
x opencorporates/us_ri/additional_identifiers.csv.gz
x opencorporates/us_ri/non_reg_addresses.csv.gz
x opencorporates/us_ri/alternative_names.csv.gz
x opencorporates/ca_nu/companies.csv.gz
x opencorporates/ca_nu/officers.csv.gz
x opencorporates/ca_nu/additional_identifiers.csv.gz
x opencorporates/ca_nu/non_reg_addresses.csv.gz
x opencorporates/ca_nu/alternative_names.csv.gz
x opencorporates/ca/companies.csv.gz
x opencorporates/ca/officers.csv.gz
x opencorporates/ca/additional_identifiers.csv.gz
x opencorporates/ca/non_reg_addresses.csv.gz
x opencorporates/ca/alternative_names.csv.gz
x opencorporates/us_wy/companies.csv.gz
x opencorporates/us_wy/officers.csv.gz
x opencorporates/us_wy/additional_identifiers.csv.gz
x opencorporates/us_wy/non_reg_addresses.csv.gz
x opencorporates/us_wy/alternative_names.csv.gz
x opencorporates/ca_bc/companies.csv.gz
x opencorporates/ca_bc/officers.csv.gz
x opencorporates/ca_bc/additional_identifiers.csv.gz
x opencorporates/ca_bc/non_reg_addresses.csv.gz
x opencorporates/ca_bc/alternative_names.csv.gz
x opencorporates/us_tx/companies.csv.gz
x opencorporates/us_tx/officers.csv.gz
x opencorporates/us_tx/additional_identifiers.csv.gz
x opencorporates/us_tx/non_reg_addresses.csv.gz
x opencorporates/us_tx/alternative_names.csv.gz
x opencorporates/ca_ns/companies.csv.gz
x opencorporates/ca_ns/officers.csv.gz
x opencorporates/ca_ns/additional_identifiers.csv.gz
x opencorporates/ca_ns/non_reg_addresses.csv.gz
x opencorporates/ca_ns/alternative_names.csv.gz
x opencorporates/us_va/companies.csv.gz
x opencorporates/us_va/officers.csv.gz
x opencorporates/us_va/additional_identifiers.csv.gz
x opencorporates/us_va/non_reg_addresses.csv.gz
x opencorporates/us_va/alternative_names.csv.gz
x opencorporates/us_vt/companies.csv.gz
x opencorporates/us_vt/officers.csv.gz
x opencorporates/us_vt/additional_identifiers.csv.gz
x opencorporates/us_vt/non_reg_addresses.csv.gz
x opencorporates/us_vt/alternative_names.csv.gz
x opencorporates/us_sd/companies.csv.gz
x opencorporates/us_sd/officers.csv.gz
x opencorporates/us_sd/additional_identifiers.csv.gz
x opencorporates/us_sd/non_reg_addresses.csv.gz
x opencorporates/us_sd/alternative_names.csv.gz
x opencorporates/us_sc/companies.csv.gz
x opencorporates/us_sc/officers.csv.gz
x opencorporates/us_sc/additional_identifiers.csv.gz
x opencorporates/us_sc/non_reg_addresses.csv.gz
x opencorporates/us_sc/alternative_names.csv.gz
x opencorporates/us_ut/companies.csv.gz
x opencorporates/us_ut/officers.csv.gz
x opencorporates/us_ut/additional_identifiers.csv.gz
x opencorporates/us_ut/non_reg_addresses.csv.gz
x opencorporates/us_ut/alternative_names.csv.gz
x opencorporates/us_mo/companies.csv.gz
x opencorporates/us_mo/officers.csv.gz
x opencorporates/us_mo/additional_identifiers.csv.gz
x opencorporates/us_mo/non_reg_addresses.csv.gz
x opencorporates/us_mo/alternative_names.csv.gz
x opencorporates/us_ma/companies.csv.gz
x opencorporates/us_ma/officers.csv.gz
x opencorporates/us_ma/additional_identifiers.csv.gz
x opencorporates/us_ma/non_reg_addresses.csv.gz
x opencorporates/us_ma/alternative_names.csv.gz
x opencorporates/us_ga/companies.csv.gz
x opencorporates/us_ga/officers.csv.gz
x opencorporates/us_ga/additional_identifiers.csv.gz
x opencorporates/us_ga/non_reg_addresses.csv.gz
x opencorporates/us_ga/alternative_names.csv.gz
x opencorporates/us_ms/companies.csv.gz
x opencorporates/us_ms/officers.csv.gz
x opencorporates/us_ms/additional_identifiers.csv.gz
x opencorporates/us_ms/non_reg_addresses.csv.gz
x opencorporates/us_ms/alternative_names.csv.gz
x opencorporates/us_mt/companies.csv.gz
x opencorporates/us_mt/officers.csv.gz
x opencorporates/us_mt/additional_identifiers.csv.gz
x opencorporates/us_mt/non_reg_addresses.csv.gz
x opencorporates/us_mt/alternative_names.csv.gz
x opencorporates/us_ak/companies.csv.gz
x opencorporates/us_ak/officers.csv.gz
x opencorporates/us_ak/additional_identifiers.csv.gz
x opencorporates/us_ak/non_reg_addresses.csv.gz
x opencorporates/us_ak/alternative_names.csv.gz
x opencorporates/us_ky/companies.csv.gz
x opencorporates/us_ky/officers.csv.gz
x opencorporates/us_ky/additional_identifiers.csv.gz
x opencorporates/us_ky/non_reg_addresses.csv.gz
x opencorporates/us_ky/alternative_names.csv.gz
x opencorporates/us_al/companies.csv.gz
x opencorporates/us_al/officers.csv.gz
x opencorporates/us_al/additional_identifiers.csv.gz
x opencorporates/us_al/non_reg_addresses.csv.gz
x opencorporates/us_al/alternative_names.csv.gz
x opencorporates/us_nh/companies.csv.gz
x opencorporates/us_nh/officers.csv.gz
x opencorporates/us_nh/additional_identifiers.csv.gz
x opencorporates/us_nh/non_reg_addresses.csv.gz
x opencorporates/us_nh/alternative_names.csv.gz
x opencorporates/us_mn/companies.csv.gz
x opencorporates/us_mn/officers.csv.gz
x opencorporates/us_mn/additional_identifiers.csv.gz
x opencorporates/us_mn/non_reg_addresses.csv.gz
x opencorporates/us_mn/alternative_names.csv.gz
x opencorporates/us_mi/companies.csv.gz
x opencorporates/us_mi/officers.csv.gz
x opencorporates/us_mi/additional_identifiers.csv.gz
x opencorporates/us_mi/non_reg_addresses.csv.gz
x opencorporates/us_mi/alternative_names.csv.gz
```
