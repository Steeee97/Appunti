# Import delle librerie
library("utils")
library("ggplot2")
library("FactoMineR")
library("factoextra")
library("DataExplorer")
library("rpart")
library("rattle")         
library("RColorBrewer") 
library("caret")
library("ROCR")
library("pROC")

# Import dei dati
# Unione dei due dataset
temp_data <- read.csv("winequality-red.csv", header = TRUE, sep = ";")
temp_data2 <- read.csv("winequality-white.csv", header = TRUE, sep = ";")
color = "red"
temp_data <- cbind(temp_data, color)
color = "white"
temp_data2 <- cbind(temp_data2, color)
dataset <- rbind(temp_data, temp_data2)
# Eliminazione dei temp_data
rm(temp_data)
rm(temp_data2)

# Modifica dei valori del dataset
# Modifica per i colori
dataset$color[dataset$color == "white"] <- 1
dataset$color[dataset$color == "red"] <- 0  
dataset$color = as.factor(dataset$color)
# Modifica per la qualita, variabile target
dataset$quality[dataset$quality %in% c(1, 2, 3, 4, 5)] <- 0
dataset$quality[dataset$quality %in% c(6, 7, 8, 9)] <- 1
dataset$quality = as.factor(dataset$quality)

str(dataset)

# Controllo dei valori, verifichiamo che non siano nulli
sum(is.na(dataset))

# Plotting dei valori
# Funzione di plotting per variabili numeriche, in questo caso usata per alcohol
hist(dataset$alcohol, # histogram
     col="grey", # Colore delle colonne
     border="black", 
     prob = TRUE, # visualizza la densità al posto della frequenza di distribuzione
     xlab = "alcohol",
     main = "Distribuzione di Alcohol")
lines(density(dataset$alcohol), # density plot
      lwd = 2, # spessore linea
      col = "red")
# Plotting variabili categoriche
ggplot(data = dataset, aes(x = quality, fill = quality)) +
  geom_bar(stat = "count") +
  xlab("Valore") +
  ylab("Conteggio") +
  ggtitle("Attributo Quality") +
  labs(fill = "Quality") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_discrete(labels = c("Non Sufficiente", "Sufficiente"))

# Splitting training set e test set
split.dataset = function(dataset, p = 0.7, s = 1){
  set.seed(s)
  index = sample(1:dim(dataset)[1])
  train = dataset[index[1:floor(dim(dataset)[1] * p)], ]
  test = dataset[index[((ceiling(dim(dataset)[1] * p)) + 1):dim(dataset)[1]], ]
  return(list(train=train, test=test)) } 
allset= split.dataset(dataset, p = 0.7) 
# Generazione training set e test set
trainset = allset$train
testset = allset$test

# Controllo suddivisione variabile target nei due set
table.train = table(trainset$quality)
pie(table.train, col = c("orange", "blue"), labels = c("Insufficiente", "Sufficiente"))
table.train = table(testset$quality)
pie(table.train, col = c("orange", "blue"), labels = c("Insufficiente", "Sufficiente"))

# Controllo correlazione tra le var
plot_correlation(trainset, type = 'continuous')

# PCA (fatta su trainset)
pcaData <- trainset[, 1:11]
# PCA
res.pca <- PCA(pcaData, graph = FALSE)
# Eigenvalue
eig.val <- get_eigenvalue(res.pca)
eig.val
# Generazione Scree plot
fviz_eig(res.pca, addlabels = TRUE, ylim = c(0, 50))
# Correlazione variabili
fviz_pca_var(res.pca, col.var="black")
# Generazione grafico PCA individui
fviz_pca_ind(res.pca,
             geom.ind = "point",
             col.ind = trainset$quality,
             palette = c("#FC4E07", "#00AFBB"),
             legend.title = "Vini Sufficienti")

# Rimozione variabile total sulfur dioxide
to_drop = c("total.sulfur.dioxide")
trainset <- trainset[, !(names(trainset) %in% to_drop)]

# Factor names
levels(trainset$quality) <- c("notSuff", "Suff")
levels(testset$quality) <- c("notSuff", "Suff")

# Decision Tree
dt.control = trainControl(method = "cv", number = 10, classProbs = TRUE, summaryFunction = twoClassSummary) ## Guardare qua come mettere le altre opzioni
dt.model = train(quality ~ ., data=trainset, method="rpart", metric = "ROC", tuneLength = 5,
                     trControl = dt.control)
# Per il CP
dt.model$bestTune
plot(dt.model)
# Plotting dell'albero
fancyRpartPlot(dt.model$finalModel)
# Predizione
dt.pred = predict(dt.model, testset[,! names(testset) %in% c("quality")])
table(dt.pred, testset$quality)
# Generazione Confusion Matrix
result = confusionMatrix(dt.pred, testset$quality, mode = "prec_recall")
result
# Confusion Matrix su "suff"
result = confusionMatrix(dt.pred, testset$quality, positive = "Suff", mode = "prec_recall")
result
# Controllo sui tempi
dt.model$times

# ROC alberi
dt.probs = predict(dt.model, testset[,! names(testset) %in% c("quality")], type = "prob")
dt.ROC = roc(response = testset$quality, predictor = dt.probs$Suff,
             levels = levels(testset$quality))
plot(dt.ROC, print.thres="best", col = "blue")

# SVM
svm.control = trainControl(method = "cv", number = 10, classProbs = TRUE, summaryFunction = twoClassSummary)
svm.model = train(quality ~., data = trainset, method = "svmLinear", metric = "ROC",
                  trControl = svm.control)
svm.pred = predict(svm.model, testset[,! names(testset) %in% c("quality")])
table(svm.pred, testset$quality)
# Confusion Matrix su "not suff"
result = confusionMatrix(svm.pred, testset$quality, mode = "prec_recall")
result
# Confusion Matrix "suff"
result = confusionMatrix(svm.pred, testset$quality, positive = "Suff", mode = "prec_recall")
result

# ROC SVM
svm.probs = predict(svm.model, testset[,! names(testset) %in% c("quality")], type = "prob")
svm.ROC = roc(response = testset$quality, predictor = svm.probs$Suff,
             levels = levels(testset$quality))
plot(svm.ROC, print.thres="best", col = "red")
# Controllo sui tempi di SVM
svm.model$times

# Dotplot su ROC
cv.values = resamples(list(svm=svm.model, dt = dt.model))
summary(cv.values)
dotplot(cv.values, metric = "ROC")

# Generazione grafico per AUC
plot(svm.ROC, print.thres="best", col = "red", print.auc = TRUE, print.auc.y = 0.3, print.roc = FALSE, print.auc.x = 0.6)
plot(dt.ROC, print.thres="best", add=TRUE, col = "blue", print.auc = TRUE, print.auc.y =0.2, print.auc.x =0.6)
legend("bottomright", legend = c("SVM", "DT"), col = c("red", "blue"), lwd = 2)
