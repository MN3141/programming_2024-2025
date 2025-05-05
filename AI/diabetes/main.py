from sklearn.datasets import load_diabetes
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
from sklearn.metrics import r2_score
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

#1
diabetes = load_diabetes()
df = pd.DataFrame(data=diabetes.data, columns=diabetes.feature_names)

#2
print(df.head(5))

#3
print(df.columns)

#4
print(df.describe())

#5
# plt.hist(df["bmi"])
# plt.xlabel("Body Mass Index")
# plt.ylabel("Occurences")
# plt.show()

#6
# plt.scatter(df["bmi"],df["age"])
# plt.xlabel("Body Mass Index")
# plt.ylabel("Age")
# plt.show()

#7
X_train, X_test, y_train, y_test = train_test_split(df[["bmi"]], df[["age"]], test_size = 0.20)
eq_line = LinearRegression().fit(X_train,y_train)
#print(eq_line.coef_,eq_line.intercept_)
x_vals = np.linspace(X_train.min(), X_train.max(), 100).reshape(-1, 1)
y_vals = eq_line.predict(x_vals)
# plt.scatter(X_train,y_train)
# plt.plot(x_vals,y_vals)
# plt.show()
y_pred = eq_line.predict(X_test)

mse = mean_squared_error(y_test, y_pred)
print("MSE:",mse)

#8
x = df[["bmi","bp"]]
X_train, X_test, y_train, y_test = train_test_split(x, df[["age"]], test_size=0.20, random_state=42)
linear_reg = LinearRegression().fit(X_train,y_train)
print("BMI coef: ",linear_reg.coef_[0][0])
print("BP coef: ",linear_reg.coef_[0][1])
print("Bias: ",linear_reg.intercept_)
y_pred = linear_reg.predict(X_test)
r2 = r2_score(y_test, y_pred)
print("R^2 score: ",r2)
#print(linear_reg.coef_[1][0])