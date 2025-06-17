-- 1. Строки без пропущенных значений
{{ get_rows_without_nulls('raw', 'cytotox') }}

-- 2. Первые 5 столбцов
{{ get_first_n_columns('raw', 'cytotox') }}

-- 3. Подсчет NULL значений
{{ get_null_counts('raw', 'cytotox') }}

-- 4. кол-во пропущенных значений
{{ column_stats('raw', 'cytotox') }}