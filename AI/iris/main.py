from sklearn.datasets import load_iris
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import StandardScaler

iris = load_iris()

x = iris.data
y = iris.target

# 1:
print("Old traits:")
print(x)
print("=====================")
print("Labels:")
print(y)

# 2:

X_train, X_test, y_train, y_test = train_test_split(x, y, test_size=0.3, random_state=42)

print(f"Dim X_train: {X_train.shape}")
print(f"Dim X_test: {X_test.shape}")
print(f"Dim y_train: {y_train.shape}")
print(f"Dim y_test: {y_test.shape}")

# 3:

scaler = StandardScaler()
new_x = scaler.fit_transform(x)
print("New traits:")
print(new_x)


knn = KNeighborsClassifier(n_neighbors=3)

knn.fit(X_train, y_train)

y_pred = knn.predict(X_test)

print(f"Accuracy: {accuracy_score(y_test, y_pred)}")

plt.figure(figsize=(8,6))
plt.scatter(x[:, 0], x[:, 1], c=y, cmap='viridis')
plt.xlabel(iris.feature_names[0])
plt.ylabel(iris.feature_names[1])
plt.title("Scatter plot Iris Dataset")
plt.show()