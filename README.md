# r-curves

This repository will contain multiple R scripts for generating and visualizing mathematical curves. The first script, `euler_spiral.R`, demonstrates how to create Euler spirals (clothoids) with various curvature functions using ggplot2.

## Features
- Numerical integration of Fresnel integrals
- Generation of clothoid curves with customizable curvature functions
- Visualization of curves with ggplot2

## Usage
1. Clone the repository:
   ```sh
   git clone https://github.com/<your-username>/r-curves.git
   ```
2. Open one of the R scripts (e.g., `euler_spiral.R`) in RStudio or VS Code.
3. Run the script to generate and plot the corresponding curve(s).

## Curvature Functions in `euler_spiral.R`
- Linear: κ(t) = t
- Quadratic: κ(t) = t²
- Square Root: κ(t) = √|t|
- Sine: κ(t) = sin(t)
- Exponential: κ(t) = e^(t/3) - 1
- Step: κ(t) = t if t < 2.5 else 5 - t

## Example Plot
Each script will produce a plot of the relevant curves. For example, `euler_spiral.R` produces a plot of clothoid curves for each curvature function, using different colors for each type.

## Requirements
- R
- ggplot2

## License
MIT
