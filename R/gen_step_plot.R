
#' gen_step_plot : plot simulation vs observation
#'
#' @param df_simu the name of the dataframe of your model output
#' @param df_obs the name of the dataframe of your observations
#' @param variable_names the name of your model variables you want to plot
#' @param start_date select a start date if you don't want to plot the whole data and just want to zoom out
#' @param end_date select an end date if you don't want to plot the whole data and just want to zoom out
#' @param plot_type the type of plot you want. "ts" for time series and "sc" for scatter plot
#'
#'
#' @description gen_step_plot  plot time series and scatter plots of simulation versus observation for selected model variables.
#' in plot_type choose the type of plot you want. "ts" for time series and "sc" for scatter plot
#'
#'
#' @return time series or scatter plot (with R^2 and RMSE)
#' @export
#'
#'
#' @import dplyr
#' @importFrom stats lm
#' @importFrom lubridate ymd
#' @import ggplot2
#' @importFrom tidyr pivot_longer pivot_wider drop_na
#' @importFrom utils globalVariables
#'
#'
#' @examples
#' \dontrun{
#' gen_step_plot (variable_names, df_simu, df_obs, start_date=NULL, end_date=NULL,plot_type="ts")
#' }
#'
#'
#'
gen_step_plot <- function(variable_names,
                     df_simu, df_obs,
                     start_date=NULL,
                     end_date=NULL,
                     plot_type="ts") {
  Date<-Value<-simu<-Variable<-simulation<-observation<-R2<-RMSE<-NULL

  n_column <- if (length(variable_names) < 3) 1 else 2

  # Ensure Date columns are converted to Date class
  df_simu <- df_simu %>%
    select(all_of(c("Date", variable_names))) %>%
    mutate(simu = "simulation",
           Date = as.Date(Date))

  df_obs <- df_obs %>%
    select(all_of(c("Date", variable_names))) %>%
    mutate(simu = "observation",
           Date = as.Date(Date))

  # Combine data frames
  combined <- bind_rows(df_simu, df_obs)

  # Filter by date if specified
  if (!is.null(start_date) && !is.null(end_date)) {
    combined <- combined %>%
      filter(Date >= ymd(start_date) & Date <= ymd(end_date))
  }

  # Handle missing values
  combined <- combined %>%
    mutate(across(all_of(variable_names), na_if, NA))  # Convert to NA where appropriate

  if (plot_type == "ts") {
    # Reshape data into tidy format
    combined_tidy <- combined %>%
      pivot_longer(cols = all_of(variable_names), names_to = "Variable", values_to = "Value")

    # Plotting with ggplot2
    plt <- ggplot(combined_tidy, aes(x = Date, y = Value, color = simu)) +
      geom_line(data = filter(combined_tidy, simu == "simulation"), size = .45) +
      geom_point(data = filter(combined_tidy, simu == "observation"), size = .7) +
      labs(x = "Date", y = "") +
      scale_color_manual(values = c("simulation" = "black", "observation" = "red4")) +
      facet_wrap(~ Variable, scales = "free_y", ncol = n_column) +
      theme_minimal()+theme(legend.position = "bottom",legend.title = element_blank())

  } else {
    # Reshape data into tidy format
    combined_tidy <- combined %>%
      pivot_longer(cols = all_of(variable_names), names_to = "Variable", values_to = "Value") %>%
      pivot_wider(names_from = "simu", values_from = "Value")%>%
      drop_na()


    # Function to calculate RMSE
    rmse <- function(actual, predicted) {
      sqrt(mean((actual - predicted)^2, na.rm = TRUE))
    }

    # Calculate R^2, p-values, and RMSE
    summary_stats <- combined_tidy %>%
      group_by(Variable) %>%
      summarize(
        R2 = {
          data <- pick(everything())
          model <- lm(observation ~ simulation, data = data)
          summary(model)$r.squared
        },
        RMSE = {
          data <- pick(everything())
          rmse(data$observation, data$simulation)
        },
        .groups = 'drop'  # Drop grouping structure after summarizing
      )

    # Plotting with ggplot2
    plt <- ggplot(combined_tidy, aes(x = simulation, y = observation)) +
      geom_point(color="grey50") +
      geom_abline(intercept=0, slope=1, colour = "black", linetype = "dashed")+
      geom_smooth(method = "lm", se = FALSE, color = "grey30",size=.5) +  # Add linear regression line
      labs(x = "simulation", y = "observation") +
      facet_wrap(~ Variable, scales = "free", ncol = n_column) +
      theme_minimal() +
      geom_text(data = summary_stats, aes(label = paste0("R^2 =","=", round(R2, 2))),
                x = -Inf, y = Inf, hjust = -0.5, vjust = 5, size = 4, parse = TRUE,color = "red1")+
      geom_text(data = summary_stats, aes(label = paste0("RMSE =", "=",round(RMSE, 2))),
                x = -Inf, y = Inf, hjust = -0.2, vjust = 5, size = 4, parse = TRUE,color = "red1")
  }

  return(plt)
}
