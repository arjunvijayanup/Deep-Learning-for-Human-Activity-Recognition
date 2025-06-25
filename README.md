# Human Activity Recognition with Neural Networks

## Author

**Arjun Vijay Anup**

---

## Project Description

This repository contains a Quarto-based analysis and implementation of various neural network architectures for human activity recognition using wearable sensor data. Three models are compared:

- **Model 1:** 2-Layer Deep Neural Network (DNN) with Early Stopping
- **Model 2:** Tuned 4-Layer Deep Neural Network with Regularization and Dropout
- **Model 3:** 4-Layer Convolutional Neural Network (CNN) with Early Stopping, Dropout, and L2 regularization

The goal is to identify the most effective architecture for classifying 19 different activities recorded by 45 sensors over 5-second intervals.

---

## Table of Contents

1. [Repository Structure](#repository-structure)
2. [Data](#data)
3. [Environment & Dependencies](#environment--dependencies)
4. [Usage](#usage)
5. [Model Summaries](#model-summaries)
6. [Results](#results)
7. [License](#license)

---

## Repository Structure

```plaintext
├── ActivityRecognition-with-NN.qmd   # Quarto document with analysis and code
├── ActivityRecognition-with-NN.pdf    # Rendered PDF of the results
├── activity_recognition.Rdata         # Preprocessed sensor data
├── model_conf.R                       # Script for hyperparameter tuning (Model 2)
├── runs_dnn/                          # Directory containing tfruns outputs
├── README.md                          # Project overview (this file)
└── LICENSE                            # License information
```

---

## Data

- **activity_recognition.Rdata**: Contains three-dimensional arrays:
  - Training/Validation: 8170 × 125 × 45 (N × time steps × sensors)
  - Test: 950 × 125 × 45
- Each sample represents a 5-second recording across 45 sensors.
- A random subsample of 950 segments is held out for validation; the remainder is used for training. The test set is used for final evaluation.

---

## Environment & Dependencies

**R version ≥ 4.1**

Install required packages:

```bash
# In R or RStudio console:
install.packages(c(
  "quarto",
  "keras",
  "tfruns",
  "jsonlite",
  "tidyverse"
))
```

Ensure TensorFlow and Keras backend are configured:

```r
library(keras)
install_keras()
```

---

## Usage

1. **Clone the repository**
```bash
git clone https://github.com/<your-username>/Deep-Learning-for-Human-Activity-Recognition.git
cd ActivityRecognition-NN
```

2. **Render the Quarto document**
```bash
quarto render ActivityRecognition-with-NN.qmd
```
   This generates the PDF (`ActivityRecognition-with-NN.pdf`) with all analysis, code, and figures.

3. **Inspect models**
   - Open `ActivityRecognition-with-NN.qmd` in Quarto or RStudio
   - Run code chunks to reproduce model training and evaluation

---

## Model Summaries

- **Model 1 (2-Layer DNN):** 256 → 128 units, ReLU activations, RMSProp optimizer, early stopping on validation accuracy (patience = 20).
- **Model 2 (4-Layer Tuned DNN):** 512 → 256 → 128 → 64 units, ReLU activations, Adam optimizer, dropout & L2 regularization, hyperparameter tuning via `tfruns`, early stopping.
- **Model 3 (4-Layer CNN):** Three Conv2D + max-pooling layers, final dense layers with dropout and L2 regularization, Adam optimizer, early stopping.

Each architecture is evaluated by validation accuracy & loss, and the best model is further tested on the held-out test set.

---

## Results

The complete results—including training/validation curves, confusion matrix, and class-wise metrics—are available in the rendered PDF:

[View the Results (PDF)](ActivityRecognition-with-NN.pdf)

- **Best Model:** Model 3 (4-Layer CNN) achieved the highest validation accuracy (~99.2%) and strong generalization on the test set (≈98.7% accuracy).

---

