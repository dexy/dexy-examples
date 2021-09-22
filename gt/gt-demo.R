library(tidyverse)
library(paletteer)
library(gt)

gtsave(
pizzaplace %>%
  mutate(type = case_when(
    type == "chicken" ~ "chicken (pizzas with chicken as a major ingredient)",
    type == "classic" ~ "classic (classical pizzas)",
    type == "supreme" ~ "supreme (pizzas that try a little harder)",
    type == "veggie" ~ "veggie (pizzas without any meats whatsoever)",
  )) %>%
  mutate(size = factor(size, levels = c("S", "M", "L", "XL", "XXL"))) %>%
  dplyr::group_by(type, size) %>%
  dplyr::summarize(
    sold = n(),
    income = sum(price)
  ) %>%
  gt(rowname_col = "size") %>%
  tab_header(title = md("&#127829; Pizzas Sold in 2015 &#127829;")) %>%
  fmt_number(
    columns = vars(sold),
    decimals = 0,
    use_seps = TRUE
  ) %>%
  fmt_currency(
    columns = vars(income),
    currency = "USD"
  ) %>%
  cols_align(align = "right", columns = TRUE) %>%
  data_color(
    columns = vars(sold, income),
    colors = scales::col_numeric(
      palette = paletteer::paletteer_d(
        palette = "ggsci::red_material"
      ) %>% as.character(),
      domain = NULL
    ),
    alpha = 0.8
  ) %>%
  summary_rows(
    groups = TRUE,
    columns = vars(sold),
    fns = list(TOTAL = "sum"),
    formatter = fmt_number,
    decimals = 0,
    use_seps = TRUE
  ) %>%
  summary_rows(
    groups = TRUE,
    columns = vars(income),
    fns = list(TOTAL = "sum"),
    formatter = fmt_currency,
    currency = "USD"
  ) %>%
  grand_summary_rows(
    columns = vars(sold),
    fns = list(`GRAND TOTAL` = "sum"),
    formatter = fmt_number,
    decimals = 0,
    use_seps = TRUE
  ) %>%
  grand_summary_rows(
    columns = vars(income),
    fns = list(`GRAND TOTAL` = "sum"),
    formatter = fmt_currency,
    currency = "USD"
  ) %>%
  tab_footnote(
    footnote = "The pizza category with the highest total sales.",
    locations = cells_row_groups("classic (classical pizzas)")
  ) %>%
  tab_footnote(
    footnote = md("Custom sizes for **The Greek** pizza."),
    locations = cells_stub(c("XL", "XXL"))
  ) %>%
  tab_footnote(
    footnote = md("This is a new record. Truly, 2015 was a **great** year for the `pizzaplace`."),
    locations = cells_grand_summary(columns = vars(sold))
  ) %>%
  tab_options(
    summary_row.background.color = "#ACEACE80",
    grand_summary_row.background.color = "#990000",
    row_group.background.color = "#FFEFDB80",
    heading.background.color = "#EFFBFC",
    column_labels.background.color = "#EFFBFC",
    stub.background.color = "#EFFBFC",
    table.font.color = "#323232",
    table_body.hlines.color = "#989898",
    table_body.border.top.color = "#989898",
    heading.border.bottom.color = "#989898",
    row_group.border.top.color = "#989898",
    row_group.border.bottom.style = "none",
    stub.border.style = "dashed",
    stub.border.color = "#989898",
    stub.border.width = "1px",
    summary_row.border.color = "#989898",
    table.width = "60%"
  ) %>%
  opt_all_caps()
 , "pizza.html") 
