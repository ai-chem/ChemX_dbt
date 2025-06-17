-- 1. Строки без пропущенных значений
{{ get_rows_without_nulls('raw', 'benzimidazoles') }}

-- 2. Первые 5 столбцов
{{ get_first_n_columns('raw', 'benzimidazoles') }}

-- 3. кол-во пропущенных значений
{{ column_stats('raw', 'benzimidazoles') }}

{#-- 4. кол-во дубликатов#}
{##}
{#-- Подсчет дубликатов в таблице benzimidazoles#}
{#{{ count_full_duplicates('raw', 'benzimidazoles') }}#}