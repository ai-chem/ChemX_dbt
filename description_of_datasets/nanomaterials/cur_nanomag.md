
### 🧪 1. Экспериментальные данные

| №   | column_name                                | Описание                                   |
| --- | ------------------------------------------ | ------------------------------------------ |
| 0   | `zfc_h_meas`                               | Measurement field for ZFC magnetization    |
| 1   | `np_shell_2`                               | Composition/info for second shell          |
| 2   | `nanoparticle`                             | Sample name or ID                          |
| 3   | `xrd_scherrer_size`                        | XRD crystallite size via Scherrer equation |
| 4   | `np_hydro_size`                            | Hydrodynamic size (nm)                     |
| 5   | `instrument`                               | Instrument used for measurement            |
| 6   | `mri_r1`                                   | MRI relaxivity r1                          |
| 7   | `hc_koe`                                   | Coercive field in M-H loop (kOe)           |
| 8   | `htherm_sar`                               | Specific absorption rate (SAR)             |
| 9   | `mri_r2`                                   | MRI relaxivity r2                          |
| 10  | `vertical_loop_shift_m_vsl_emu_g_numeric`  | Vertical shift in M-H loop (numeric)       |
| 11  | `vertical_loop_shift_m_vsl_emu_g_original` | Исходное текстовое значение                |
| 12  | `emic_size`                                | Size estimated by electron microscopy      |
| 13  | `fc_field_t_numeric`                       | FC field (numeric, T)                      |
| 14  | `fc_field_t_original`                      | Исходное значение FC field                 |
| 15  | `exchange_bias_shift_oe_numeric`           | Exchange bias shift Heb (numeric, Oe)      |
| 16  | `exchange_bias_shift_oe_original`          | Исходное значение exchange shift           |
| 17  | `space_group_shell`                        | Crystallographic space group of shell      |
| 18  | `space_group_core`                         | Crystallographic space group of core       |
| 19  | `core_shell_formula`                       | Chemical formula of core/shell             |
| 20  | `squid_rem_mag_numeric`                    | SQUID remanent magnetization (numeric)     |
| 21  | `squid_rem_mag_original`                   | Исходное значение                          |
| 22  | `squid_sat_mag_numeric`                    | SQUID saturation magnetization (numeric)   |
| 23  | `squid_sat_mag_original`                   | Исходное значение                          |
| 24  | `np_shell`                                 | Shell composition or material              |
| 25  | `np_core`                                  | Core composition or material               |
| 26  | `coercivity_numeric`                       | Coercive force (numeric)                   |
| 27  | `coercivity_original`                      | Текстовое значение coercivity              |
| 28  | `squid_h_max`                              | Maximum magnetic field in SQUID            |
| 29  | `squid_temperature_numeric`                | SQUID temperature (numeric)                |
| 30  | `squid_temperature_original`               | Исходное значение температуры              |

---

### 📚 2. Метаданные статьи

| №   | column_name             | Описание                                |
| --- | ----------------------- | --------------------------------------- |
| 31  | `journal`               | Название журнала                        |
| 32  | `access`                | Доступ к статье: 1 = открыт, 0 = закрыт |
| 33  | `access_bool`           | Булевое представление access            |
| 34  | `publisher`             | Издатель статьи                         |
| 35  | `doi`                   | DOI публикации                          |
| 36  | `pdf`                   | Имя PDF файла                           |
| 37  | `title`                 | Название статьи                         |
| 38  | `year`                  | Год публикации                          |
| 39  | `supp`                  | Метка на дополнительную информацию/файл |
| 40  | `supp_info_name_folder` | Папка с supplementary-данными           |

---

### 🔁 3. Валидация и ручная проверка

| №   | column_name               | Описание                 |
| --- | ------------------------- | ------------------------ |
| 41  | `comment`                 | Комментарий валидации    |
| 42  | `has_mistake_in_matadata` | Флаг ошибок в метаданных |
| 43  | `verification_date`       | Дата ручной проверки     |
| 44  | `verification_required`   | Нужна ли проверка?       |
| 45  | `verified_by`             | Кто проводил валидацию   |

---

### 🧱 4. Служебные поля (dbt / загрузка / папки)

| №   | column_name           | Описание                        |
| --- | --------------------- | ------------------------------- |
| 46  | `article_name_folder` | Имя папки со статьёй            |
| 47  | `source_table`        | Исходная таблица                |
| 48  | `dbt_loaded_at`       | Время загрузки в dbt            |
| 49  | `dbt_curated_at`      | Время обработки на Curated-слое |
