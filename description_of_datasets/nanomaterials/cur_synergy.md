
---

### 1. **Морфология и физико-химические свойства наночастиц**

| №   | column_name                                 | description                                                        |
| --- | ------------------------------------------- | ------------------------------------------------------------------ |
| 0   | nanoparticle                                | Name of the nanoparticle (e.g., Ag, Au, CuO).                      |
| 24  | np_size_min_nm                              | Minimum nanoparticle size (nm).                                    |
| 25  | np_size_min_nm_parsed                       | Parsed or standardized value of minimum nanoparticle size (nm).    |
| 26  | np_size_max_nm                              | Maximum nanoparticle size (nm).                                    |
| 27  | np_size_avg_nm                              | Average nanoparticle size (nm).                                    |
| 22  | shape                                       | Morphology (e.g., spherical, rod-shaped).                          |
| 12  | coating_with_antimicrobial_peptide_polymers | Surface modification with antimicrobial peptide/polymers (if any). |
| 14  | zeta_potential_mv                           | Surface charge of the nanoparticle (mV).                           |
| 15  | zeta_potential_mv_parsed                    | Parsed or standardized value of zeta potential (mV).               |

---

### 2. **Синтез наночастиц**

| №   | column_name                                      | description                                                                                   |
| --- | ------------------------------------------------ | --------------------------------------------------------------------------------------------- |
| 28  | np_synthesis                                     | Synthesis method (e.g., chemical synthesis, green synthesis).                                 |

---

### 3. **Информация о лекарстве/антибиотике**

| №   | column_name                                      | description                                                                                   |
| --- | ------------------------------------------------ | --------------------------------------------------------------------------------------------- |
| 19  | drug                                             | Name of the antibiotic/drug used in combination.                                              |
| 18  | drug_dose_µg_disk                                | Dosage/concentration of the drug (µg/disk).                                                  |
| 11  | peptide_mic                                      | MIC of any antimicrobial peptide used (µg/ml).                                                |

---

### 4. **Бактерии и устойчивость**

| №   | column_name                                      | description                                                                                   |
| --- | ------------------------------------------------ | --------------------------------------------------------------------------------------------- |
| 21  | bacteria                                         | Bacterial strain tested (e.g., Escherichia coli).                                             |
| 17  | strain                                           | Strain identifier (e.g., MTCC 443, ATCC 25922).                                               |
| 7   | mdr                                              | Multidrug-resistant strain (1 = Yes, 0 = No).                                                 |

---

### 5. **Антибактериальные метрики и синергия**

| №   | column_name                                      | description                                                                                   |
| --- | ------------------------------------------------ | --------------------------------------------------------------------------------------------- |
| 29  | method                                           | Assay type (e.g., MIC, disc_diffusion, well_diffusion).                                       |
| 20  | zoi_drug_mm_or_mic__µg_ml                        | Zone of Inhibition (mm) or MIC for the drug alone (µg/ml).                                    |
| 3   | error_zoi_drug_mm_or_mic_µg_ml                   | Error/standard deviation for drug-only measurement.                                            |
| 16  | zoi_np_mm_or_mic_np_µg_ml                        | Zone of Inhibition (mm) or MIC for the nanoparticle alone (µg/ml).                            |
| 8   | error_zoi_np_mm_or_mic_np_µg_ml                  | Error/standard deviation for NP-only measurement.                                              |
| 17  | zoi_drug_np_mm_or_mic_drug_np_µg_ml              | Zone of Inhibition (mm) or MIC for the drug + NP combination (µg/ml).                         |
| 4   | error_zoi_drug_np_mm_or_mic_drug_np_µg_ml        | Error/standard deviation for the combination.                                                  |
| 13  | fold_increase_in_antibacterial_activity          | Enhancement in activity due to synergy (fold change).                                         |
| 6   | fic                                              | Fractional Inhibitory Concentration (FIC) index value.                                         |
| 2   | effect                                           | Interaction type (e.g., synergistic, additive).                                               |
| 10  | combined_mic                                     | Combined MIC of antimicrobial peptides/polymers and NP.                                       |
| 23  | np_concentration_µg_ml                           | Concentration of the nanoparticle tested (µg/ml).                                             |

---

### 6. **Жизнеспособность бактерий**

| №   | column_name                                      | description                                                                                   |
| --- | ------------------------------------------------ | --------------------------------------------------------------------------------------------- |
| 44  | viability_%                                      | Bacterial viability post-treatment (%).                                                       |
| 1   | viability_error                                  | Error/standard deviation for viability.                                                       |

---

### 7. **Экспериментальные условия**

| №   | column_name                                      | description                                                                                   |
| --- | ------------------------------------------------ | --------------------------------------------------------------------------------------------- |
| 23  | time_hr                                          | Duration of exposure (hours).                                                                 |

---

### 8. **Метаданные публикации и источника**

| №   | column_name                                      | description                                                                                   |
| --- | ------------------------------------------------ | --------------------------------------------------------------------------------------------- |
| 30  | oa_status                                        | Open Access status (e.g., closed, hybrid).                                                    |
| 31  | access                                           | Type of access to the publication (e.g., open, closed).                                       |
| 32  | access_bool                                      | Boolean flag indicating open access (1) or closed (0).                                        |
| 33  | article_list                                     | Identifier for the article in the dataset.                                                    |
| 34  | dbt_loaded_at                                    | Timestamp when the record was loaded into dbt.                                                |
| 35  | doi                                              | Digital Object Identifier (DOI) of the article.                                               |
| 36  | is_oa                                            | Article is Open Access (True/False).                                                          |
| 37  | journal_is_oa                                    | Journal is Open Access (True/False).                                                          |
| 38  | journal_name                                     | Name of the publishing journal.                                                               |
| 39  | pdf                                              | Link or path to the PDF of the article.                                                       |
| 40  | publisher                                        | Publisher of the article.                                                                     |
| 41  | reference                                        | Citation or URL to the study.                                                                 |
| 42  | sn                                               | Serial number or unique identifier for the record.                                            |
| 43  | source_table                                     | Name of the source table from which the data was extracted.                                   |
| 45  | title                                            | Title of the article.                                                                         |
| 46  | year                                             | Year of publication.                                                                          |
