-- 1. Строки без пропущенных значений
{{ get_rows_without_nulls('raw', 'nanozymes') }}

-- 2. Первые 5 столбцов
{{ get_first_n_columns('raw', 'nanozymes') }}

-- 3. кол-во пропущенных значений
{{ column_stats('raw', 'nanozymes') }}