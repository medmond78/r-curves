# Required libraries
library(ggplot2)

# Fresnel integrals using numerical integration
fresnel <- function(t, kappa_func = function(s) s) {
  # x(t) = integral from 0 to t of cos(kappa(s) * s^2 / 2) ds
  # y(t) = integral from 0 to t of sin(kappa(s) * s^2 / 2) ds
  
  integrate_numerically <- function(f, from, to, steps = 1000) {
    s <- seq(from, to, length.out = steps)
    h <- (to - from) / (steps - 1)
    sum(f(s)) * h
  }
  
  x <- integrate_numerically(function(s) cos(kappa_func(s) * s^2 / 2), 0, t)
  y <- integrate_numerically(function(s) sin(kappa_func(s) * s^2 / 2), 0, t)
  
  return(c(x, y))
}

# Generate points for the clothoid
generate_clothoid <- function(t_max, steps = 500, kappa_func = function(s) s) {
  t_values <- seq(0, t_max, length.out = steps)
  points <- sapply(t_values, function(t) fresnel(t, kappa_func))
  return(data.frame(t = t_values, x = points[1,], y = points[2,]))
}

# Different curvature functions (kappa(t))
kappa_linear <- function(s) s  # Standard clothoid: kappa(s) = s
kappa_quadratic <- function(s) s^2  # Quadratic variation: kappa(s) = s²
kappa_sqrt <- function(s) sqrt(abs(s))  # Square root variation: kappa(s) = √|s|
kappa_sine <- function(s) sin(s)  # Sinusoidal variation: kappa(s) = sin(s)

# Generate data for different curvature functions
clothoid_standard <- generate_clothoid(5, kappa_func = kappa_linear)
clothoid_standard$type <- "Linear: κ(t) = t"

clothoid_quadratic <- generate_clothoid(2.5, kappa_func = kappa_quadratic)
clothoid_quadratic$type <- "Quadratic: κ(t) = t²"

clothoid_sqrt <- generate_clothoid(8, kappa_func = kappa_sqrt)
clothoid_sqrt$type <- "Square Root: κ(t) = √|t|"

clothoid_sine <- generate_clothoid(8, kappa_func = kappa_sine)
clothoid_sine$type <- "Sine: κ(t) = sin(t)"


# Combine datasets
all_clothoids <- rbind(clothoid_standard, clothoid_quadratic, clothoid_sqrt, clothoid_sine)

# Additional curvature functions
kappa_exp <- function(s) exp(s/3) - 1  # Exponential: κ(t) = e^(t/3) - 1
kappa_step <- function(s) ifelse(s < 2.5, s, 5 - s)  # Step function

# Generate data
clothoid_exp <- generate_clothoid(3, kappa_func = kappa_exp)
clothoid_exp$type <- "Exponential: κ(t) = e^(t/3) - 1"

clothoid_step <- generate_clothoid(5, kappa_func = kappa_step)
clothoid_step$type <- "Step: κ(t) = t if t<2.5 else 5-t"

# Add to combined dataset
all_clothoids <- rbind(all_clothoids, clothoid_exp, clothoid_step)

# Plot with ggplot2
p <- ggplot(all_clothoids, aes(x, y, color = type)) +
  geom_path(size = 1) +
  theme_minimal() +
  labs(title = "Clothoid (Cornu) Curves with Various Curvature Functions",
       x = "x", y = "y", color = "Curvature Function") +
  coord_equal() +  # Equal scaling for x and y axes
  theme(legend.position = "bottom")

print(p)
