-- 1. Строки без пропущенных значений
{{ get_rows_without_nulls('raw', 'synergy') }}

-- 2. Первые 5 столбцов
{{ get_first_n_columns('raw', 'synergy') }}

-- 3. Подсчет NULL значений
{{ get_null_counts('raw', 'synergy') }}

-- 4. кол-во пропущенных значений
{{ column_stats('raw', 'synergy') }}