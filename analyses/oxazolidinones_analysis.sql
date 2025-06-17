-- 1. Строки без пропущенных значений
{{ get_rows_without_nulls('raw', 'oxazolidinones') }}

-- 2. Первые 5 столбцов
{{ get_first_n_columns('raw', 'oxazolidinones') }}

-- 3. Подсчет NULL значений
{{ get_null_counts('raw', 'oxazolidinones') }}

-- 4. кол-во пропущенных значений
{{ column_stats('raw', 'oxazolidinones') }}