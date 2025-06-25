
### **1. Морфология и физико-химические свойства наночастиц**

| №   | column_name              | description                                                                        |
| --- | ------------------------ | ---------------------------------------------------------------------------------- |
| 0   | hydrodynamic_diameter_nm | Hydrodynamic size of nanoparticles in solution (in nm; if measured).               |
| 2   | zeta_potential_mv        | Surface charge of the nanoparticle (in mV; blank if not measured).                 |
| 14  | shape                    | Morphology (e.g., spherical, rod-shaped).                                          |
| 15  | np_size_max_nm           | Maximum nanoparticle size (in nm).                                                 |
| 16  | np_size_min_nm           | Minimum nanoparticle size (in nm).                                                 |
| 17  | np_size_avg_nm           | Average nanoparticle size (in nm).                                                 |
| 21  | coating                  | Surface coating/modification of the nanoparticle (if any “1”; "0" indicates none). |
| 29  | nanoparticle             | Name of the nanoparticle (e.g., Ag, Au, ZnO).                                      |
|     |                          |                                                                                    |

---

### **2. Условия синтеза наночастиц**

| №   | column_name                    | description                                                                        |
| --- | ------------------------------ | ---------------------------------------------------------------------------------- |
| 1   | ph_during_synthesis            | pH of the synthesis solution (if reported).                                        |
| 3   | temperature_for_extract_c      | Temperature during extract preparation (°C).                                       |
| 4   | duration_preparing_extract_min | Time taken to prepare the extract (in minutes).                                    |
| 5   | concentration_of_precursor_mm  | Molar concentration of the precursor (in mM).                                      |
| 6   | solvent_for_extract            | Solvent used in green synthesis (e.g., water, ethanol).                            |
| 7   | precursor_of_np                | Chemical precursor used (e.g., AgNO₃ for silver NPs).                              |
| 30  | np_synthesis                   | Synthesis method (e.g., green_synthesis, chemical synthesis).                      |

---

### **3. Биотесты и экспериментальные параметры**

| №   | column_name                | description                                                                        |
| --- | -------------------------- | ---------------------------------------------------------------------------------- |
| 8   | concentration              | Concentration of the nanoparticle required for ZOI (in µg/ml).                     |
| 9   | zoi_np_mm                  | Zone of Inhibition for the nanoparticle alone (in mm; if applicable).              |
| 11  | mic_np_µg_ml               | Minimum Inhibitory Concentration (MIC) of the nanoparticle (in µg/ml).             |
| 12  | mic_np_µg_ml_parsed        | Parsed or standardized value of MIC_NP (in µg/ml).                                 |
| 13  | time_set_hours             | Duration of the experiment (in hours).                                             |
| 28  | method                     | Assay type (e.g., MIC, ZOI).                                                       |

---

### **4. Бактерии и устойчивость**

| №   | column_name                | description                                                                        |
| --- | -------------------------- | ---------------------------------------------------------------------------------- |
| 10  | strain                     | Specific strain identifier (if provided; blank in sample).                         |
| 20  | bacteria                   | Bacterial strain tested (e.g., Enterococcus faecalis, Escherichia coli).           |
| 27  | mdr                        | Indicates multidrug-resistant strain (1 = Yes, 0 = No).                            |

---

### **5. Метаданные публикации и источника**

| №   | column_name                | description                                                                        |
| --- | -------------------------- | ---------------------------------------------------------------------------------- |
| 18  | access                     | Type of access to the publication (e.g., open, closed).                            |
| 19  | article_list               | Identifier for the article in the dataset.                                         |
| 22  | dbt_loaded_at              | Timestamp when the record was loaded into dbt.                                     |
| 23  | doi                        | Digital Object Identifier (DOI) of the article.                                    |
| 24  | is_oa                      | Article is Open Access (TRUE/FALSE).                                               |
| 25  | journal_is_oa              | Journal is Open Access (TRUE/FALSE).                                               |
| 26  | journal_name               | Name of the publishing journal.                                                    |
| 31  | oa_status                  | Open Access status (e.g., green, hybrid, closed).                                  |
| 32  | pdf                        | Link or path to the PDF of the article.                                            |
| 33  | publisher                  | Publisher of the article.                                                          |
| 34  | reference                  | Citation or URL to the study.                                                      |
| 35  | sn                         | Serial number or unique identifier for the record.                                 |
| 36  | source_table               | Name of the source table from which the data was extracted.                        |
| 37  | title                      | Title of the article.                                                              |
| 38  | year                       | Year of publication.                                                               |
