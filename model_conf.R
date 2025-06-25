# setting default flags
FLAGS <- flags(
  flag_numeric("dropout", 0.4),
  flag_numeric("lambda", 0.01),
  flag_numeric("lr", 0.01),
  flag_numeric("bs", 100)
)

# model configuration
model2 <- keras_model_sequential() %>%
  layer_dense(units = 512, input_shape = V, activation = "relu", 
              name = "layer.1",
              kernel_regularizer = regularizer_l2(FLAGS$lambda)) %>%
  layer_dropout(rate = FLAGS$dropout) %>%
  layer_dense(units = 256, input_shape = V, activation = "relu",
              name = "layer.2",
              kernel_regularizer = regularizer_l2(FLAGS$lambda)) %>%
  layer_dropout(rate = FLAGS$dropout) %>%
  layer_dense(units = 128, activation = "relu",
              name = "layer.3",
              kernel_regularizer = regularizer_l2(FLAGS$lambda)) %>%
  layer_dropout(rate = FLAGS$dropout) %>%
  layer_dense(units = 64, activation = "relu",
              name = "layer.4",
              kernel_regularizer = regularizer_l2(FLAGS$lambda)) %>%
  layer_dropout(rate = FLAGS$dropout) %>%
  layer_dense(units = ncol(y.train), activation = "softmax", 
              name = "layer.out") %>%
  compile(loss = "categorical_crossentropy", metrics = "accuracy",
          optimizer = optimizer_adam(learning_rate = FLAGS$lr)
  )
# Seed for reproducibility
set.seed(24215155)
# training and evaluation
fit <- model2 %>% fit(
  x = x.train.dnn, y = y.train,
  validation_data = list(x.val.dnn, y.val),
  epochs = 100,
  batch_size = FLAGS$bs,
  verbose = 0,
  callbacks = callback_early_stopping(monitor = "val_accuracy", patience = 20)
)

# store accuracy on test set for each run
score <- model2 %>% evaluate(
  x.test.dnn, y.test,
  verbose = 0
)
