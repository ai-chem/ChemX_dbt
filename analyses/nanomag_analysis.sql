-- 1. Строки без пропущенных значений
{{ get_rows_without_nulls('raw', 'nanomag') }}

-- 2. Первые 5 столбцов
{{ get_first_n_columns('raw', 'nanomag') }}

-- 3. кол-во пропущенных значений
{{ column_stats('raw', 'nanomag') }}

-- 4. кол-во дубликатов
-- Подсчет дубликатов в таблице benzimidazoles
{{ count_full_duplicates('raw', 'nanomag') }}