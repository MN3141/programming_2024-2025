from sklearn.metrics import accuracy_score
from sklearn.datasets import load_wine
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier, plot_tree
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

#1
wine = load_wine()

#2
wine_pd = pd.DataFrame(data=wine.data,columns=wine.feature_names)
print(wine_pd.head(5))

#3
print(wine.feature_names)

#4
X_train, X_test, y_train, y_test = train_test_split(wine_pd[["alcohol", "flavanoids"]], wine.target, test_size=0.3, random_state=0)

tree = DecisionTreeClassifier(max_depth=2, random_state=0)
tree.fit(X_train,y_train)
plt.figure(figsize=(10, 6))
plot_tree(tree, feature_names=['alcohol', 'flavanoids'], class_names=wine.target_names, filled=True)
#plt.show()
print(wine_pd.columns[tree.tree_.feature[0]])

#5
depth_tree = DecisionTreeClassifier(max_depth=None, random_state=0)
depth_tree.fit(X_train,y_train)
plot_tree(tree, feature_names=['alcohol', 'flavanoids'], class_names=wine.target_names, filled=True)
y_pred = tree.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
print("Accuracy: ",accuracy)

#6
X_train, X_test, y_train, y_test = train_test_split(wine_pd, wine.target, test_size=0.3, random_state=0)
full_tree = DecisionTreeClassifier(max_depth=None, random_state=0)
full_tree.fit(X_train,y_train)
weights = full_tree.feature_importances_

for i in range(len(weights)):
    print(wine_pd.columns[i],": ",weights[i])